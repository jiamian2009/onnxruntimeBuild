function BuildForWindows($platform, $build_type) {
    $build_dir = "build"
    mkdir $build_dir -Force -ErrorAction Stop | Out-Null
    cd $build_dir
    pwd

    $platform_flag = "-m32"

    if ($platform -eq "x64") {
        $platform_flag = "-m64"
    }

    cmake `
    -G "MinGW Makefiles" `
        -D CMAKE_C_FLAGS=$platform_flag `
        -D CMAKE_CXX_FLAGS=$platform_flag `
        -D CMAKE_BUILD_TYPE=${build_type} `
        -D CMAKE_INSTALL_PREFIX=mingw64 `
        -D Protobuf_USE_STATIC_LIBS=ON `
        -D onnxruntime_BUILD_SHARED_LIB=ON `
        -D onnxruntime_PREFER_SYSTEM_LIB=ON `
        -D onnxruntime_USE_FULL_PROTOBUF=ON `
        -S ../onnxruntime/cmake

    mingw32-make
    mingw32-make install
    ls
    cd ..
}
