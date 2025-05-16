# Ollama API Authentication Proxy

[简体中文](README.zh-Hans.md) | English

A secure reverse proxy that adds authentication layer to Ollama API using Caddy server. Protect your Ollama instance with Bearer Token authentication.
In short, use key to access your Ollama API.

## Features

- 🔒 **Bearer Token Authentication** - Secure your Ollama API with API keys
- 🔄 **Reverse Proxy** - Seamlessly proxies requests to Ollama
- 🔐 **HTTPS Support** - Optional automatic SSL configuration
- 🚀 **Lightweight** - Minimal overhead using Caddy server
- ⚙️ **Systemd Service** - Easy management as a background service

## Requirements

- Linux system with systemd
- Caddy server installed (`sudo apt install caddy` or equivalent)
- Git for installation
- Ollama running locally (default port 11434)

## Installation

### Auto Install

```bash
curl -sSL https://raw.githubusercontent.com/PJ-568/ollama-proxy/refs/heads/master/install.sh | bash
```

### Manual Install

1. Clone this repository:

   ```bash
   git clone https://github.com/PJ-568/ollama-proxy.git --depth 1
   cd ollama-proxy
   ```

2. Copy configuration file:

   ```bash
   cp caddy.example.env caddy.env
   ```

3. Edit the configuration file:

   ```bash
   nano caddy.env
   ```

   Set your desired PORT, OLLAMA_PORT and API_KEY

4. Run:

   ```bash
   ./run.sh
   ```

## Configuration

Edit `caddy.env` with these variables:

```env
PORT=3003  # Proxy port
OLLAMA_PORT=11434  # Ollama port
API_KEY='your-secret-key'  # Authentication key
```

For HTTPS support, uncomment the `tls` line in `Caddyfile` and provide a valid email address.

## Usage

After installation, run, then access your Ollama API through the proxy:

```bash
curl -H "Authorization: Bearer your-secret-key" http://localhost:3003/
```

Replace `3003` with your PORT from `caddy.env`.
Replace `your-secret-key` with your API_KEY from `caddy.env`.

## Uninstallation

To completely remove the proxy:

```bash
cd /home/$(whoami)/.local/bin/ollama-proxy # Change to the directory where you installed
./uninstall.sh
```

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the terms of the [LICENSE](LICENSE) file.
