# Generate the VTKConfig.cmake file in the build tree.  Also configure
# one for installation.  The file tells external projects how to use
# VTK.

#-----------------------------------------------------------------------------
# Settings shared between the build tres and install tree.

# Determine the preprocessor definitions needed.
SET(VTK_DEFINITIONS "")
IF(VTK_USE_X)
  SET(VTK_DEFINITIONS ${VTK_DEFINITIONS} ${CMAKE_X_CFLAGS})
ENDIF(VTK_USE_X)

# Include directories for other projects installed on the system and
# used by VTK.
SET(VTK_INCLUDE_DIRS_SYS "")
IF(VTK_USE_RENDERING)
  SET(VTK_INCLUDE_DIRS_SYS ${VTK_INCLUDE_DIRS_SYS}
      ${OPENGL_INCLUDE_PATH} ${OPENGL_INCLUDE_DIR})
  IF(VTK_USE_X)
    SET(VTK_INCLUDE_DIRS_SYS ${VTK_INCLUDE_DIRS_SYS}
        ${CMAKE_Xlib_INCLUDE_PATH} ${CMAKE_Xutil_INCLUDE_PATH})
  ENDIF(VTK_USE_X)
ENDIF(VTK_USE_RENDERING)

IF(VTK_OPENGL_HAS_OSMESA)
  SET(VTK_INCLUDE_DIRS_SYS ${VTK_INCLUDE_DIRS_SYS} ${OSMESA_INCLUDE_PATH})
ENDIF(VTK_OPENGL_HAS_OSMESA)

IF(VTK_USE_MPI)
  SET(VTK_INCLUDE_DIRS_SYS ${VTK_INCLUDE_DIRS_SYS} ${MPI_INCLUDE_PATH})
ENDIF(VTK_USE_MPI)

IF(VTK_WRAP_TCL)
  SET(VTK_INCLUDE_DIRS_SYS ${VTK_INCLUDE_DIRS_SYS} ${TCL_INCLUDE_PATH})
ENDIF(VTK_WRAP_TCL)

IF(VTK_WRAP_PYTHON)
  SET(VTK_INCLUDE_DIRS_SYS ${VTK_INCLUDE_DIRS_SYS} ${PYTHON_INCLUDE_PATH})
ENDIF(VTK_WRAP_PYTHON)

IF(VTK_WRAP_JAVA)
  SET(VTK_INCLUDE_DIRS_SYS ${VTK_INCLUDE_DIRS_SYS}
      ${JAVA_INCLUDE_PATH} ${JAVA_INCLUDE_PATH2})
ENDIF(VTK_WRAP_JAVA)

IF(VTK_HAVE_VG500)
  SET(VTK_INCLUDE_DIRS_SYS ${VTK_INCLUDE_DIRS_SYS}
      ${VLI_INCLUDE_PATH_FOR_VG500})
ENDIF(VTK_HAVE_VG500)

IF(VTK_HAVE_VP1000)
  SET(VTK_INCLUDE_DIRS_SYS ${VTK_INCLUDE_DIRS_SYS}
      ${VLI_INCLUDE_PATH_FOR_VP1000})
ENDIF(VTK_HAVE_VP1000)

IF(VTK_USE_MPI)
  SET(VTK_MPIRUN_EXE_CONFIG ${MPIRUN})
  SET(VTK_MPI_MAX_NUMPROCS_CONFIG ${MPI_MAX_NUMPROCS})
  SET(VTK_MPI_POSTFLAGS_CONFIG ${MPI_POSTFLAGS})
  SET(VTK_MPI_PREFLAGS_CONFIG ${MPI_PREFLAGS})
ELSE(VTK_USE_MPI)
  SET(VTK_MPIRUN_EXE_CONFIG "")
  SET(VTK_MPI_MAX_NUMPROCS_CONFIG "")
  SET(VTK_MPI_POSTFLAGS_CONFIG "")
  SET(VTK_MPI_PREFLAGS_CONFIG "")
ENDIF(VTK_USE_MPI)

#-----------------------------------------------------------------------------
# Settings specific to the build tree.

# The "use" file.
SET(VTK_USE_FILE ${VTK_BINARY_DIR}/UseVTK.cmake)

# Library directory.
SET(VTK_LIBRARY_DIRS ${VTK_LIBRARY_PATH})

# Determine the include directories needed.
SET(VTK_INCLUDE_DIRS ${VTK_BINARY_DIR})
IF(VTK_USE_PARALLEL)
  SET(VTK_INCLUDE_DIRS ${VTK_INCLUDE_DIRS} ${VTK_SOURCE_DIR}/Parallel)
ENDIF(VTK_USE_PARALLEL)
IF(VTK_USE_HYBRID)
  SET(VTK_INCLUDE_DIRS ${VTK_INCLUDE_DIRS} ${VTK_SOURCE_DIR}/Hybrid)
ENDIF(VTK_USE_HYBRID)
IF(VTK_USE_PATENTED)
  SET(VTK_INCLUDE_DIRS ${VTK_INCLUDE_DIRS} ${VTK_SOURCE_DIR}/Patented)
ENDIF(VTK_USE_PATENTED)
IF(VTK_USE_RENDERING)
  SET(VTK_INCLUDE_DIRS ${VTK_INCLUDE_DIRS} ${VTK_SOURCE_DIR}/Rendering)
ENDIF(VTK_USE_RENDERING)

# These directories are always needed.
SET(VTK_INCLUDE_DIRS ${VTK_INCLUDE_DIRS}
  ${VTK_SOURCE_DIR}/IO
  ${VTK_SOURCE_DIR}/Imaging
  ${VTK_SOURCE_DIR}/Graphics
  ${VTK_SOURCE_DIR}/Filtering
  ${VTK_SOURCE_DIR}/Common)

# Give access to a few utilities.
SET(VTK_INCLUDE_DIRS ${VTK_INCLUDE_DIRS}
  ${VTK_BINARY_DIR}/Utilities/png
  ${VTK_SOURCE_DIR}/Utilities/png
  ${VTK_BINARY_DIR}/Utilities/zlib
  ${VTK_SOURCE_DIR}/Utilities/zlib)

# Add the system include directories last.
SET(VTK_INCLUDE_DIRS ${VTK_INCLUDE_DIRS} ${VTK_INCLUDE_DIRS_SYS})

# Executable locations.
SET(VTK_TCL_EXE_CONFIG "")
SET(VTK_TCL_HOME_CONFIG "")
SET(VTK_PYTHON_EXE_CONFIG "")
SET(VTK_JAVA_JAR_CONFIG "")
SET(VTK_PARSE_JAVA_EXE_CONFIG "")
SET(VTK_WRAP_JAVA_EXE_CONFIG "")
SET(VTK_WRAP_PYTHON_EXE_CONFIG "")
SET(VTK_WRAP_TCL_EXE_CONFIG "")
IF(VTK_WRAP_TCL)
  SET(VTK_TCL_EXE_CONFIG ${VTK_EXECUTABLE_PATH}/vtk)
  SET(VTK_WRAP_TCL_EXE_CONFIG ${VTK_WRAP_TCL_EXE})
  SET(VTK_TCL_HOME_CONFIG ${VTK_SOURCE_DIR}/Wrapping/Tcl)
ENDIF(VTK_WRAP_TCL)
IF(VTK_WRAP_PYTHON)
  SET(VTK_WRAP_PYTHON_EXE_CONFIG ${VTK_WRAP_PYTHON_EXE})
  IF(VTK_BUILD_PYTHON_EXECUTABLE)
    SET(VTK_PYTHON_EXE_CONFIG ${VTK_EXECUTABLE_PATH}/vtkpython)
  ENDIF(VTK_BUILD_PYTHON_EXECUTABLE)
ENDIF(VTK_WRAP_PYTHON)
IF(VTK_WRAP_JAVA)
  SET(VTK_PARSE_JAVA_EXE_CONFIG ${VTK_PARSE_JAVA_EXE})
  SET(VTK_WRAP_JAVA_EXE_CONFIG ${VTK_WRAP_JAVA_EXE})
  SET(VTK_JAVA_JAR_CONFIG ${LIBRARY_OUTPUT_PATH}/vtk.jar)
ENDIF(VTK_WRAP_JAVA)

# VTK style script locations.
SET(VTK_DOXYGEN_HOME_CONFIG ${VTK_SOURCE_DIR}/Utilities/Doxygen)
SET(VTK_HEADER_TESTING_PY_CONFIG ${VTK_SOURCE_DIR}/Common/Testing/HeaderTesting.py)
SET(VTK_FIND_STRING_TCL_CONFIG ${VTK_SOURCE_DIR}/Common/Testing/Tcl/FindString.tcl)
SET(VTK_PRINT_SELF_CHECK_TCL_CONFIG ${VTK_SOURCE_DIR}/Common/Testing/Tcl/PrintSelfCheck.tcl)
SET(VTK_RT_IMAGE_TEST_TCL_CONFIG ${VTK_SOURCE_DIR}/Common/Testing/Tcl/rtImageTest.tcl)
SET(VTK_REGRESSION_TEST_IMAGE_DIR ${VTK_SOURCE_DIR}/Common/Testing/Cxx)

IF(VTK_USE_PARALLEL)
  SET(VTK_PRT_IMAGE_TEST_TCL_CONFIG ${VTK_SOURCE_DIR}/Common/Testing/Tcl/prtImageTest.tcl)
ELSE(VTK_USE_PARALLEL)
  SET(VTK_PRT_IMAGE_TEST_TCL_CONFIG "")
ENDIF(VTK_USE_PARALLEL)

#-----------------------------------------------------------------------------
# Configure VTKConfig.cmake for the build tree.
CONFIGURE_FILE(${VTK_SOURCE_DIR}/VTKConfig.cmake.in
               ${VTK_BINARY_DIR}/VTKConfig.cmake @ONLY IMMEDIATE)

#-----------------------------------------------------------------------------
# Settings specific to the install tree.

# The "use" file.
SET(VTK_USE_FILE ${CMAKE_INSTALL_PREFIX}/lib/vtk/UseVTK.cmake)

# Include directories.
SET(VTK_INCLUDE_DIRS
  ${CMAKE_INSTALL_PREFIX}/include/vtk
  ${VTK_INCLUDE_DIRS_SYS})

# Link directories.
SET(VTK_LIBRARY_DIRS ${CMAKE_INSTALL_PREFIX}/lib/vtk)

# Executable locations.
SET(VTK_TCL_EXE_CONFIG "")
SET(VTK_TCL_HOME_CONFIG "")
SET(VTK_PYTHON_EXE_CONFIG "")
SET(VTK_JAVA_JAR_CONFIG "")
SET(VTK_PARSE_JAVA_EXE_CONFIG "")
SET(VTK_WRAP_JAVA_EXE_CONFIG "")
SET(VTK_WRAP_PYTHON_EXE_CONFIG "")
SET(VTK_WRAP_TCL_EXE_CONFIG "")
SET(VTK_DOXYGEN_HOME_CONFIG "")
IF(VTK_WRAP_TCL)
  SET(VTK_TCL_EXE_CONFIG ${CMAKE_INSTALL_PREFIX}/bin/vtk)
  SET(VTK_WRAP_TCL_EXE_CONFIG ${CMAKE_INSTALL_PREFIX}/bin/vtkWrapTcl)
  SET(VTK_TCL_HOME_CONFIG ${CMAKE_INSTALL_PREFIX}/lib/vtk/tcl)
ENDIF(VTK_WRAP_TCL)
IF(VTK_WRAP_PYTHON)
  SET(VTK_WRAP_PYTHON_EXE_CONFIG ${CMAKE_INSTALL_PREFIX}/bin/vtkWrapPython)
  IF(VTK_BUILD_PYTHON_EXECUTABLE)
    SET(VTK_PYTHON_EXE_CONFIG ${CMAKE_INSTALL_PREFIX}/bin/vtkpython)
  ENDIF(VTK_BUILD_PYTHON_EXECUTABLE)
ENDIF(VTK_WRAP_PYTHON)
IF(VTK_WRAP_JAVA)
  SET(VTK_PARSE_JAVA_EXE_CONFIG ${CMAKE_INSTALL_PREFIX}/bin/vtkParseJava)
  SET(VTK_WRAP_JAVA_EXE_CONFIG ${CMAKE_INSTALL_PREFIX}/bin/vtkWrapJava)
  SET(VTK_JAVA_JAR_CONFIG ${CMAKE_INSTALL_PREFIX}/lib/vtk/java/vtk.jar)
ENDIF(VTK_WRAP_JAVA)

# VTK style script locations.
SET(VTK_DOXYGEN_HOME_CONFIG ${CMAKE_INSTALL_PREFIX}/lib/vtk/doxygen)
SET(VTK_HEADER_TESTING_PY_CONFIG ${CMAKE_INSTALL_PREFIX}/lib/vtk/testing/HeaderTesting.py)
SET(VTK_FIND_STRING_TCL_CONFIG ${CMAKE_INSTALL_PREFIX}/lib/vtk/testing/FindString.tcl)
SET(VTK_PRINT_SELF_CHECK_TCL_CONFIG ${CMAKE_INSTALL_PREFIX}/lib/vtk/testing/PrintSelfCheck.tcl)
SET(VTK_RT_IMAGE_TEST_TCL_CONFIG ${CMAKE_INSTALL_PREFIX}/lib/vtk/testing/rtImageTest.tcl)
SET(VTK_REGRESSION_TEST_IMAGE_DIR ${CMAKE_INSTALL_PREFIX}/lib/vtk/testing)

IF(VTK_USE_PARALLEL)
  SET(VTK_PRT_IMAGE_TEST_TCL_CONFIG ${CMAKE_INSTALL_PREFIX}/lib/vtk/testing/prtImageTest.tcl)
ELSE(VTK_USE_PARALLEL)
  SET(VTK_PRT_IMAGE_TEST_TCL_CONFIG "")
ENDIF(VTK_USE_PARALLEL)

#-----------------------------------------------------------------------------
# Configure VTKConfig.cmake for the build tree.
CONFIGURE_FILE(${VTK_SOURCE_DIR}/VTKConfig.cmake.in
               ${VTK_BINARY_DIR}/Utilities/VTKConfig.cmake @ONLY IMMEDIATE)
