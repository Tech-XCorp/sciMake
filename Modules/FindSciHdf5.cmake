# - FindSciHdf5: Module to find include directories and
#   libraries for Hdf5.
#
# Module usage:
#   find_package(SciHdf5 ...)
#
# This module will define the following variables:
#  HAVE_HDF5, HDF5_FOUND   = Whether libraries and includes are found
#  Hdf5_INCLUDE_DIRS       = Location of Hdf5 includes
#  Hdf5_LIBRARY_DIRS       = Location of Hdf5 libraries
#  Hdf5_LIBRARIES          = Required libraries
#  Hdf5_DLLS               =

######################################################################
#
# FindHdf5: find includes and libraries for hdf5
#
# $Id$
#
# Copyright 2010-2012 Tech-X Corporation.
# Arbitrary redistribution allowed provided this copyright remains.
#
######################################################################

if (ENABLE_PARALLEL)
  if (BUILD_WITH_SHARED_RUNTIME OR USE_SHARED_HDF5)
    set(instdirs hdf5-parsh)
  else ()
    set(instdirs hdf5-par)
  endif ()
else ()
  if (BUILD_WITH_CC4PY_RUNTIME OR USE_CC4PY_HDF5)
    set(instdirs hdf5-cc4py hdf5-sersh)
  elseif (BUILD_WITH_SHARED_RUNTIME OR USE_SHARED_HDF5)
    set(instdirs hdf5-sersh)
  else ()
    set(instdirs hdf5)
  endif ()
endif ()

if (USE_SHARED_HDF5 AND WIN32)
  set(desiredlibs hdf5dll)
else ()
  set(desiredlibs hdf5_hl hdf5)
  if (CMAKE_Fortran_COMPILER_WORKS)
    set(desiredlibs hdf5_fortran hdf5_f90cstub ${desiredlibs})
    set(desiredmods hdf5)
  else ()
    set(desiredmods)
  endif ()
endif ()

SciFindPackage(PACKAGE "Hdf5"
  INSTALL_DIR ${instdirs}
  EXECUTABLES h5diff
  HEADERS hdf5.h
  LIBRARIES ${desiredlibs}
  MODULES ${desiredmods}
  INCLUDE_SUBDIRS include include/hdf5/include # Last for VisIt installation
  MODULE_SUBDIRS include/fortran include lib
)

if (HDF5_FOUND)
  # message(STATUS "Found Hdf5")
  set(HAVE_HDF5 1 CACHE BOOL "Whether have the HDF5 library")
  set(OLD_H5S_SELECT_HYPERSLAB_IFC 0 CACHE BOOL
    "Whether using the old 1.6.3 H5Sselect_hyperslab interface")
else ()
  message(STATUS "Did not find Hdf5.  Use -DHdf5_ROOT_DIR to specify the installation directory.")
  if (SciHdf5_FIND_REQUIRED)
    message(FATAL_ERROR "Failing.")
  endif ()
endif ()

