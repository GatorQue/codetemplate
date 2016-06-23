# Include codetemplate variable definitions
include(ctDefines)

# Include codetemplate C++11 check macros
include(ctCheckCxx11)

# Include codetemplate macros and functions provided
include(ctAddDir)
include(ctAddExe)
include(ctAddLib)
include(ctAddOption)
include(ctAddTest)
include(ctGenCMake)
include(ctGetExtDep)
include(ctGetGMock)

# EOF
