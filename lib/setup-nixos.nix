{ self, nixpkgs, inputs }:

{ name, system }: nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    host = {
      hostName = name;
    };
  };
  
  modules = [
    {
      nixpkgs.pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # Allow proprietary software
        # config.segger-jlink.acceptLicense = true;
      };
      _module.args.nixpkgs = nixpkgs;
      _module.args.systemName = name;
      _module.args.self = self;
      _module.args.vars = self.vars;
      # _module.args.sources = self.sources;
    }
    ../hosts
    (../hosts + "/${name}" + /configuration.nix)
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit nixpkgs;
          inherit (self) vars;
        };
        sharedModules = nixpkgs.lib.attrsets.mapAttrsToList (name: value: value) self.homeManagerModules;
      };
    }
  ] ++ nixpkgs.lib.attrsets.mapAttrsToList (name: value: value) self.nixosModules;
}
