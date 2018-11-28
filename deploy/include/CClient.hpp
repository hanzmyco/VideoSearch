#ifndef CCLIENT_H
#define CCLIENT_H

#include "RedisClient.hpp"
#include <iostream>
#include <unistd.h>
#include <time.h>
#include <cmath>
#include <algorithm>

class CClient
{
public:
    CClient(const std::string &strHost, int nPort, int nTimeout, int nConnNum);
    int Connect(const std::string &strHost, int nPort, int nTimeout, int nConnNum);
    int Get(std::string strKey,std::string *strVal);
    void Set(std::string strKey,std::string strValue);

protected:
    CRedisClient redisCli;
    std::string strHost;
    int connStatus;
};

#endif
