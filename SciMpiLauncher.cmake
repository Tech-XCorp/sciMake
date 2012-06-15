######################################################################
#
# Polyswift.cmake: Compute Polyswift specific options
#
# $Id: SciMpiLauncher.cmake 1245 2012-01-31 21:36:22Z dws $
#
# Copyright 2010-2012 Tech-X Corporation.
# Arbitrary redistribution allowed provided this copyright remains.
#
######################################################################

# First look in specified path
find_program(${sciexecvar}
  "${sciexec}"
  PATHS ${scipath}
  PATH_SUFFIXES "${sciexecsubdirs}"
  NO_DEFAULT_PATH
  DOC "Path to the ${sciexec} executable"
  )

# MPILAUNCHER for parallel runs
if (NOT DEFINED MPILAUNCHER)
    set(MPILAUNCHER ${MPILAUNCHER:FILEPATH})
endif ()

if (NOT DEFINED NPROCS)
  if (ENABLE_PARALLEL)
    set(NPROCS "2")
  endif ()
endif ()

