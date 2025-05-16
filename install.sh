#!/usr/bin/env bash

# 设置定量
## 当前脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
## 当前语言
CURRENT_LANG=0
## 当前用户名
CURRENT_USER=$(whoami)

# 语言检测
if [ $(echo ${LANG/_/-} | grep -Ei "\\b(zh|cn)\\b") ]; then CURRENT_LANG=1;  fi

# 本地化
recho() {
  if [ $CURRENT_LANG == 1 ]; then
    ## zh-Hans
    echo $1;
  else
    ## en-US
    echo $2;
  fi
}

# 检查 caddy 是否安装
if ! command -v caddy &> /dev/null; then
  recho "caddy 未安装，请先安装 caddy" "caddy is not installed, please install caddy first"
  exit 1
fi

# 检查 git 是否安装
if ! command -v git &> /dev/null; then
  recho "git 未安装，请先安装 git" "git is not installed, please install git first"
  exit 1
fi

# 创建目录
recho "创建目录" "Create directory"
mkdir -p /home/$CURRENT_USER/.local/bin/

# 检查是否存在项目文件夹
if [ -d "/home/$CURRENT_USER/.local/bin/ollama-proxy" ]; then
  recho "项目文件夹已存在，请先卸载" "Project folder already exists, please uninstall first"
  recho "运行 /home/$CURRENT_USER/.local/bin/ollama-proxy/uninstall.sh 卸载" "To uninstall, run: /home/$CURRENT_USER/.local/bin/ollama-proxy/uninstall.sh"
  exit 1
fi

# 拉取项目
recho "拉取项目" "Pull project"
git clone https://github.com/PJ-568/ollama-proxy.git --depth 1 /home/$CURRENT_USER/.local/bin/ollama-proxy

# 创建环境文件
recho "创建环境文件" "Create environment file"
cp /home/$CURRENT_USER/.local/bin/ollama-proxy/caddy.example.env /home/$CURRENT_USER/.local/bin/ollama-proxy/caddy.env

# 检查是否存在服务文件
if [ -f "/etc/systemd/system/ollama-proxy.service" ]; then
  recho "服务文件已存在，请先删除" "Service file already exists, please delete it first"
  recho "运行 sudo rm /etc/systemd/system/ollama-proxy.service 以删除" "To delete, run: sudo rm /etc/systemd/system/ollama-proxy.service"
  exit 1
fi

# 创建服务文件
recho "创建服务文件" "Create service file"
sudo tee /etc/systemd/system/ollama-proxy.service > /dev/null << EOF
[Unit]
Description=Ollama Key Proxy Service
After=network.target

[Service]
Type=simple
User=$CURRENT_USER
WorkingDirectory=/home/$CURRENT_USER/.local/bin/ollama-proxy
ExecStart=/home/$CURRENT_USER/.local/bin/ollama-proxy/run.sh
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# 启用服务
recho "启用服务" "Enable service"
sudo systemctl daemon-reload
sudo systemctl enable ollama-proxy.service

recho "安装完成！" "Installation complete!"
recho "运行 /home/$CURRENT_USER/.local/bin/ollama-proxy/uninstall.sh 卸载" "To uninstall, run: /home/$CURRENT_USER/.local/bin/ollama-proxy/uninstall.sh"
recho "请编辑配置文件 /home/$CURRENT_USER/.local/bin/ollama-proxy/caddy.env" "Please modify the configuration file /home/$CURRENT_USER/.local/bin/ollama-proxy/caddy.env"
recho "然后运行命令以运行服务：" "Then run the following command to start the service:"
recho "  systemctl start ollama-proxy.service" "  systemctl start ollama-proxy.service"