cmake_minimum_required(VERSION 3.20)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake-d/cmake-d)

project(imd-apple-services C D)

set(SOURCE_DIR "source/")
file(GLOB_RECURSE SOURCES "${SOURCE_DIR}*.d")

include(UseDub)
DubProject_Add(slf4d ~2.1.1)
FetchContent_Declare(
    plist_proj
    GIT_REPOSITORY https://github.com/Dadoum/plist
    PATCH_COMMAND ${DUB_DIRECTORY}/CMakeTmp/DubToCMake -s plist
)
FetchContent_MakeAvailable(plist_proj)

add_executable(imd-apple-services ${SOURCES})
target_link_libraries(imd-apple-services PRIVATE slf4d plist)
target_include_directories(imd-apple-services PUBLIC ${SOURCE_DIR})
