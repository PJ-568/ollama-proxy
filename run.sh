#!/usr/bin/env bash

# 设置定量
## 当前脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 运行
caddy run --config $SCRIPT_DIR/Caddyfile --envfile $SCRIPT_DIR/caddy.env
