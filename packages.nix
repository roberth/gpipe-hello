{ nixpkgs ? import <nixpkgs> {} }:
rec {
  packages = haskellngPackages.override { 
    inherit overrides;
  };
  overrides = self: super: {
      gpipe-hello = setSource ./.
                   (lib.addBuildTools
                     (self.callPackage ./gpipe-hello.nix {})
                     [ self.cabal2nix
		       # self.ghc
                     ]
                   );
  };
  inherit (packages) gpipe-hello;
  haskellngPackages = nixpkgs.haskellngPackages;
  lib = nixpkgs.haskell-ng.lib;
  setSource = (dir: pkg: 
          nixpkgs.stdenv.lib.overrideDerivation pkg (oldAttrs: { src = filterDir dir; }));
  filterDir = builtins.filterSource (path: type: type != "unknown" 
		 && baseNameOf path != ".git"
                 && baseNameOf path != "dist"
                 && builtins.match "result.*" (baseNameOf path) == null
                 && builtins.match ".*.nix" (baseNameOf path) == null
                 );

}
