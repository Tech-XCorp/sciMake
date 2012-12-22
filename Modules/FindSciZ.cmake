# - FindSciZ: Module to find include directories and
#   libraries for Z.
#
# Module usage:
#   find_package(SciZ ...)
#
# This module will define the following variables:
#  HAVE_Z, Z_FOUND = Whether libraries and includes are found
#  Z_INCLUDE_DIRS       = Location of Z includes
#  Z_LIBRARY_DIRS       = Location of Z libraries
#  Z_LIBRARIES          = Required libraries

######################################################################
#
# SciFindZ: find includes and libraries for z(compression)
#
# $Id$
#
# Copyright 2010-2012 Tech-X Corporation.
# Arbitrary redistribution allowed provided this copyright remains.
#
######################################################################

SciFindPackage(
  PACKAGE "Z"
  INSTALL_DIRS zlib
  LIBRARIES "z"
)

if (Z_FOUND)
  # message(STATUS "Found Z(compression library)")
  set(HAVE_Z 1 CACHE BOOL "Whether have the z(compression) library")
else ()
  message(STATUS "Did not find Z(compression).")
  if (SciZ_FIND_REQUIRED)
    message(FATAL_ERROR "Failed.")
  endif ()
endif ()
