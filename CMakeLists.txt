#
# Copyright (c) 2023 Nordic Semiconductor
#
# SPDX-License-Identifier: LicenseRef-Nordic-5-Clause
#

cmake_minimum_required(VERSION 3.20.0)

# A root-level uf2.conf acts as the build-mode switch.
# Copy uf2/uf2.conf to the project root and run a pristine build
# to link the application at the bootloader-safe offset.
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/uf2.conf")
  list(APPEND EXTRA_CONF_FILE "${CMAKE_CURRENT_SOURCE_DIR}/uf2.conf")
endif()

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(802154_sniffer)

target_sources(app PRIVATE src/main.c)
