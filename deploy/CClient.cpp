#include "CClient.hpp"

CClient::CClient(const std::string &strHost, int nPort, int nTimeout, int nConnNum)
{
  connStatus = Connect(strHost, nPort, nTimeout, nConnNum);
}

int CClient::Connect(const std::string &strHost, int nPort, int nTimeout, int nConnNum){
  return redisCli.Initialize(strHost, nPort, nTimeout, nConnNum));
}

int Get(std::string strKey,str::string *strVal){
  if (connStatu){
    if((redisCli.Get(strKey, &strVal) == RC_SUCCESS)){
        return 0;
    }
    return 1;
  }
  else{
    std::cerr<<"connection failed";
  }
}

void Set(std::string strKey,std::string strValue){
  redisCli.Set(strKey,strValue);
}
