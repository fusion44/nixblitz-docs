{pkgs, ...}: {
  packages = [pkgs.git pkgs.alejandra pkgs.prettier];

  languages = {
    nix.enable = true;
    javascript = {
      enable = true;
      yarn = {
        enable = true;
        install.enable = true;
      };
    };
  };
}
