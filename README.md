# LIG PhD day 2023 poster
Enjoy the monstrous Tikz diagrams, I guess!

## How to build
### Nix/NixOS
- On [Flake-enabled systems](https://nixos.wiki/wiki/Flakes), run `nix build`.
- Without flakes, run `nix-build`.

For both situations the resulting PDF file will be located inside the `result` folder and in the Nix store.
### Linux and (probably) MacOS
- Ensure that you have the following dependencies installed and available on your system:
  - A LaTeX installation with `latexmk` and `pdflatex` installed, as well as the following packages:
    - `pgf`
    - `tikzposter`
    - `xkeyval`
    - `xstring`
    - `etoolbox`
    - `extsizes`
    - `a0poster`
    - `helvetic`
    - `minted`
    - `metafont`
    - `ec`
  - Python 3.9 with the `pygments` package installed
- Run `latexmk -shell-escape -interaction=nonstopmode -pdf -pdflatex poster.tex`. Normally it should work. Not tested. Probably won't try and give the correct non-Nix procedure, but this should give you the first steps.
