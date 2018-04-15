#include "DataflowAnalysis.h"

namespace {
  class DataflowAnalysisTest : public FunctionPass {
  private:

  public:
    static char ID;
    Module* m;

    DataflowAnalysisTest() : FunctionPass(ID) {}


    bool doInitialization(Module &M) override {
      m = &M;
      return false;
    }
    bool runOnFunction(Function &F) override {

      return false;
    }

    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.setPreservesAll();
    }

  };
}

char DataflowAnalysisTest::ID = 0;
static RegisterPass<DataflowAnalysisTest> X("DataflowAnalysisTest", "Computes stats for each function", true, true);

