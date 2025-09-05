# NixOS 系统配置文件

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # 引导加载器配置
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
#  boot.loader.efiInstallAsRemovable = true;

  # 网络配置
  networking.hostName = "sven";
  networking.proxy.default = "socks5://127.0.0.1:7897";
  networking.networkmanager.enable = true;

  # 时区和本地化
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # 图形界面配置
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # 打印服务
  services.printing.enable = true;

  # 音频配置 (使用 PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # 用户账户配置
  users.users.chr = {
    isNormalUser = true;
    description = "chr";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # 自动登录
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "chr";

  # 浏览器
  programs.firefox.enable = true;

  # 允许非自由软件
  nixpkgs.config.allowUnfree = true;

  # 启用实验性功能
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # 系统软件包
  environment.systemPackages = with pkgs; [
    neovim
    fastfetch
    gcc
  ];

  # 字体配置
  fonts.packages = with pkgs; [
    maple-mono.truetype        # Maple Mono TTF
    maple-mono.NF-unhinted     # Maple Mono Nerd Font
    maple-mono.NF-CN-unhinted  # Maple Mono 中文版
  ];

  # 系统状态版本 (请勿随意修改)
  system.stateVersion = "25.05";
}
