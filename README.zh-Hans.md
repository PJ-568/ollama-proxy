# Ollama API 认证代理

[English](README.md) | 简体中文

一个使用 Caddy 服务器为 Ollama API 添加认证层的安全反向代理。通过 Bearer Token 认证保护您的 Ollama 实例。
简而言之，用密钥 key 访问您的 Ollama API。

## 功能特性

- 🔒 **Bearer Token 认证** - 使用 API 密钥保护您的 Ollama API
- 🔄 **反向代理** - 无缝代理请求到 Ollama
- 🔐 **HTTPS 支持** - 可选的自动 SSL 配置
- 🚀 **轻量级** - 使用 Caddy 服务器实现最小开销
- ⚙️ **Systemd 服务** - 作为后台服务易于管理

## 系统要求

- 带有 systemd 的 Linux 系统
- 已安装 Caddy 服务器 (`sudo apt install caddy` 或等效命令)
- 安装需要 Git
- 本地运行的 Ollama (默认端口 11434)

## 安装指南

### 自动安装

```bash
curl -sSL https://raw.githubusercontent.com/PJ-568/ollama-proxy/refs/heads/master/install.sh | bash
```

### 手动安装

1. 克隆本仓库:

   ```bash
   git clone https://github.com/PJ-568/ollama-proxy.git --depth 1
   cd ollama-proxy
   ```

2. 复制配置文件:

   ```bash
   cp caddy.example.env caddy.env
   ```

3. 编辑配置文件:

   ```bash
   nano caddy.env
   ```

   设置您需要的 PORT、OLLAMA_PORT 和 API_KEY

4. 运行:

   ```bash
   ./run.sh
   ```

## 配置说明

编辑`caddy.env`中的以下变量:

```env
PORT=3003  # 代理端口
OLLAMA_PORT=11434  # Ollama端口
API_KEY='your-secret-key'  # 认证密钥
```

如需 HTTPS 支持，取消 `Caddyfile` 中的 `tls` 行注释并提供有效的邮箱地址。

## 使用方法

安装并运行后，通过代理访问您的 Ollama API:

```bash
curl -H "Authorization: Bearer your-secret-key" http://localhost:3003/
```

将 `3003` 替换为您设置的端口。
将 `your-secret-key` 替换为 `caddy.env` 中的 API_KEY。

## 卸载方法

要完全移除代理:

```bash
cd /home/$(whoami)/.local/bin/ollama-proxy # 切换到安装目录
./uninstall.sh
```

## 贡献指南

欢迎贡献！请阅读 [CONTRIBUTING.md](CONTRIBUTING.md) 了解指南。

## 许可证

本项目遵循 [LICENSE](LICENSE) 文件中的许可条款。
