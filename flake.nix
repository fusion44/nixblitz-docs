{
  description = "NixBlitz Docs";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    name = "nixblitz-docs";
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    packages = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
      docsPackage = pkgs.callPackage ./default.nix {};
    in {
      "${name}" = docsPackage;
      default = docsPackage;
    });

    defaultPackage = forAllSystems (system: self.packages.${system}.default);
  };
}
