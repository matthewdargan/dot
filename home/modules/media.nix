{self, ...}: {pkgs, ...}: {
  home.packages = [
    pkgs.rain-bittorrent
    self.packages.${pkgs.system}.epify
    self.packages.${pkgs.system}.mooch
  ];
}
