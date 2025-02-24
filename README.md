chmod +x /root/restart_csgo_hk.sh

crontab -e

0 3 * * * /root/restart_csgo_hk.sh >> /root/restart_csgo.log 2>&1
