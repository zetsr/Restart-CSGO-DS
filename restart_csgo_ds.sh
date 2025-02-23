#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 停止CSGO服务器
if screen -list | grep -q "csgo"; then
    # 发送退出命令（假设服务器接受'quit'命令）
    screen -S csgo -X stuff $'quit\n'
    
    # 等待最多30秒，检测服务器是否关闭
    timeout=30
    while [ $timeout -gt 0 ]; do
        if ! screen -list | grep -q "csgo"; then
            break
        fi
        sleep 1
        timeout=$((timeout-1))
    done
    
    # 若未关闭，强制终止
    if screen -list | grep -q "csgo"; then
        screen -S csgo -X quit
        sleep 5
    fi
fi

# 启动CSGO服务器（替换为你的实际启动命令）
cd /root/csgo_ds
screen -dmS csgo ./srcds_run -game csgo -console -insecure -usercon -net_port_try 1 -ip 0.0.0.0 -port 27015