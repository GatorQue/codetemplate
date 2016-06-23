# Use ctGetExtDep module to download SFML
include(ctGetExtDep)

#
# PREBUILT version of SFML
#
ct_get_prebuilt(sfml-prebuilt
  PACKAGE SFML
  COMPONENTS audio graphics network window system
  FOUND_VAR SFML_FOUND
  ROOT_HINT_VAR SFML_ROOT
  INCLUDE_DIR_VAR SFML_INCLUDE_DIR
  #LIBS sfml-audio sfml-graphics sfml-network sfml-window sfml-system
  URL http://www.sfml-dev.org/files/SFML-2.3.2-linux-gcc-64-bit.tar.gz
  URL_MD5 1789d0eaaeb90c30bc37a0c007f18155)

#
# SOURCE version of SFML
#
## Call ct_get_cmake to download,extract and include SFML CMake project
#ct_get_cmake(sfml
#    URL http://www.sfml-dev.org/files/SFML-2.3.2-sources.zip
#    URL_MD5 7f152bab6afc8ccbddaf51d6da318201)

## Add sfml component libraries to list of all auto dependency library list
#set(ALL_LIBS ${ALL_LIBS} sfml-audio sfml-graphics sfml-network sfml-window sfml-system)

# Set sfml component include directory and auto library dependencies
#set(sfml-audio_AUTO_INCLUDE_DIR ${SFML_INCLUDE_DIR}/SFML/Audio)
#set(sfml-audio_AUTO_DEPS sfml-system)
#set(sfml-graphics_AUTO_INCLUDE_DIR ${SFML_INCLUDE_DIR}/SFML/Graphics)
#set(sfml-graphics_AUTO_DEPS sfml-window sfml-system)
#set(sfml-network_AUTO_INCLUDE_DIR ${SFML_INCLUDE_DIR}/SFML/Network)
#set(sfml-network_AUTO_DEPS sfml-system)
#set(sfml-window_AUTO_INCLUDE_DIR ${SFML_INCLUDE_DIR}/SFML/Window)
#set(sfml-window_AUTO_DEPS sfml-system)
#set(sfml-system_AUTO_INCLUDE_DIR ${SFML_INCLUDE_DIR}/SFML/System)
#set(sfml-system_AUTO_DEPS)

# EOF
