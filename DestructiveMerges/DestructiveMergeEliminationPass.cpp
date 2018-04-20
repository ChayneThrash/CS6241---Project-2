#include "MakeSplitGraph.h"
#include "DestructiveMerges.h"

namespace {
  class DestructiveMergeEliminationPass : public FunctionPass {
  private:

  public:
    static char ID;
    Module* m;

    DestructiveMergeEliminationPass() : FunctionPass(ID) {}


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
      
      DominatorTree DT(F);

      DestructiveMerges DM(F, in, out, used, ueDefs, &DT);
      
      // Required: Set the destructive merges set
      DM.destructiveMergesStart();
      // Required: Compute Influenced Blocks
      // Note that getInfluencedNodes() must be called, even if we dont want to store the value
      std::map<BasicBlock*, std::set<BasicBlock*>> influencedNodes = DM.getInfluencedNodes();
      // Required: Get the influential destructive merge blocks
      std::set<BasicBlock*> destructiveMerges = DM.destructiveMergesEnd();
      // Optional: Get RoI
      std::map<BasicBlock*, std::set<BasicBlock*>> RoI = DM.getRoIs();
      // Required: Get kill Edges
      std::map<BasicBlock*, std::set<std::pair<BasicBlock*, BasicBlock*>>> killEdges = DM.getKillEdges();
      // Optional: Get Killed Defs at the merge block
      std::map<BasicBlock*, std::set<Value*>> defs_killed = DM.getDefsKilled();

      makeSplitGraph(destructiveMerges, killEdges, DT);
      doCopyPropagation(F);
      return true;
    }

    void getAnalysisUsage(AnalysisUsage &AU) const override {
    }

    void doCopyPropagation(Function& F) {
      std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>> in;
      std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>> out; 
      std::map<BasicBlock*, std::set<Value*>> used;
      std::map<BasicBlock*, std::set<Value*>> ueDefs;

      doDataflowAnalysis(F, in, out, used, ueDefs);


      for (BasicBlock& b : F)
      {
        std::map<Value*, ConstantInt*> loadSet;
        for(Instruction& instruction : b)
        {

          for (int i = 0; i < instruction.getNumOperands(); ++i)
          {
            Value* valueToReplace = instruction.getOperand(i); 
            auto isVariablePredicate = [valueToReplace](std::pair<Value*, ConstantInt*> p) { return p.first == valueToReplace; };
            if (instruction.getOpcode() == Instruction::Load)
            {
              auto result = std::find_if(out[&b].begin(), out[&b].end(), isVariablePredicate);
              if (result != out[&b].end())
              {
                loadSet[&instruction] = result->second;
              }
            }
            else if (i == 1 && instruction.getOpcode() == Instruction::Store)
            {
              auto result = std::find_if(out[&b].begin(), out[&b].end(), isVariablePredicate); 
              if (result != out[&b].end())
              {
                out[&b].erase(result);
                if (isa<ConstantInt>(instruction.getOperand(0)))
                {
                  out[&b].insert(std::make_pair(valueToReplace, dyn_cast<ConstantInt>(instruction.getOperand(0))));
                }
              }
            }
            else
            {
              auto result = std::find_if(out[&b].begin(), out[&b].end(), isVariablePredicate);
              if (result != out[&b].end())
              {
                instruction.setOperand(i, result->second);
              }
              else
              {
                if (loadSet.count(valueToReplace) > 0)
                {
                  instruction.setOperand(i, loadSet[valueToReplace]);
                }
              }
            }
          }
        }
      }
    }

  };
}

char DestructiveMergeEliminationPass::ID = 0;
static RegisterPass<DestructiveMergeEliminationPass> X("DestructiveMergeEliminationPass", "Computes stats for each function", true, false);

