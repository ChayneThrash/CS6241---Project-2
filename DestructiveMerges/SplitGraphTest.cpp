#include "MakeSplitGraph.h"

namespace {
  class SplitGraphTest : public FunctionPass {
  private:

  public:
    static char ID;
    Module* m;

    SplitGraphTest() : FunctionPass(ID) {}


    bool doInitialization(Module &M) override {
      m = &M;
      return false;
    }
    bool runOnFunction(Function &F) override {

      BasicBlock* dMerge;

      std::set<BasicBlock*> destructiveMerges;
      std::map<BasicBlock*, std::set<std::pair<BasicBlock*, BasicBlock*>>> killEdges;
      for (BasicBlock& b : F)
      {
        if (b.getName() == "if.end")
        {
          destructiveMerges.insert(&b);
          dMerge = &b;
        }
      }

      for (BasicBlock& b : F)
      {
        if (b.getName() == "while.end")
        {
          for (BasicBlock* s : successors(&b))
          {
            killEdges[dMerge].insert(std::make_pair(&b, s));
          }
        }
      }

      makeSplitGraph(destructiveMerges, killEdges);
      for(BasicBlock& b : F)
      {
        errs() << "basic block: " << b.getName() << "\n";
        for (Instruction& i : b)
        {
          i.print(errs());
          errs() << "\n";
        }
        errs() << "\n";
      }
      return true;
    }

    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.setPreservesAll();
    }

  };
}

char SplitGraphTest::ID = 0;
static RegisterPass<SplitGraphTest> X("SplitGraphTest", "Computes stats for each function", true, false);

