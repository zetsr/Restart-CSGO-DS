import os
import time
import psutil
import subprocess

# ====== 配置参数 ======
PROCESS_NAME = "srcds.exe"  # 要管理的可执行文件名
WORK_DIR = r"C:\Your_Servers"  # 正确的进程工作目录

STARTUP_ARGS = [
    "-game", "csgo",
    "-console",
    "-insecure",
    "-usercon",
    "-net_port_try", "1",
    "-ip", "0.0.0.0",
    "-port", "27015",
    "+tv_port", "50000",
    "+tv_port1", "60000",
    "+sv_setsteamaccount", "YOUR_KEY",
    "+sv_tags", "",
    "+map", "de_mirage",
    "+game_alias", "wingman",
    "+game_mode", "2",
    "+game_type", "0",
]

# ====== 工具函数 ======

def find_and_kill_process_by_name(name, expected_dir):
    """
    查找并终止与指定名称和目录完全匹配的进程。
    只会杀死路径匹配 expected_dir/name 的进程。
    """
    killed_any = False
    expected_exe_path = os.path.abspath(os.path.join(expected_dir, name))

    for proc in psutil.process_iter(['pid', 'name', 'exe']):
        try:
            if proc.info['name'] and proc.info['name'].lower() == name.lower():
                exe_path = proc.info.get('exe')
                if exe_path and os.path.abspath(exe_path) == expected_exe_path:
                    print(f"[INFO] 正在终止目标进程 PID={proc.pid} 路径={exe_path}")
                    proc.kill()
                    proc.wait(timeout=10)
                    killed_any = True
                else:
                    print(f"[DEBUG] 忽略非目标路径进程 PID={proc.pid} 路径={exe_path}")
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            continue

    if not killed_any:
        print(f"[INFO] 未找到匹配路径的进程 {name}，无需关闭。")


def start_server():
    """
    启动服务器进程。
    """
    exe_path = os.path.join(WORK_DIR, PROCESS_NAME)
    if not os.path.isfile(exe_path):
        print(f"[ERROR] 可执行文件不存在: {exe_path}")
        return None

    cmd = [exe_path] + STARTUP_ARGS
    print(f"[INFO] 启动服务器进程: {cmd}")
    process = subprocess.Popen(cmd, cwd=WORK_DIR, shell=False)
    print(f"[INFO] 服务器进程已启动，PID={process.pid}")
    return process

# ====== 主程序入口 ======

def main():
    find_and_kill_process_by_name(PROCESS_NAME, WORK_DIR)
    time.sleep(2)  # 等待旧进程完全退出
    start_server()

if __name__ == "__main__":
    main()
