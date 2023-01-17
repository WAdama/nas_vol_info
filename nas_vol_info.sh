#!/bin/bash
# Version 1.0.3

VOL=$1
IFS=" " read -r FS TOTAL USED AVAIL PERC VOLNAME <<< "$(df -k /"$VOL" | grep /"$VOL")"
PERC=${PERC//\%/}
echo "<?xml version=\"10.0\" encoding=\"UTF-8\" ?><prtg><result><channel>Total</channel><value>$((TOTAL*1024))</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result><result><channel>Used</channel><value>$((USED*1024))</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result><result><channel>Available</channel><value>$((AVAIL*1024))</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result><result><channel>Used (%)</channel><value>$PERC</value><unit>Percent</unit><LimitMode>1</LimitMode><LimitMaxWarning>90</LimitMaxWarning><LimitMaxError>95</LimitMaxError></result>"
echo "<text>Volume: $VOL</text></prtg>"
exit
