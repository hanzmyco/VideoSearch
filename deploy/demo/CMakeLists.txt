cmake_minimum_required(VERSION 2.6)
project(Demo)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

include_directories(./)
file(GLOB SOURCES ${PROJECT_SOURCE_DIR}/*.cpp)
link_directories(${PROJECT_SOURCE_DIR})

add_executable(${PROJECT_NAME} ${SOURCES})
target_link_libraries(${PROJECT_NAME} TerrorClassifier)
