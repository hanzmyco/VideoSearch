cmake_minimum_required(VERSION 2.8.12 FATAL_ERROR)

project(VideoSearch)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/lib
	  ${PROJECT_SOURCE_DIR}/include
		${PROJECT_SOURCE_DIR}/redis)


 ADD_DEFINITIONS(-O3 -Wall -g)
 IF(APPLE) # mac os
	 ADD_DEFINITIONS(-std=c++0x)
 endif()

#ADD_SUBDIRECTORY(deps)
#ADD_SUBDIRECTORY(test)

#ENABLE_TESTING()
#ADD_TEST(NAME ./test/test.run COMMAND ./test/test.run)
#ADD_TEST(NAME ./load_test COMMAND ./load_test)
#ADD_TEST(NAME ./demo COMMAND ./demo)


set(DEPLOY_DEMO_SRCS
    main.cpp
)

add_executable(Demo ${DEPLOY_DEMO_SRCS})

target_link_libraries(Demo
    pthread
)
