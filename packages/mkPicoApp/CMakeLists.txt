cmake_minimum_required(VERSION 3.13)

# Include pico-sdk functions
include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)
include(${PICO_EXTRAS_PATH}/external/pico_extras_import.cmake)

project(rp2040nix-app)

# Load sdk
pico_sdk_init()

if(TEST)
  # If -DTEST is passed compile our tests
  add_executable(rp2040nix-app src/test.c)

  # Include asserts
  set(CMAKE_BUILD_TYPE Debug)

  # Define `TEST` inside C code for conditional compilation
  target_compile_definitions(rp2040nix-app PRIVATE TEST)
else()
  # Compile the pico app if -DTEST is not passed
  add_executable(rp2040nix-app src/main.c)
endif()

# Use code from our whole source directory
target_include_directories(rp2040nix-app PRIVATE src)

# Link rpi pico libraries needed
target_link_libraries(rp2040nix-app pico_stdlib)

# Enable printing over serial
pico_enable_stdio_usb(rp2040nix-app 0)
pico_enable_stdio_uart(rp2040nix-app 1)

# Build the app
pico_add_extra_outputs(rp2040nix-app)
