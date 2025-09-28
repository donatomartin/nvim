{

  programs.nixvim = {

    enable = true;
    nixpkgs.useGlobalPackages = true;

    imports = [
      ./config.nix
    ];

  };

}
