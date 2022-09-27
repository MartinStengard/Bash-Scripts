## Auto Connect to vpn service on start up
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

# Connect to VPN service
if ! echo $(ifconfig)|grep -q SEintegrity_vpn;
then 
        wg-quick up SEintegrity_vpn
        echo "VPN now started"
else
        echo "VPN already started"
fi
echo ""
```

## Add entry to cron table
```
sudo vi /etc/crontab
```
```
@reboot root      /etc/cron.d/startup.sh >> /var/log/cronErrLog.txt 2>&1
@reboot root      /bin/sleep 120;/etc/cron.d/startup.sh >> /var/log/cronErrLog.txt 2>&1
```
