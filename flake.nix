{
  description = "Configuration of Sombrer0Dev";

  outputs = inputs @{
    self,
    nixpkgs,
    home-manager,
    ...
  }: {
    packages.x86_64-linux.default =
      nixpkgs.legacyPackages.x86_64-linux.callPackage ./ags {inherit inputs;};
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        specialArgs = {
        inherit inputs;
        asztal = self.packages.x86_64-linux.default;
        };
        # > Our main nixos configuration file <
        modules = [
          ./nixos/nixos.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "sombrer01@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs;};
        # > Our main home-manager configuration file <
        modules = [./home-manager/home.nix];
      };
    };
  };


  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";

    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };
}
