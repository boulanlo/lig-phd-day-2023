{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive) scheme-basic latex-bin latexmk xetex
          pgf tikzposter xkeyval xstring etoolbox extsizes a0poster helvetic minted metafont ec; 
        };
        source-tex-file = "poster.tex";
        target-pdf-file = "poster.pdf";
        buildInputs = [ pkgs.coreutils tex pkgs.python39 pkgs.python39Packages.pygments pkgs.which pkgs.ncurses pkgs.gawk ];
      in
        rec {
          packages = {
            poster = pkgs.stdenvNoCC.mkDerivation rec {
              name = "lig-phd-days-2023-poster";
              src = self;
              inherit buildInputs;

              phases = [ "unpackPhase" "buildPhase" "installPhase" ];

              buildPhase = ''
                export PATH="${pkgs.lib.makeBinPath buildInputs}"
                mkdir -p .cache/texmf-var
                ls -al
                pygmentize -V
                env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
                  SOURCE_DATE_EPOCH=${toString self.lastModified} \
                  latexmk -shell-escape -interaction=nonstopmode -pdf -pdflatex \
                  -pretex="\pdfvariable suppressoptionalinfo 512\relax" \
                  ${source-tex-file}
                '';

              installPhase = ''
                mkdir -p "$out"
                cp ${target-pdf-file} $out/
              '';
            };
          };

          defaultPackage = packages.poster;
        }
    );
}
