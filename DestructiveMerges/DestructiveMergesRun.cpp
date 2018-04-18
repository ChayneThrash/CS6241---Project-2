#include "DestructiveMerges.h"

namespace {
  class DestructiveMergesRun : public FunctionPass {
  private:

  public:
    static char ID;
    Module* m;

    DestructiveMergesRun() : FunctionPass(ID) {}


    bool doInitialization(Module &M) override {
      m = &M;
      return false;
    }
    bool runOnFunction(Function &F) override {
			// Get the data flow analysis for the current function
      std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>> in;
      std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>> out; 
      std::map<BasicBlock*, std::set<Value*>> used;
      std::map<BasicBlock*, std::set<Value*>> ueDefs;
      doDataflowAnalysis(F, in, out, used, ueDefs);
			
			DominatorTree* DT = new DominatorTree(F);

			DestructiveMerges* DM = new DestructiveMerges(F, in, out, used, ueDefs, DT);
			
			// Set the destructive merges set
			DM->destructiveMergesStart();
			// Compute Influenced Blocks
			std::map<BasicBlock*, std::set<BasicBlock*>> influencedNodes = DM->getInfluencedNodes();
			// Get the influential destructive merge blocks
			std::set<BasicBlock*> destructiveMerges = DM->destructiveMergesEnd();
			// 
			std::map<BasicBlock*, std::set<std::pair<BasicBlock*, BasicBlock*>>> killEdges = DM->getKillEdges();

			for(BasicBlock* B : destructiveMerges){
				errs() << "[*] Block (" << B->getName() << ") is a destructive merge block.\n";
				errs() << "[!] Influenced Blocks: ";
				for(auto BB : influencedNodes[B])
					errs() << BB->getName() << " ";	
				errs()<<"\n";
				errs() << "[!] Kill Edges: ";
				for(auto BB : killEdges[B])
					errs() << "(" << BB.first->getName() << "->" << BB.second->getName() << ") ";	
				errs()<<"\n";
			}

			

      return false;
    }

    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.setPreservesAll();
    }

  };
}

char DestructiveMergesRun::ID = 0;
static RegisterPass<DestructiveMergesRun> X("DestructiveMergesRun", "Apply the Destructive Merges to perform Constant Propagation", true, true);

