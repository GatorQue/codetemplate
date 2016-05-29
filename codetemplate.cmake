if(CODE_TEMPLATE_FOUND)
  return()
endif()
set(CODE_TEMPLATE_FOUND TRUE)

# Specify codetemplate repository URL if not provided
if(NOT CODE_TEMPLATE_URL)
  set(CODE_TEMPLATE_URL "https://github.com/GatorQue/codetemplate.git")
endif()

# Specify codetemplate repository path if not provided as sibling to
# CMAKE_SOURCE_DIR
if(NOT CODE_TEMPLATE_DIR)
  set(CODE_TEMPLATE_DIR ${CMAKE_SOURCE_DIR}/../codetemplate)
endif()
get_filename_component(CODE_TEMPLATE_DIR ${CODE_TEMPLATE_DIR} ABSOLUTE)
message(STATUS "CODE_TEMPLATE_DIR=${CODE_TEMPLATE_DIR}")

# Obtain parent of codetemplate repository path
set(CODE_TEMPLATE_PARENT_DIR ${CODE_TEMPLATE_DIR}/..)
get_filename_component(CODE_TEMPLATE_PARENT_DIR ${CODE_TEMPLATE_PARENT_DIR} ABSOLUTE)
message(STATUS "CODE_TEMPLATE_PARENT_DIR=${CODE_TEMPLATE_PARENT_DIR}")

# Specify download cache path if not provided as sibling to CMAKE_SOURCE_DIR
if(NOT DOWNLOAD_CACHE_DIR)
  set(DOWNLOAD_CACHE_DIR ${CMAKE_SOURCE_DIR}/../dl)
endif()
get_filename_component(DOWNLOAD_CACHE_DIR ${DOWNLOAD_CACHE_DIR} ABSOLUTE)
message(STATUS "DOWNLOAD_CACHE_DIR=${DOWNLOAD_CACHE_DIR}")

# Create download cache directory if it doesn't exist yet
if(NOT EXISTS ${DOWNLOAD_CACHE_DIR})
  file(MAKE_DIRECTORY ${DOWNLOAD_CACHE_DIR})
endif()

# Find git executable (exit with error if missing)
find_program(GIT_PATH git)

if(NOT EXISTS ${GIT_PATH})
  message(FATAL_ERROR "CodeTemplate requires git executable")
endif()

macro(_get_ct_version)
  # Tell the user which codetemplate version is being used
  execute_process(
    COMMAND ${GIT_PATH} describe --tags
    WORKING_DIRECTORY ${CODE_TEMPLATE_DIR}
    OUTPUT_VARIABLE CODE_TEMPLATE_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
    RESULT_VARIABLE result)
  if(NOT result EQUAL 0)
    set(CODE_TEMPLATE_VERSION "unknown")
  endif()
endmacro()

# This macro will show and store the codetemplate version in use
macro(ct_show_version)
  _get_ct_version()
  message(STATUS "Using CodeTemplate Version (${CODE_TEMPLATE_VERSION})")
endmacro()

# This macro creates a cache of the current codetemplate in use.
macro(_create_ct_cache)
  file(RELATIVE_PATH _ct_relative ${CODE_TEMPLATE_PARENT_DIR}
    ${CODE_TEMPLATE_DIR})
  execute_process(
    COMMAND ${CMAKE_COMMAND} -E tar cfz ${DOWNLOAD_CACHE_DIR}/codetemplate.tgz ${_ct_relative}
    WORKING_DIRECTORY ${CODE_TEMPLATE_PARENT_DIR}
    RESULT_VARIABLE result)
  if(NOT result EQUAL 0)
    message(FATAL_ERROR "Unable to create codetemplate.tgz archive in ${DOWNLOAD_CACHE_DIR}")
  endif()
endmacro()

macro(_get_ct_from_git)
  # Use Git to download codetemplate repository
  file(REMOVE_RECURSE ${CODE_TEMPLATE_DIR})
  execute_process(
    COMMAND ${GIT_PATH} clone ${CODE_TEMPLATE_URL} ${CODE_TEMPLATE_DIR}
    WORKING_DIRECTORY ${CODE_TEMPLATE_PARENT_DIR}
    RESULT_VARIABLE result)
  if(NOT result EQUAL 0)
    message(FATAL_ERROR "Unable to clone CodeTemplate repository to ${CODE_TEMPLATE_DIR}")
  else()
    _create_ct_cache()
  endif()
endmacro()

# Check to see if codetemplate repository is already available
if(NOT EXISTS ${CODE_TEMPLATE_DIR})
  # Download cache of codetemplate doesn't exist? clone it now
  if(NOT EXISTS ${DOWNLOAD_CACHE_DIR}/codetemplate.tgz)
    _get_ct_from_git()
  # Use download cache of codetemplate instead
  else()
    execute_process(
      COMMAND ${CMAKE_COMMAND} -E tar xfz ${DOWNLOAD_CACHE_DIR}/codetemplate.tgz ${CODE_TEMPLATE_DIR}
      WORKING_DIRECTORY ${CODE_TEMPLATE_PARENT_DIR}
      RESULT_VARIABLE result)
    if(NOT result EQUAL 0)
      message(WARNING "Unable to extract codetemplate.tgz to ${CODE_TEMPLATE_DIR}")
      _get_ct_from_git()
    endif()
  endif()
endif()

ct_show_version()

# Add codetemplate cmake module path and include ctIncludes
set(CMAKE_MODULE_PATH ${CODE_TEMPLATE_DIR}/Modules ${CMAKE_MODULE_PATH})
include(ctIncludes)
