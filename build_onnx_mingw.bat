SET arch=x86
% if %2==x64 (SET arch=)
.\build.bat --config %1 %arch% --parallel --use_openmp --build_shared_lib --cmake_generator "MinGW Makefiles"
