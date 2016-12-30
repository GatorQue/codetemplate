# Use ctGetExtDep module to download GMock
include(ctGetExtDep)

# Call ct_get_cmake to download,extract and include googlemock CMake project
ct_get_cmake(googletest
    URL https://github.com/google/googletest/archive/release-1.8.0.zip
    URL_MD5 adfafc8512ab65fd3cf7955ef0100ff5
    INCLUDE_DIRS googlemock/include googletest/include)

# Add gtest/gmock libraries to list of all auto dependency library list
set(ALL_LIBS ${ALL_LIBS} gtest gmock)

# Set gtest/gmock include directory and auto library dependencies
set(gtest_AUTO_INCLUDE_DIR ${__SOURCE}/googletest/googletest/include)
set(gtest_AUTO_DEPS gtest_main)
set(gmock_AUTO_INCLUDE_DIR ${__SOURCE}/googlemock/googlemock/include)
set(gmock_AUTO_DEPS gmock_main gtest)

# EOF
