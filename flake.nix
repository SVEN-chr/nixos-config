# NixOS Flake 配置文件

{
  description = "chr 的 NixOS 系统配置";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      # 确保 home-manager 使用与当前 flake 相同版本的 nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # 主机配置
    nixosConfigurations.sven = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # 导入系统配置
        ./configuration.nix
        
        # 集成 Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.chr = import ./home.nix;
        }
      ];
    };
  };
}