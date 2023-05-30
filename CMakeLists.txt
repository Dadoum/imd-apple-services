cmake_minimum_required(VERSION 3.20)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake-d/cmake-d)

project(imd-apple-services C D)

set(SOURCE_DIR "source/")
file(GLOB_RECURSE SOURCES "${SOURCE_DIR}*.d")

include(UseDub)
DubProject_Add(slf4d ~2.1.1)

add_executable(imd-apple-services ${SOURCES} source/windows_trampoline.c)
target_include_directories(imd-apple-services PUBLIC ${SOURCE_DIR})

target_link_libraries(imd-apple-services PUBLIC slf4d CoreFoundation)
target_compile_versions(imd-apple-services PUBLIC "CMake")

if (UNIX AND NOT APPLE)
    target_link_libraries(imd-apple-services PUBLIC kqueue)
endif()
