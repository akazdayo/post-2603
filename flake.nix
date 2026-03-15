{
  description = "A Nix-flake-based Typst development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1"; # unstable Nixpkgs

  outputs =
    { self, ... }@inputs:

    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import inputs.nixpkgs {
              inherit system;
            };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        let
          typstFontPaths = [
            "${pkgs.ipafont}/share/fonts"
          ];
        in
        {
          default = pkgs.mkShellNoCC {
            packages =
              with pkgs;
              [
                ipafont
                typst
                typstyle
                tinymist
              ]
              ++ (with typstPackages; [
                # Typst packages
              ]);

            # Force Typst to see the bundled static Japanese font in nix develop.
            TYPST_FONT_PATHS = builtins.concatStringsSep ":" typstFontPaths;
          };
        }
      );
    };
}
