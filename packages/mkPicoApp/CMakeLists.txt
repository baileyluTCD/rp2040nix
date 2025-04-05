cmake_minimum_required(VERSION 3.13)

include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)
include(${PICO_EXTRAS_PATH}/external/pico_extras_import.cmake)

project(rp2040nix-app)

pico_sdk_init()

# Find all core sources EXCLUDING entry points
file(
  GLOB_RECURSE CORE_SOURCES
  LIST_DIRECTORIES false
  CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/src/*.c"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/*.S" "${CMAKE_CURRENT_SOURCE_DIR}/src/*.s")

set(MAIN_ENTRY "${CMAKE_CURRENT_SOURCE_DIR}/src/main.c")
set(TEST_ENTRY "${CMAKE_CURRENT_SOURCE_DIR}/src/test.c")

# Remove entry points from core sources
list(REMOVE_ITEM CORE_SOURCES ${MAIN_ENTRY} ${TEST_ENTRY})

if(TEST)
  add_executable(rp2040nix-app ${TEST_ENTRY} ${CORE_SOURCES})
  set(CMAKE_BUILD_TYPE Debug)
  target_compile_definitions(rp2040nix-app PRIVATE TEST)
else()
  add_executable(rp2040nix-app ${MAIN_ENTRY} ${CORE_SOURCES})
endif()

# Link header files
target_include_directories(rp2040nix-app PRIVATE src)
target_link_libraries(rp2040nix-app pico_stdlib pico_multicore)

pico_enable_stdio_usb(rp2040nix-app 0)
pico_enable_stdio_uart(rp2040nix-app 1)
pico_add_extra_outputs(rp2040nix-app)
