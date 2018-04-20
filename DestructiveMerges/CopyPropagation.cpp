#include "DataflowAnalysis.h"

namespace {
  class CopyPropagationPass : public FunctionPass {
  private:

  public:
    static char ID;
    Module* m;

    CopyPropagationPass() : FunctionPass(ID) {}


    bool doInitialization(Module &M) override {
      m = &M;
      return false;
    }
    bool runOnFunction(Function &F) override {
      

      return true;
    }

    void getAnalysisUsage(AnalysisUsage &AU) const override {
    }

  };
}

char CopyPropagationPass::ID = 0;
static RegisterPass<CopyPropagationPass> X("CopyPropagation", "", true, false);

