# nas_vol_info.sh

Bash script for PRTG by Paessler to monitor an entire volume on your Synology NAS

### Prerequisites

Be sure you have set correct logon values for SSH in your device.

I personally use "Login via private key" with special user for monitoring which also may use sudo without a password.

![Screenshot1](https://github.com/WAdama/nas_shares_info/blob/master/images/ssh.png)

### Installing

Place the script to /var/prtg/scriptsxml on your Synology NAS. You have to create this directory structure because PRTG expects the script here.

In PRTG create under your device which represents your Synology a SSH custom advanced senor.

Choose under "Script" this script and enter under "Parameters" the name of the volume you want to monitor: e.g. volume1.

![Screenshot1](https://github.com/WAdama/nas_vol_info/blob/master/images/nas_vol_info.png)

This script will create for channels in this sensor:
Total: Total space of your volume in GByte
Available: Available space in GByte
Used: Used space in GByte
Used (%): Used space in percent.

This script will set default values for limits in the Used (%) channel:
90% for Upper warning limit
95% for Upper error limit

![Screenshot1](https://github.com/WAdama/nas_vol_info/blob/master/images/nas_vol_info_sensor.png)
