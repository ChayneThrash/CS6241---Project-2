#ifndef DESTRUCTIVEMERGES_H_
#define DESTRUCTIVEMERGES_H_

#include "DataflowAnalysis.h"

using namespace llvm;

namespace{

	class DestructiveMerges{
	private:
		std::map<BasicBlock*, std::set<std::pair<BasicBlock*, BasicBlock*>>> killEdges;
		std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>>& out;
		std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>>& in;
		std::map<BasicBlock*, std::set<BasicBlock*>> influencedNodes;
		std::map<BasicBlock*, std::set<Value*>> defs_killed; 
    std::map<BasicBlock*, std::set<Value*>>& ueDefs;
		std::map<BasicBlock*, std::set<Value*>>& used;
		std::set<BasicBlock*> destructiveMerges;
		std::map<BasicBlock*, bool> visited;
		DominatorTree* DT;
		Function& F; 

	public:

		DestructiveMerges(Function& F_, 
											std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>>& in_,
											std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>>& out_, 
											std::map<BasicBlock*, std::set<Value*>>& used_,
										  std::map<BasicBlock*, std::set<Value*>>& ueDefs_,
											DominatorTree* DT) : out(out_), in(in_), ueDefs(ueDefs_), used(used_), F(F_){
			this->DT = DT;
		}
		
		// This must be called after destructiveMergesEnd()
		const  std::map<BasicBlock*, std::set<std::pair<BasicBlock*, BasicBlock*>>>& getKillEdges(){
			// To detect loops
			std::set<BasicBlock*> processedBlocks; 
			for(BasicBlock* B : destructiveMerges){
				std::queue<BasicBlock*> worklist;
				worklist.push(B);
				while(!worklist.empty()) {
					auto workItem = worklist.front();
					worklist.pop();
					TerminatorInst *T = workItem->getTerminator();
					for(unsigned int i = 0; i < T->getNumSuccessors(); i++){
						BasicBlock *successor = T->getSuccessor(i);

						if(influencedNodes[workItem].find(successor) == influencedNodes[workItem].end()
							and processedBlocks.find(successor) == processedBlocks.end()){
							processedBlocks.insert(successor);
							worklist.push(successor);
							continue;
						}

						if(isInRoI(B, workItem) and !(isInRoI(B, successor)))
								killEdges[B].insert(std::make_pair(workItem, successor));

					}
				}
			}
			return killEdges;
		}
		

		// This must be called after getInfluencedNodes()
		const std::set<BasicBlock*>& destructiveMergesEnd(){
			for(BasicBlock* B : destructiveMerges)
				if(influencedNodes[B].size() == 0)
					destructiveMerges.erase(B);
			return destructiveMerges;
		}

		const std::set<BasicBlock*>& destructiveMergesStart(){
			for(BasicBlock& BB : F){
				BasicBlock* B = &BB;
				for (auto it = pred_begin(B), et = pred_end(B); it != et; ++it){
					BasicBlock* P = *it;
					for(std::pair<Value*, ConstantInt*> def : out[P]){
						if(in[B].find(def) == in[B].end()){
							destructiveMerges.insert(B);
							defs_killed[B].insert(def.first);
						}
					}
				}
			}
			return destructiveMerges;
		}

		// This must be called after destructiveMergesStart()
		const std::map<BasicBlock*, std::set<Value*>>& getDefsKilled(){
			return defs_killed;
		}

		const std::map<BasicBlock*, std::set<BasicBlock*>>& getInfluencedNodes(){
			for(BasicBlock* B : destructiveMerges){
				for(Value* def : defs_killed[B]){
					for(auto U : def->users()){
						if(auto I =  dyn_cast<Instruction>(U)){
							BasicBlock* userBlock = I->getParent();
							if(isInfluenced(B, userBlock, def))
								influencedNodes[B].insert(userBlock);
						}
					}
				}
			}
			return influencedNodes;
		}

	private:

		bool isInRoI(BasicBlock* m, BasicBlock* n){
			// If u is not reachable, it is not in the RoI
			if(!(isReachable(m ,n)))
				return false;

			for(BasicBlock* u : influencedNodes[m])
				if(isReachable(n, u))
					return true;

			return false;
		}
		
		bool isReachable(BasicBlock* blockA, BasicBlock* blockB){
			// If it's the same block.. it is reachable
			if(blockA == blockB)
				return true;

			// If blockA dominates blockB, it is reachable
			if(DT->dominates(blockA, blockB))
				return true;

			visited.clear();

			// Otherwise, do that hard way and test with DFS 
			// Start the DFS with blockA as the starting node
			DFS(blockA, blockB);
			
			// If we could visit blockB with DFS originated from blockA, it is reachable
			if(visited[blockB])
				return true;	

			// Return false if we could not reach
			return false;
		}

		// Recursive Depth First Search 
		void DFS(BasicBlock* bb, BasicBlock* blockB){

			// Mark current block as visited 
			visited[bb] = true; 

			// We proved it reachable .. no need to continue .. 
			if(visited[blockB])
				return;

			// Iterate over the succcessor of the current block and
			// recursivly call DFS
                        TerminatorInst *T = bb->getTerminator();
			for(unsigned int i = 0; i < T->getNumSuccessors(); i++){

				BasicBlock *successor = T->getSuccessor(i);
				
				if(!visited[successor])
					DFS(successor, blockB);

			}
		}

		bool isInfluenced(BasicBlock* B, BasicBlock* userBlock, Value* var){
			// If the user block is not dominated by the merge block .. we dont handle this 
			// case and therefore just return false
			if(!(DT->dominates(B, userBlock)))
				return false;

			visited.clear();

			return def_reach(B, B, userBlock, var);
		}

		// This returns true if we reached the userBlock without a def of var along the path
		bool def_reach(BasicBlock* startBlock, BasicBlock* currentBlock, BasicBlock* userBlock, Value* var){

			visited[currentBlock] = true; 

			// Is the current block a merge point where the def is killed? 
			if(currentBlock != startBlock and defs_killed[currentBlock].find(var) != defs_killed[currentBlock].end())
				return false;

			// We found a def in this path.. 
			if(isDefinedHere(currentBlock, var))
				return false;

			// Did we reach the userBlock? We must have not met any defs
			if(currentBlock == userBlock)
				return true;

			// Otherwise continue the path and look for defs or reach the userBlock

			bool isUserBlockReached = false;			
	
			TerminatorInst *T = currentBlock->getTerminator();
			for(unsigned int i = 0; i < T->getNumSuccessors(); i++){
				BasicBlock *successor = T->getSuccessor(i);
		
				if(!visited[successor])
					isUserBlockReached |= def_reach(startBlock, successor, userBlock, var);

			}
	
			return isUserBlockReached;
		}


		bool isDefinedHere(BasicBlock* B, Value* var){
			return !(ueDefs[B].find(var) == ueDefs[B].end());
		}

	};
}
#endif
