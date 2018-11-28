cmake_minimum_required(VERSION 2.8.12 FATAL_ERROR)


set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/deploy/include
	  ${PROJECT_SOURCE_DIR}/deploy/include/redis)
#		${PROJECT_SOURCE_DIR}/redis)


 ADD_DEFINITIONS(-O3 -Wall -g)
 IF(APPLE) # mac os
	 ADD_DEFINITIONS(-std=c++0x)
 endif()

set(LIB_SRC CClient.cpp)
add_library(CClient ${LIB_SRC})
