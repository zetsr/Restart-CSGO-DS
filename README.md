chmod +x /root/restart_csgo_ds.sh

crontab -e

0 3 * * * /root/restart_csgo_ds.sh >> /root/restart_csgo.log 2>&1
