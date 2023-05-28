cmake_minimum_required(VERSION 3.20)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake-d/cmake-d)
set(CMAKE_C_COMPILER dmd)

project(IMDAppleServices D)

set(SOURCE_DIR "source/")
file(GLOB_RECURSE SOURCES "${SOURCE_DIR}*.d")

include(UseDub)
DubProject_Add(slf4d ~2.1.1)

add_executable(IMDAppleServices ${SOURCES})
target_include_directories(IMDAppleServices PUBLIC ${SOURCE_DIR})

target_link_directories(IMDAppleServices PUBLIC /usr/libexec/swift/5.8/lib/swift/linux/)
target_link_libraries(IMDAppleServices PUBLIC slf4d CoreFoundation kqueue)
