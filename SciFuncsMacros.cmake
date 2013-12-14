######################################################################
#
# SciFuncsMacros: Various functions and macros used by Tech-X scimake
#
# $Id$
#
# Copyright 2010-2013 Tech-X Corporation.
# Arbitrary redistribution allowed provided this copyright remains.
#
# See LICENSE file (EclipseLicense.txt) for conditions of use.
#
######################################################################

#
# SciPrintString: print a string in a status message as well as to
#   ${CONFIG_SUMMARY}
# Args:
#   str the string
#
macro(SciPrintString str)
  message(STATUS "${str}")
  if (DEFINED CONFIG_SUMMARY)
    file(APPEND "${CONFIG_SUMMARY}" "${str}\n")
  else ()
    message(WARNING "Variable CONFIG_SUMMARY is not defined, SciPrintString is unable to write to the summary file.")
  endif ()
endmacro()

#
# SciPrintVar: print a variable with standard formatting
# Args:
#   var the name of the variable
#
macro(SciPrintVar var)
  string(LENGTH "${var}" lens)
  math(EXPR lenb "35 - ${lens}")
  if (lenb GREATER 0)
    string(RANDOM LENGTH ${lenb} ALPHABET " " blstr)
  else ()
    set(blstr "")
  endif ()
  SciPrintString("  ${var}${blstr}= ${${var}}")
endmacro()

#
# Print all cmake variables generated by SciFindPackage
# Args:
#   pkg: the name of the package
#
macro(SciPrintCMakeResults pkg)
  # message("--------- RESULTS FOR ${pkg} ---------")
  SciPrintString("")
  SciPrintString("RESULTS FOR ${pkg}:")
  foreach (varsfx ROOT_DIR CONFIG_CMAKE CONFIG_VERSION_CMAKE PROGRAMS FILES INCLUDE_DIRS MODULE_DIRS LIBFLAGS LIBRARY_DIRS LIBRARY_NAMES LIBRARIES STLIBS DEFINITIONS)
    SciPrintVar(${pkg}_${varsfx})
  endforeach ()
  if (WIN32)
    SciPrintVar(${pkg}_DLLS)
  endif ()
endmacro()

#
# Print all autotools variables generated by SciFindPackage
# Args:
#   pkg: the name of the package
#
macro(SciPrintAutotoolsResults pkg)
  # message("--------- RESULTS FOR ${pkg} ---------")
  SciPrintString("")
  SciPrintString("RESULTS FOR ${pkg}:")
  foreach (varsfx ROOT_DIR DIR INCDIRS MODDIRS LIBS ALIBS)
    SciPrintVar(${pkg}_${varsfx})
  endforeach ()
  if (WIN32)
    SciPrintVar(${pkg}_DLLS)
  endif ()
endmacro()

