INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/deploy/include
	  ${PROJECT_SOURCE_DIR}/deploy/include/redis)

set (APP_SRC main.cpp)
add_executable(demo ${APP_SRC})
target_link_libraries(demo libCPP)
