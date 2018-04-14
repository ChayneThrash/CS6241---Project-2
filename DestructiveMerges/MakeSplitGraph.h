#ifndef MAKESPLITGRAPH_H_
#define MAKESPLITGRAPH_H_

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

BasicBlock* copy(BasicBlock* b)
{
  ValueToValueMapTy vMap;
  return llvm::CloneBasicBlock(b, vMap, "", b->getParent());
}

void replaceSuccessor(BasicBlock* b, BasicBlock* old, BasicBlock* newBlock)
{
  TerminatorInst* terminator = b->getTerminator();

  if (terminator->getSuccessor(0) == old)
  {
    terminator->setSuccessor(0, newBlock);
  }
  else 
  {
    terminator->setSuccessor(1, newBlock);
  }
}

void makeSplitGraph(std::set<BasicBlock*> destructiveMerges, std::map<BasicBlock*, std::set<std::pair<BasicBlock*, BasicBlock*>>> killEdges)
{
  Function* f = nullptr;
  if (destructiveMerges.size() > 0)
  {
    f = (*(destructiveMerges.begin()))->getParent();
  }

  std::queue<BasicBlock*> destructiveMergeWorkList;
  for(BasicBlock* b : destructiveMerges)
  {
    destructiveMergeWorkList.push(b);
  }

  while (destructiveMergeWorkList.size() > 0)
  {
    BasicBlock* destructiveMerge = destructiveMergeWorkList.front();
    destructiveMergeWorkList.pop();

    for (BasicBlock* p : predecessors(destructiveMerge))
    {
      std::queue<BasicBlock*> worklist;
      std::set<BasicBlock*> visited;
      std::map<BasicBlock*, BasicBlock*> copyMap;
      std::set<BasicBlock*> otherDestructiveMerges;

      copyMap[destructiveMerge] = copy(destructiveMerge);

      replaceSuccessor(p, destructiveMerge, copyMap[destructiveMerge]);

      worklist.push(destructiveMerge);
      visited.insert(destructiveMerge);

      while (worklist.size() > 0)
      {
        BasicBlock* currentWorkItem = worklist.front();
        worklist.pop();

        BasicBlock* workItemCopy = nullptr;
        if (copyMap.count(currentWorkItem) > 0)
        {
          workItemCopy = copyMap[currentWorkItem];
        }
        else
        {
          workItemCopy = copy(currentWorkItem);
          copyMap[currentWorkItem] = workItemCopy;
        }

        for (BasicBlock* s : successors(currentWorkItem))
        {
          if (killEdges[destructiveMerge].count(std::make_pair(currentWorkItem, s)) == 0)
          {
            BasicBlock* sCopy = nullptr;
            if (copyMap.count(s) > 0)
            {
              sCopy = copyMap[s];
            }
            else
            {
              sCopy = copy(s);
              copyMap[s] = sCopy;
            }

            replaceSuccessor(workItemCopy, s, sCopy);
            if (visited.count(s) == 0)
            {
              worklist.push(s);
              visited.insert(s);
            }

            if (destructiveMerges.count(s) > 0 && s != destructiveMerge)
            {
              otherDestructiveMerges.insert(s);
            }

          }
        }
      }

      for (BasicBlock* otherDestructiveMerge : otherDestructiveMerges)
      {
        BasicBlock* otherDestructiveMergeCopy = copyMap[otherDestructiveMerge];
        destructiveMergeWorkList.push(otherDestructiveMergeCopy);
        for (std::pair<BasicBlock*, BasicBlock*> killEdge : killEdges[otherDestructiveMerge])
        {
          BasicBlock* from = (copyMap.count(killEdge.first) > 0) ? copyMap[killEdge.first] : killEdge.first;
          BasicBlock* to = (copyMap.count(killEdge.second) > 0) ? copyMap[killEdge.second] : killEdge.second;
          killEdges[otherDestructiveMergeCopy].insert(std::make_pair(from, to));
        }
      }

    }
  }

}

#endif