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

# 停止并删除服务
recho "停止并删除服务文件" "Stop and delete service file"
sudo systemctl stop ollama-proxy.service
sudo systemctl disable ollama-proxy.service
sudo rm /etc/systemd/system/ollama-proxy.service

# 删除项目文件夹
recho "删除项目文件夹" "Delete project folder"
rm -rf $SCRIPT_DIR

recho "卸载完成！" "Uninstall complete!"