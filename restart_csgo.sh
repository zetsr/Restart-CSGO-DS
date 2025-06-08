#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 定义变量
SCREEN_NAME="csgo"
CSGO_DIR="/root/csgo_ds"

# 启动参数列表，动态维护
STARTUP_ARGS=(
    "-game csgo"
    "-console"
    "-insecure"
    "-usercon"
    "-net_port_try 1"
    "-ip 0.0.0.0"
    "-port 27015"
    "+tv_port 50001"
    "+tv_port1 60001"
    "+sv_setsteamaccount EBC8CAEBB7DED4B22A98F88626E7BA93"
    "+sv_tags HvH"
    "+map de_mirage"
    "+game_alias wingman"
    "+game_mode 2"
    "+game_type 0"
)

# 判断screen会话是否存在的函数，严格匹配完整会话名
screen_session_exists() {
    screen -list | grep -Pq "\.${SCREEN_NAME}\s"
}

# 停止CSGO服务器
if screen_session_exists; then
    echo "检测到screen会话 '${SCREEN_NAME}'，准备关闭..."
    screen -S "$SCREEN_NAME" -X stuff $'quit\n'
    
    timeout=30
    while [ $timeout -gt 0 ]; do
        if ! screen_session_exists; then
            echo "会话 '${SCREEN_NAME}' 已成功关闭。"
            break
        fi
        sleep 1
        timeout=$((timeout - 1))
    done
    
    if screen_session_exists; then
        echo "会话 '${SCREEN_NAME}' 关闭超时，强制终止..."
        screen -S "$SCREEN_NAME" -X quit
        sleep 5
    fi
else
    echo "没有检测到screen会话 '${SCREEN_NAME}'，无需关闭。"
fi

# 启动CSGO服务器
echo "启动CSGO服务器，screen会话名：${SCREEN_NAME}，工作目录：${CSGO_DIR}"
cd "$CSGO_DIR" || { echo "切换到目录 '${CSGO_DIR}' 失败，退出脚本"; exit 1; }

# 直接展开数组，传递启动参数
screen -dmS "$SCREEN_NAME" ./srcds_run "${STARTUP_ARGS[@]}"
