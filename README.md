# GPipe Hello

This project contains an 'Hello world'-like example of an application that uses GPipe for 3D rendering. The Haskell code is based on [a blog post](http://tobbebex.blogspot.nl/2015/09/gpipe-is-dead-long-live-gpipe.html) from the original author.

## Dependencies

 * [GPipe](https://wiki.haskell.org/GPipe) for rendering
 * [GPipe-GLFW](https://github.com/plredmond/GPipe-GLFW) for windowing integration using GLFW
 * [linear](https://github.com/ekmett/linear/) for linear algebra
 * [JuicyPixels](https://github.com/Twinside/Juicy.Pixels) for image loading

## Project Structure

The application can be built using
* `cabal install` (possibly from a `nix-shell`)
* `nix-build`

Or you can install it directly with
* `nix-env -i -A gpipe-hello -f packages.nix`

### Nix

[Nix](https://nixos.org/nix/) can be used to get the application up and running in a deterministic and reproducable way.

* `default.nix` simple entrypoint that redirects to the derivation that builds the application. Selected automatically when invoking `nix-build`
* `shell.nix` points to a derivation that contains the relevant build tools, useful for development. Selected automatically when invoking `nix-shell`
* `packages.nix` defines the `gpipe-hello` package using the autogenerated nix expression in `gpipe-hello.nix` and makes it available 'among' all other haskell packages
* `cabal2nix` is a script that runs the cabal2nix tool to regenerate the derived file `gpipe-hello.nix`. The cabal2nix tool is available when in the `nix-shell`.