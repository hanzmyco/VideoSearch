file(GLOB tmp ${TARGET_LIB}.cpp ${TARGET_LIB}.h, utils/*)
set(DEPLOY_LIB_SRCS ${tmp})

set(DEPLOY_DEMO_SRCS)
#set(FREE_IMAGE_ROOT ${PACKAGE_ROOT_DIR}/3rd_party/freeimage)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules)
if(BUILD_XCLASSIFIER_PYTHON_WRAPPER AND BUILD_SHARED_LIBS)
    #file(GLOB tmp Py*.cpp check_license.cpp)
    file(GLOB tmp Py*.cpp)
    set(DEPLOY_LIB_SRCS ${DEPLOY_LIB_SRCS} ${tmp})

    message (STATUS "Looking for Python3...")
    find_package (PythonLibs 3.0 REQUIRED)
    message (STATUS "Found Python3: ${PYTHON_LIBRARIES}")
    message(STATUS "Caffe_LINKER_LIBS ========== ${Caffe_LINKER_LIBS}")
    set(Caffe_INCLUDE_DIRS ${Caffe_INCLUDE_DIRS} ${PYTHON_INCLUDE_DIRS})
    set(Caffe_LINKER_LIBS ${Caffe_LINKER_LIBS} ${PYTHON_LIBRARIES})
endif()

if(MSVC)
    set(caffe_export_hdr_in ${PACKAGE_ROOT_DIR}/caffe1s/cmake/Templates/export.hpp.in)
    set(caffe_export_hdr ${PROJECT_BINARY_DIR}/caffe1s/export.hpp)  
    set(caffe_symbols_hdr ${PROJECT_BINARY_DIR}/caffe1s/include_symbols.hpp)  
    set_source_files_properties(${caffe_export_hdr} ${caffe_symbols_hdr} PROPERTIES GENERATED TRUE)

    if(NOT BUILD_SHARED_LIBS)
        list(APPEND Caffe_SRCS ${caffe_symbols_hdr})
    endif()
    list(APPEND Caffe_SRCS ${caffe_export_hdr})
endif()

if(BUILD_SHARED_LIBS)
    # NOTE: link_directories should be put BEFORE add_library, otherwise it has no effect
    if(NOT WIN32)
        link_directories(/usr/local/lib)  # Otherwise it cannot find OpenCV dylibs on macOS
    endif()
    add_library(${TARGET_LIB} ${DEPLOY_LIB_SRCS} ${Caffe_SRCS})
else()
    add_library(${TARGET_LIB} STATIC ${DEPLOY_LIB_SRCS} ${Caffe_SRCS})
endif()

source_group(caffe FILES ${Caffe_SRCS})

# NOTE: uncomment below line for projects which can benefit from conv_sum_fusion
# list(REMOVE_ITEM Caffe_DEFINITIONS -DDISABLE_CONV_SUM_FUSION)

target_compile_definitions(${TARGET_LIB} ${Caffe_DEFINITIONS})
if(Caffe_COMPILE_OPTIONS)
    target_compile_options(${TARGET_LIB} ${Caffe_COMPILE_OPTIONS})
endif()

find_package(FFMPEG REQUIRED)

target_link_libraries(${TARGET_LIB}
    ${Caffe_LINKER_LIBS}
    ${FFMPEG_LIBRARIES}
    #${FREE_IMAGE_ROOT}/lib/libfreeimage.a
)

set(TARGET_LIB_INCLUDE_DIRS
    ${Caffe_INCLUDE_DIRS}
    ${PACKAGE_ROOT_DIR}/caffe1s/include
    #${FREE_IMAGE_ROOT}/include
    ${PROJECT_BINARY_DIR}
    ${PROJECT_BINARY_DIR}/include
    ${FFMPEG_INCLUDE_DIR}
)
target_include_directories(${TARGET_LIB} ${TARGET_LIB_INCLUDE_DIRS})

if(MSVC AND BUILD_SHARED_LIBS)
    # CMake 3.4 introduced a WINDOWS_EXPORT_ALL_SYMBOLS target property that makes it possible to
    # build shared libraries without using the usual declspec() decoration.
    # See: https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/
    # and https://cmake.org/cmake/help/v3.5/prop_tgt/WINDOWS_EXPORT_ALL_SYMBOLS.html
    # for details.
    set_target_properties(${TARGET_LIB} PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
elseif(MSVC AND NOT BUILD_SHARED_LIBS)
    # add a custom build command that generates a list of symbols
    # to force linking. This is required because MSVC as nothing
    # the whole-archive option
    windows_create_link_header(${TARGET_LIB} ${caffe_symbols_hdr})
    get_filename_component(_name ${caffe_symbols_hdr} NAME)
    set(CAFFE_INCLUDE_SYMBOLS "#include \"caffe1s/${_name}\"")
    # definition needed to include CMake generated files
    target_compile_definitions(${TARGET_LIB} PRIVATE ${_caffe_static_compile_def} PUBLIC -DCMAKE_WINDOWS_BUILD)
endif()

if(MSVC)
    # Disable Boost autolinking for consuming projects
    target_compile_definitions(${TARGET_LIB} PUBLIC -DBOOST_ALL_NO_LIB)
endif()

if(MSVC)
    configure_file(${caffe_export_hdr_in} ${caffe_export_hdr})
endif()

#########################################################################################

if(BUILD_DEMO)
    file(GLOB tmp
        demo/*.h
        demo/*.cpp
    )
    set(DEPLOY_DEMO_SRCS ${tmp})
endif()

if(BUILD_SHARED_LIBS)
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set(Caffe_LINK ${TARGET_LIB} -ldl)
    else()
        set(Caffe_LINK ${TARGET_LIB})
    endif()
else()
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        set(Caffe_LINK -Wl,-force_load ${TARGET_LIB})
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set(Caffe_LINK -Wl,--whole-archive ${TARGET_LIB} -Wl,--no-whole-archive)
    elseif(MSVC)
        set(Caffe_LINK ${TARGET_LIB})
    endif()
endif()

# NOTE: link_directories should be put BEFORE add_executable, otherwise it has no effect
if(NOT WIN32)
    link_directories(/usr/local/lib)  # Otherwise it cannot find OpenCV dylibs on macOS
endif()

add_executable(Demo ${DEPLOY_DEMO_SRCS})

include_directories(${CMAKE_CURRENT_LIST_DIR})

add_dependencies(Demo ${TARGET_LIB})
target_link_libraries(Demo ${Caffe_LINK})
target_include_directories(Demo ${TARGET_LIB_INCLUDE_DIRS})
