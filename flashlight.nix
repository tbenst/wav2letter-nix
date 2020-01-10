{ stdenv, fetchurl, cmake, arrayfire, mkl, mkl-dnn, glog, gflags, openmpi, git
, cereal, gloo}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "flashlight-${version}";
  version = "857cf54f83dbc66f57a7465325edb884d490312f";
  # version = "349e8cfa261a70dd30ab336c44c6985b45555141";

  src = fetchurl {
    url = "https://github.com/facebookresearch/flashlight/archive/${version}.tar.gz";
    sha256 = "1vnch9zvmqxzp60gn2wb21qhb59f2fp7z60bzv0xaa86xrk076aj";
    # sha256 = "0pr8mykqqy9gks6wvca9k4wix0kz2rxqblhzpn7arvs1givpcscn";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ arrayfire glog gflags mkl mkl-dnn openmpi git gloo cereal ];

  cmakeFlags = [
    "-DFLASHLIGHT_BACKEND=CPU"
    "-DFL_BUILD_TESTS=OFF"
    "-DFL_BUILD_EXAMPLES=OFF"
  ];

  MKLROOT=mkl;
  MKLDNN_ROOT=mkl-dnn;
  CEREAL_ROOT=cereal;

  meta = {
    description = "A C++ standalone library for machine learning";
    homepage    = "https://fl.readthedocs.io/en/latest/";
    license     = licenses.bsd3;
    platforms   = platforms.all;
    maintainers = with maintainers; [ ];
  };
}
