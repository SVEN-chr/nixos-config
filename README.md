# NixOS 配置

个人 NixOS 系统配置，基于 Flakes 和 Home Manager。

## 系统信息

- **主机名**: sven
- **用户**: chr
- **架构**: x86_64-linux
- **桌面环境**: KDE Plasma 6
- **终端**: Alacritty + Starship
- **编辑器**: Neovim

## 特性

### 🌐 网络配置
- 自动代理配置 (socks5://127.0.0.1:7897)
- 中国大陆网络优化

### 🎨 桌面环境
- KDE Plasma 6 桌面
- SDDM 显示管理器
- 自动登录配置
- 中文输入法 (fcitx5)

### 🛠️ 开发工具
- Claude Code (带代理配置)
- VS Code
- Node.js 22
- Git
- GitHub CLI

### 📝 配置特点
- Home Manager 集成
- 声明式配置管理
- 中文注释文档
- 模块化结构

## 文件结构

```
nixos-config/
├── configuration.nix    # NixOS 系统配置
├── home.nix            # Home Manager 用户配置
├── flake.nix           # Flake 配置文件
├── hardware-configuration.nix  # 硬件配置 (自动生成)
├── CLAUDE.md           # Claude Code 开发文档
└── README.md           # 本文档
```

## 使用方法

### 初始部署

1. 克隆配置到 `/etc/nixos/`:
```bash
git clone https://github.com/SVEN-chr/nixos-config.git /etc/nixos/
```

2. 重建系统:
```bash
sudo nixos-rebuild switch --flake /etc/nixos#sven
```

### 日常更新

1. 更新配置:
```bash
cd /etc/nixos
git pull
```

2. 重建系统:
```bash
sudo nixos-rebuild switch --flake .#sven
```

3. 更新输入源:
```bash
nix flake update
sudo nixos-rebuild switch --flake .#sven
```

## 主要软件

### 系统级软件
- Neovim - 编辑器
- GCC - 编译器
- FastFetch - 系统信息

### 用户软件
- Claude Code - AI 编程助手
- VS Code - 代码编辑器
- Google Chrome - 浏览器
- Clash Verge Rev - 代理客户端

### 字体
- Maple Mono - 编程字体
- Maple Mono Nerd Font - 带图标的编程字体

## Claude Code 配置

本配置包含专门为 Claude Code 优化的设置:

- **代理支持**: 自动通过本地代理访问
- **权限预设**: 预配置常用文件和命令权限
- **主题**: 暗色主题
- **Co-authored**: 自动添加协作标记

详见 [CLAUDE.md](CLAUDE.md) 获取更多开发信息。

## 自定义

### 修改用户信息
在 `home.nix` 中更新:
```nix
home.username = "your-username";
home.homeDirectory = "/home/your-username";
programs.git.userName = "Your Name";
programs.git.userEmail = "your@email.com";
```

### 修改主机名
在 `configuration.nix` 中更新:
```nix
networking.hostName = "your-hostname";
```

在 `flake.nix` 中更新:
```nix
nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
```

## 许可证

此配置仅供个人使用。