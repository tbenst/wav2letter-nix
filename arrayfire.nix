{ stdenv, fetchurl, cmake, fftw, liblapack, blas, openblas, pkgconfig, fftwSinglePrec, boost, mkl}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "arrayfire${version}";
  version = "3.6.4";

  src = fetchurl {
    url = "https://arrayfire.s3.amazonaws.com/arrayfire_source/arrayfire-full-3.6.4.tar.bz2";
    sha256 = "1fin7a9rliyqic3z83agkpb8zlq663q6gdxsnm156cs8s7f7rc9h";
  };

  nativeBuildInputs = [ cmake pkgconfig ];
  buildInputs = [ fftw liblapack blas fftwSinglePrec boost mkl ];


  cmakeFlags = [
    "-DBUILD_TESTING=OFF"
    "-DAF_BUILD_EXAMPLES=OFF"
    "-DDUSE_OPENCL_MKL=ON"
    "-DUSE_CPU_MKL=ON"
  ];

  MKLROOT=mkl;

  meta = {
    description = "ArrayFire: a general purpose GPU library.";
    homepage    = "https://arrayfire.com";
    license     = licenses.bsd3;
    platforms   = platforms.all;
    maintainers = with maintainers; [ ];
  };
}
