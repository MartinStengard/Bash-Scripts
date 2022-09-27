## Auto Reset UFW on start up
Place to create the script file > /etc/cron.d/  
Filename is startup.sh

```
#!/bin/bash
set -e

echo -------------------------------------------------
printf -v current_date '%(%Y-%m-%d %H:%M:%S)T\n' -1 
echo $current_date
echo -------------------------------------------------
echo ""

# reset and start firewall
ufw --force reset && sudo ufw enable
echo "Firewall reset and enabled"
sleep 5
echo -------------------------------------------------
```

## Add entry to cron table
```
sudo vi /etc/crontab
```
```
@reboot root      /etc/cron.d/startup.sh >> /var/log/cronErrLog.txt 2>&1
@reboot root      /bin/sleep 120;/etc/cron.d/startup.sh >> /var/log/cronErrLog.txt 2>&1
```
