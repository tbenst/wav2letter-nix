let
  nixpkgs = import ./nixpkgs.nix {
    config = {
      allowUnfreePredicate = pkg: builtins.elem (pkg.name) [
        "mkl-2019.0.117"
      ];
    };
  };
  callPackage = nixpkgs.lib.callPackageWith (nixpkgs // pkgs);
  pkgs = {
    arrayfire = callPackage ./arrayfire.nix { };
    mkl = callPackage ./mkl.nix { };
    mkl-dnn = callPackage ./mkl-dnn.nix { };
    flashlight = callPackage ./flashlight.nix { };
    kenlm = callPackage ./kenlm.nix { };
    gloo = callPackage ./gloo.nix { };
    wav2letter = callPackage ./wav2letter.nix { };
  };
in
  pkgs.wav2letter
