{ nixpkgs ? import <nixpkgs> {} }:
(import ./packages.nix { inherit nixpkgs; }).gpipe-hello.env
