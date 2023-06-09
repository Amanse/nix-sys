{webcord, pkgs,...}:
{
home.packages = [webcord.packages.${pkgs.system}];
}
