######################################################################
# - FindSciOpenCL: Find include directories and libraries for OpenCL.
#
# Module usage:
#   find_package(OpenCL ...)
#
# This module will define the following variables:
#  HAVE_OPENCL, OPENCL_FOUND = Whether libraries and includes are found
#  OpenCL_INCLUDE_DIRS       = Location of OpenCL includes
#  OpenCL_LIBRARY_DIRS       = Location of OpenCL libraries
#  OpenCL_LIBRARIES          = Required libraries
#
# Copyright 2013 Tech-X Corporation.
# Arbitrary redistribution allowed provided this copyright remains.
#
######################################################################


find_package(CUDA)
if (CUDA_FOUND)
  set(OpenCL_ROOT_DIR ${CUDA_TOOLKIT_ROOT_DIR})
endif ()

if ("${CMAKE_SYSTEM_NAME}" STREQUAL "Darwin")
  set(OpenCL_HEADERS "OpenCL/opencl.h")
else ()
  set(OpenCL_HEADERS "CL/cl.h")
endif ()

SciFindPackage(PACKAGE "OpenCL"
    INSTALL_DIR "${OpenCL_ROOT_DIR}"
    HEADERS "${OpenCL_HEADERS}"
    LIBRARIES "OpenCL"
    INCLUDE_SUBDIRS "include"
    LIBRARY_SUBDIRS "lib64;lib;lib/x64"
    )

if (OpenCL_INCLUDE_DIRS AND OpenCL_LIBRARIES)
  set(OpenCL_FOUND TRUE)
endif ()

if (OpenCL_FOUND)
  message(STATUS "Found OpenCL")
  set(HAVE_OpenCL 1 CACHE BOOL "Whether have OpenCL")
else ()
  message(STATUS "Did not find OpenCL.  Use -DOpenCL_DIR to specify the installation directory.")
  if (SciOpenCL_FIND_REQUIRED)
    message(FATAL_ERROR "Failed.")
  endif ()
endif ()


