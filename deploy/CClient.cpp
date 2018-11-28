#include "CClient.hpp"

CClient::CClient(const std::string &strHost, int nPort, int nTimeout, int nConnNum)
{
  this->connStatus = Connect(strHost, nPort, nTimeout, nConnNum);
}

int CClient::Connect(const std::string &strHost, int nPort, int nTimeout, int nConnNum){
  return this->redisCli.Initialize(strHost, nPort, nTimeout, nConnNum);
}

int CClient::Get(std::string strKey,std::string *strVal){
  if (this->connStatus){
    if((this->redisCli.Get(strKey, strVal) == RC_SUCCESS)){
        return 0;
    }
    return 1;
  }
  else{
    std::cerr<<"connection failed";
  }
}

void CClient::Set(std::string strKey,std::string strValue){
  this->redisCli.Set(strKey,strValue);
}
