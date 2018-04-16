#ifndef DATAFLOWANALYSIS_H_
#define DATAFLOWANALYSIS_H_

#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Constants.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/CFG.h"
#include "llvm/IR/Dominators.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/CodeGen/UnreachableBlockElim.h"

#include <set>
#include <queue>
#include <map>
#include <stack>
#include <tuple>
#include <algorithm>

using namespace llvm;

void computeInSet(BasicBlock* b, std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>>& outSets, std::set<std::pair<Value*, ConstantInt*>>& inSet)
{
  for(BasicBlock* p : predecessors(b))
  {
    for(std::pair<Value*, ConstantInt*> o : outSets[p])
    {
      inSet.insert(o);
    }
  }

  std::set<std::pair<Value*, ConstantInt*>> toRemove;
  for(std::pair<Value*, ConstantInt*> i : inSet)
  {
    for(BasicBlock* p : predecessors(b))
    {
      if (outSets[p].count(i) == 0)
      {
        toRemove.insert(i);
        break;
      }
    }
  }

  for(std::pair<Value*, ConstantInt*> r : toRemove)
  {
    inSet.erase(inSet.find(r));
  }
}

void doDataflowAnalysis(Function& f, 
        std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>>& in, 
        std::map<BasicBlock*, std::set<std::pair<Value*, ConstantInt*>>>& out, 
        std::map<BasicBlock*, std::set<Value*>>& used,
        std::map<BasicBlock*, std::set<Value*>>& ueDefs)
{
  std::map<BasicBlock*, std::map<Value*, Value*>> deDefs;
  for (BasicBlock& b : f)
  {
    for(Instruction& i : b)
    {
      if (i.getOpcode() == Instruction::Store)
      {
        used[&b].insert(i.getOperand(0));
        if (ueDefs[&b].count(i.getOperand(1)) == 0 && used[&b].count(i.getOperand(1)) == 0)
        {
          ueDefs[&b].insert(i.getOperand(1));
        }
        deDefs[&b][i.getOperand(1)] = i.getOperand(0);
      }
      else
      {
        for(int opIndex = 0; opIndex < i.getNumOperands(); ++opIndex)
        {
          used[&b].insert(i.getOperand(opIndex));
        }
      }
    }
  }

  for (BasicBlock& b : f)
  {
    for(std::pair<Value*, Value*> deDef : deDefs[&b])
    {
      if (isa<ConstantInt>(deDef.second))
      {
        out[&b].insert(std::make_pair(deDef.first, dyn_cast<ConstantInt>(deDef.second)));
      }
    }
  }

  for (BasicBlock& b : f)
  {
    for(BasicBlock* p : predecessors(&b))
    {
      for(std::pair<Value*, ConstantInt*> o : out[p])
      {
        out[&b].insert(o);
      }
    }
  }

  std::set<BasicBlock*> worklist;
  for(BasicBlock& b : f)
  {
    if (out[&b].size() > 0)
    {
      for(BasicBlock* s : successors(&b))
      {
        worklist.insert(s);
      }
    }
  }

  while(worklist.size() > 0)
  {
    auto bIter = worklist.begin();
    worklist.erase(bIter);
    BasicBlock* b = *bIter;

    std::set<std::pair<Value*, ConstantInt*>> inSet;
    computeInSet(b, out, inSet);

    for(std::pair<Value*, Value*> deDef : deDefs[b])
    {
      auto isVariablePredicate = [&deDef](std::pair<Value*, ConstantInt*> p) { return p.first == deDef.first; };
      auto result = std::find_if(inSet.begin(), inSet.end(), isVariablePredicate);
      if (result != inSet.end())
      {
        inSet.erase(result);
      }
      if (isa<ConstantInt>(deDef.second))
      {
        inSet.insert(std::make_pair(deDef.first, dyn_cast<ConstantInt>(deDef.second)));
      }
    }

    size_t priorOutSetSize = out[b].size();
    out[b].clear();
    for(std::pair<Value*, ConstantInt*> i : inSet)
    {
      out[b].insert(i);
    }

    if (out[b].size() > priorOutSetSize)
    {
      for (BasicBlock* s : successors(b))
      {
        worklist.insert(s);
      }
    }
  }

  for (BasicBlock& b : f)
  {
    computeInSet(&b, out, in[&b]);
  }

}


#endif