{ stdenv, fetchurl, cmake, fftw, liblapack, blas, openblas, pkgconfig, fftwSinglePrec, boost, mkl}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "arrayfire${version}";
  version = "3.6.1";

  src = fetchurl {
    url = "https://arrayfire.s3.amazonaws.com/arrayfire_source/arrayfire-full-3.6.1.tar.bz2";
    sha256 = "156d4a6y3sd03raca9wk1bdwib3h4b33plh13r3dc5wpwd9h3gz3";
  };

  nativeBuildInputs = [ cmake pkgconfig ];
  buildInputs = [ fftw liblapack blas fftwSinglePrec boost];

  preConfigure = ''
    cmakeFlags+="-DBUILD_TESTING=OFF -DAF_BUILD_EXAMPLES=OFF \
    -DMKL_INCLUDE_DIR=${mkl}/include \
    -DDUSE_OPENCL_MKL=ON \
    -DUSE_CPU_MKL=ON \
    -DMKL_Core_LINK_LIBRARY=${mkl}/lib"
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${mkl}/lib
    MKL_ThreadingLibrary_LINK_LIBRARY:"${mkl}/lib/libiomp5.so"
  '';

  meta = {
    description = "ArrayFire: a general purpose GPU library.";
    homepage    = "https://arrayfire.com";
    license     = licenses.bsd3;
    platforms   = platforms.all;
    maintainers = with maintainers; [ ];
  };
}
