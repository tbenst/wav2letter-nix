{ stdenv, fetchurl, cmake, arrayfire, mkl, mkl-dnn, glog, gflags, openmpi, git
, cereal, gloo}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "flashlight-${version}";
  version = "cd535bf887ca1763f30e9a7c2480c48a8abe25e5";

  src = fetchurl {
    url = "https://github.com/facebookresearch/flashlight/archive/${version}.tar.gz";
    sha256 = "1576511vmds98vwvi43i5954898y488nlbfg88v63a0i8f5zdcqj";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ arrayfire glog gflags mkl mkl-dnn openmpi git gloo cereal ];

  cmakeFlags = [
    "-DFLASHLIGHT_BACKEND=CPU"
    "-DFL_BUILD_TESTS=OFF"
    "-DFL_BUILD_EXAMPLES=OFF"
    "-DFL_BUILD_EXAMPLES=OFF"
  ];

  MKLROOT=mkl;
  MKLDNN_ROOT=mkl-dnn;
  CEREAL_ROOT_DIR="${cereal}/include/cereal";

  meta = {
    description = "A C++ standalone library for machine learning";
    homepage    = "https://fl.readthedocs.io/en/latest/";
    license     = licenses.bsd3;
    platforms   = platforms.all;
    maintainers = with maintainers; [ ];
  };
}
