# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.12

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/hanzhang/github/VideoSearch

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/hanzhang/github/VideoSearch/build

# Include any dependencies generated for this target.
include deploy/CMakeFiles/demo.dir/depend.make

# Include the progress variables for this target.
include deploy/CMakeFiles/demo.dir/progress.make

# Include the compile flags for this target's objects.
include deploy/CMakeFiles/demo.dir/flags.make

deploy/CMakeFiles/demo.dir/main.cpp.o: deploy/CMakeFiles/demo.dir/flags.make
deploy/CMakeFiles/demo.dir/main.cpp.o: ../deploy/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/hanzhang/github/VideoSearch/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object deploy/CMakeFiles/demo.dir/main.cpp.o"
	cd /Users/hanzhang/github/VideoSearch/build/deploy && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/demo.dir/main.cpp.o -c /Users/hanzhang/github/VideoSearch/deploy/main.cpp

deploy/CMakeFiles/demo.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/demo.dir/main.cpp.i"
	cd /Users/hanzhang/github/VideoSearch/build/deploy && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/hanzhang/github/VideoSearch/deploy/main.cpp > CMakeFiles/demo.dir/main.cpp.i

deploy/CMakeFiles/demo.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/demo.dir/main.cpp.s"
	cd /Users/hanzhang/github/VideoSearch/build/deploy && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/hanzhang/github/VideoSearch/deploy/main.cpp -o CMakeFiles/demo.dir/main.cpp.s

# Object files for target demo
demo_OBJECTS = \
"CMakeFiles/demo.dir/main.cpp.o"

# External object files for target demo
demo_EXTERNAL_OBJECTS =

deploy/demo: deploy/CMakeFiles/demo.dir/main.cpp.o
deploy/demo: deploy/CMakeFiles/demo.dir/build.make
deploy/demo: deploy/CMakeFiles/demo.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/hanzhang/github/VideoSearch/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable demo"
	cd /Users/hanzhang/github/VideoSearch/build/deploy && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/demo.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
deploy/CMakeFiles/demo.dir/build: deploy/demo

.PHONY : deploy/CMakeFiles/demo.dir/build

deploy/CMakeFiles/demo.dir/clean:
	cd /Users/hanzhang/github/VideoSearch/build/deploy && $(CMAKE_COMMAND) -P CMakeFiles/demo.dir/cmake_clean.cmake
.PHONY : deploy/CMakeFiles/demo.dir/clean

deploy/CMakeFiles/demo.dir/depend:
	cd /Users/hanzhang/github/VideoSearch/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/hanzhang/github/VideoSearch /Users/hanzhang/github/VideoSearch/deploy /Users/hanzhang/github/VideoSearch/build /Users/hanzhang/github/VideoSearch/build/deploy /Users/hanzhang/github/VideoSearch/build/deploy/CMakeFiles/demo.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : deploy/CMakeFiles/demo.dir/depend
