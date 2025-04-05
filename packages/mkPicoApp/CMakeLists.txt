cmake_minimum_required(VERSION 3.15)

include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)
include(${PICO_EXTRAS_PATH}/external/pico_extras_import.cmake)

string(ASCII 27 ANSI_ESCAPE)
set(COLOR_LIGHTBLUE "${ANSI_ESCAPE}[1;34m")
set(COLOR_RESET "${ANSI_ESCAPE}[0m")

function(rp2040nix_log)
  string(JOIN "\n> " FULL_MSG ${ARGV})
  message("${COLOR_LIGHTBLUE}rp2040nix: ${FULL_MSG}${COLOR_RESET}")
endfunction()

project(rp2040nix-app)

pico_sdk_init()

rp2040nix_log("Finding Sources...")
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

rp2040nix_log("Using sources: " ${CORE_SOURCES})

if(TEST)
  rp2040nix_log("Using test compliation...")
  add_executable(rp2040nix-app ${TEST_ENTRY} ${CORE_SOURCES})
  set(CMAKE_BUILD_TYPE Debug)
  target_compile_definitions(rp2040nix-app PRIVATE TEST)
else()
  rp2040nix_log("Using main compliation...")
  add_executable(rp2040nix-app ${MAIN_ENTRY} ${CORE_SOURCES})
endif()

rp2040nix_log("Adding pio headers..." ${RP2040NIX_PIO})
foreach(pio-header ${RP2040NIX_PIO})
  pico_generate_pio_header(rp2040nix-app ${pio-header})
endforeach()

# Link header files
target_include_directories(rp2040nix-app PRIVATE src)

rp2040nix_log("Linking libraries..." ${RP2040NIX_LIBRARIES})
target_link_libraries(rp2040nix-app pico_stdlib ${RP2040NIX_LIBRARIES})

pico_enable_stdio_usb(rp2040nix-app 0)
pico_enable_stdio_uart(rp2040nix-app 1)
pico_add_extra_outputs(rp2040nix-app)
