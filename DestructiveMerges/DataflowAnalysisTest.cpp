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
      std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>> in;
      std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>> out; 
      std::map<BasicBlock*, std::set<Value*>> used;
      std::map<BasicBlock*, std::set<Value*>> ueDefs;

      doDataflowAnalysis(F, in, out, used, ueDefs);

      for (BasicBlock& b : F)
      {
        errs() << "Basic block: " << b.getName() << " IN: ";
        for (std::pair<Value*, ConstantInt*> i : in[&b])
        {
          errs() << "<";
          errs()<< i.first->getName();
          errs() << ", ";
          i.second->print(errs());
          errs() << ">";
        }

        errs() << " OUT: ";
        for (std::pair<Value*, ConstantInt*> i : out[&b])
        {
          errs() << "<";
          errs()<< i.first->getName();
          errs() << ", ";
          i.second->print(errs());
          errs() << ">";
        }

        errs() << " USED: ";
        for (Value* i : used[&b])
        {
          errs() << i->getName();
          errs() << ",";
        }        

        errs() << " UEDEFS: ";
        for (Value* i : ueDefs[&b])
        {
          errs() << i->getName();
          errs() << ",";
        }
        errs() << "\n";

      }

      return false;
    }

    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.setPreservesAll();
    }

  };
}

char DataflowAnalysisTest::ID = 0;
static RegisterPass<DataflowAnalysisTest> X("DataflowAnalysisTest", "Computes stats for each function", true, true);

