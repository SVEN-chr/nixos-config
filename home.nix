# Home Manager 用户配置文件

{ config, pkgs, ... }:

{
  # 用户基本信息
  home.username = "chr";
  home.homeDirectory = "/home/chr";

  # 用户软件包
  home.packages = with pkgs; [
    # 开发工具
    nodejs_22
    vscode
    
    # 网络工具
    clash-verge-rev
    google-chrome
    
    # 主题
    catppuccin-fcitx5
    
    # 系统工具
    gh
  ];

  # 中文输入法配置
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-gtk
      kdePackages.fcitx5-qt
      fcitx5-rime
      fcitx5-configtool
    ];
  };

  # Git 配置
  programs.git = {
    enable = true;
    userName = "sven";
    userEmail = "chr1768902202@gmail.com";
  };

  # Claude Code 配置
  programs.claude-code = {
    enable = true;
    settings = {
      # 基础配置
      theme = "dark";
      includeCoAuthoredBy = true;
      
      # 环境变量配置（包含代理设置）
      env = {
        http_proxy = "http://127.0.0.1:7897";
        https_proxy = "http://127.0.0.1:7897";
        all_proxy = "socks5://127.0.0.1:7897";
      };
      
      # 权限配置
      permissions = {
        # 允许的操作
        allow = [
          "Read"
          "Write" 
          "Edit"
          "MultiEdit"
          "Glob"
          "Grep"
          "LS"
          "Bash(git *)"
          "Bash(nix *)"
          "Bash(nixos-rebuild *)"
        ];
        
        # 需要确认的操作
        ask = [
          "Bash(rm *)"
          "Bash(sudo *)"
          "WebFetch"
        ];
        
        # 额外允许访问的目录
        additionalDirectories = [
          "../"
          "/etc/nixos/"
        ];
      };
    };
  };

  # Starship 终端提示符
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # Alacritty 终端配置
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  # Bash 配置
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = '''';
    shellAliases = {
      ai = "claude --dangerously-skip-permissions";
    };
  };

  # Home Manager 状态版本 (请勿随意修改)
  home.stateVersion = "25.05";
}