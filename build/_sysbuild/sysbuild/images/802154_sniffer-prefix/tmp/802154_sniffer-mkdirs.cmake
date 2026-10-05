# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "E:/ncs_workspaces/project/new/802154_sniffer")
  file(MAKE_DIRECTORY "E:/ncs_workspaces/project/new/802154_sniffer")
endif()
file(MAKE_DIRECTORY
  "E:/ncs_workspaces/project/new/802154_sniffer/build/802154_sniffer"
  "E:/ncs_workspaces/project/new/802154_sniffer/build/_sysbuild/sysbuild/images/802154_sniffer-prefix"
  "E:/ncs_workspaces/project/new/802154_sniffer/build/_sysbuild/sysbuild/images/802154_sniffer-prefix/tmp"
  "E:/ncs_workspaces/project/new/802154_sniffer/build/_sysbuild/sysbuild/images/802154_sniffer-prefix/src/802154_sniffer-stamp"
  "E:/ncs_workspaces/project/new/802154_sniffer/build/_sysbuild/sysbuild/images/802154_sniffer-prefix/src"
  "E:/ncs_workspaces/project/new/802154_sniffer/build/_sysbuild/sysbuild/images/802154_sniffer-prefix/src/802154_sniffer-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "E:/ncs_workspaces/project/new/802154_sniffer/build/_sysbuild/sysbuild/images/802154_sniffer-prefix/src/802154_sniffer-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "E:/ncs_workspaces/project/new/802154_sniffer/build/_sysbuild/sysbuild/images/802154_sniffer-prefix/src/802154_sniffer-stamp${cfgdir}") # cfgdir has leading slash
endif()
