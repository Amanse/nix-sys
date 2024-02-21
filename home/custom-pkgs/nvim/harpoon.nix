self: super: {
  harpoon = super.vimUtils.buildVimPlugin {
    name = "harpoon";
    src = super.fetchFromGitHub {
      "owner" = "ThePrimeagen";
      "repo" = "harpoon";
      "rev" = "2cd4e03372f7ee5692c8caa220f479ea07970f17";
      "hash" = "sha256-MUIGRoaFcCqqFatfnFJpnEOUmSYJgV2+teU/NXj6kgY=";
    };
  };
}
