# CSGO Server Restart Scripts

适用于 Linux 和 Windows 系统的 CSGO 服务器重启脚本。

## 功能特性

- 自动终止现有 CSGO 服务器进程
- 使用预设参数启动新服务器实例
- 支持进程存在性检查和安全终止
- 跨平台支持（Linux/Windows）

## 使用前提

### Linux 系统
- 已安装 `screen` 工具
- CSGO 服务器已正确安装

### Windows 系统
- Python 3.x
- 安装 psutil 库：`pip install psutil`

## 使用方法

### Linux 系统
```bash
chmod +x restart_csgo.sh
./restart_csgo.sh
```

### Windows 系统
```bash
python restart_csgo.py
```

## 配置说明

编辑脚本文件中的以下变量以匹配您的环境：

**Linux (restart_csgo.sh):**
- `SCREEN_NAME`: Screen 会话名称
- `CSGO_DIR`: 服务器安装目录
- `STARTUP_ARGS`: 服务器启动参数

**Windows (restart_csgo.py):**
- `PROCESS_NAME`: 可执行文件名
- `WORK_DIR`: 服务器工作目录
- `STARTUP_ARGS`: 服务器启动参数

**重要:** 请确保将 `sv_setsteamaccount` 替换为有效的 Steam 账户令牌。
