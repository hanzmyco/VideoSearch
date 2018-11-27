#include <iostream>
#include <cassert>
#include <cstdlib>
#include <sstream>

#include "data.h"

#include "custom_space.h"
#include "init.h"
#include "index.h"
#include "params.h"
#include "rangequery.h"
#include "knnquery.h"
#include "knnqueue.h"
#include "methodfactory.h"

#include "ztimer.h"

#define REP_QTY 1000

#ifdef _MSC_VER
#include <windows.h>
#endif

using namespace std;
using namespace similarity;

#define LOG_OPTION 1

void Usage(const char *pProg, const char* pErr) {
  cerr << pErr << endl;
  cerr << "Usage: " << pProg << " <test file> " << endl;
  cerr << "Usage: " << pProg << " <test file> <max #of vectors> " << endl;
  cerr << "Usage: " << pProg << endl;
};

/*
 * Define an implementation of the distance function.
 */
struct DistL2 {
  /*
   * Important: the function is const and arguments are const as well!!!
   */
  float operator()(const float* x, const float* y, size_t qty) const {
    float res = 0;
    for (size_t i = 0; i < qty; ++i) res+=(x[i]-y[i])*(x[i]-y[i]);
    return sqrt(res);
  }
};

void printResults(KNNQuery<float>* qobj) {
  KNNQueue<float>* res = qobj->Result()->Clone();

  while (!res->Empty()) {
    cout << res->TopObject()->id() << " : " << res->TopDistance() << endl;
    res->Pop();
  }
  delete res;
}

void printResults(RangeQuery<float>* qobj) {
  const ObjectVector&    objs = *qobj->Result();
  const vector<float>&    dists = *qobj->ResultDists();

  for (size_t i = 0; i < objs.size(); ++i) {
    cout << objs[i]->id() << " : " << dists[i] << endl;
  }
}

template <class QueryType>
void doSearch(Index<float>* index, QueryType* qobj, int repQty) {
  WallClockTimer timer;

  /*
   * In this example we repeat the search many times,
   * but only because we need to measure the result
   * properly.
   */
  for (int i = 0; i < repQty; ++i) {
     index->Search(qobj);
	 if (i + 1 < repQty) qobj->Reset(); // This is needed b/c we reuse the same query many times
  }

  timer.split();

  cout << "Search " << qobj->Type() << " using index: " << index->StrDesc()
	   << " repeated: " << repQty << " times " << endl;
  cout << "Avg time:  " << timer.elapsed()/1000.0/repQty << " ms" << endl;
  cout << "# of results: " << qobj->ResultSize() << endl;

  printResults(qobj);
}
class Wrapper(){
  Wrapper(char * data_block,char * query);
}
