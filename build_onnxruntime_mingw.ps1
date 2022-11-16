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
        -D CMAKE_INSTALL_PREFIX=./mingw64 `
        -D Protobuf_USE_STATIC_LIBS=ON `
        -D eigen_SOURCE_PATH=./mingw64/include/eigen3 `
        -D onnxruntime_BUILD_BENCHMARKS=OFF `
        -D onnxruntime_BUILD_SHARED_LIB=ON `
        -D onnxruntime_BUILD_UNIT_TESTS=OFF `
        -D onnxruntime_ENABLE_PYTHON=OFF `
        -D onnxruntime_ENABLE_STATIC_ANALYSIS=OFF `
        -D onnxruntime_ENABLE_TRAINING=OFF `
        -D onnxruntime_GENERATE_TEST_REPORTS=OFF `
        -D onnxruntime_PREFER_SYSTEM_LIB=ON `
        -D onnxruntime_RUN_ONNX_TESTS=OFF `
        -D onnxruntime_USE_CUDA=OFF `
        -D onnxruntime_USE_DNNL=OFF `
        -D onnxruntime_USE_FULL_PROTOBUF=ON `
        -D onnxruntime_USE_MPI=ON `
        -D onnxruntime_USE_OPENMP=ON `
        -D onnxruntime_USE_PREINSTALLED_EIGEN=ON `
        -S ../onnxruntime/cmake

    mingw32-make -j 4
    mingw32-make install
    ls
    cd ..
}
