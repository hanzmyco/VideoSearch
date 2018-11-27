#include <stdio.h>
#include "CClient.hpp"

int main(int argc, char **argv)
{
    std::string strHost = "127.0.0.1";
    CClient redisCli(strHost,6379,2,10);
    std::string videoUrl;
    std::string vector;
    



    return 0;
}
