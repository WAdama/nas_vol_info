#!/bin/bash
# Version 1.0
# Inspired by psi-4ward's Icinga-Script, which gave me the hint how to pick the data from the output of 
# btrfs filesystem usage
# https://github.com/psi-4ward/check_btrfs_usage

VOL=$1
USAGE=`btrfs filesystem usage -b /$VOL/`
SIZE=$(echo ""$USAGE"" | grep -F "Device size" | awk '{match($0,"([0-9]+)",a)}END{print a[1]}')
ALLO=$(echo "$USAGE" | grep -F "Device allocated" | awk '{match($0,"([0-9]+)",a)}END{print a[1]}')
UNAL=$(echo "$USAGE" | grep -F "Device unallocated" | awk '{match($0,"([0-9]+)",a)}END{print a[1]}')
MISS=$(echo "$USAGE" | grep -F "Device missing" | awk '{match($0,"([0-9]+)",a)}END{print a[1]}')
USED=$(echo "$USAGE" | grep -F "    Used" | awk '{match($0,"([0-9]+)",a)}END{print a[1]}')
FREE=$(echo "$USAGE" | grep -F "Free (estimated)" | awk '{match($0,"([0-9]+)",a)}END{print a[1]}')
FMIN=$(echo "$USAGE" | grep -F "min:" | awk '{match($0,"min: ([0-9]+)",a)}END{print a[1]}')
RESE=$(echo "$USAGE" | grep -F "Global reserve" | awk '{match($0,"([0-9]+)",a)}END{print a[1]}')
RUSE=$(echo "$USAGE" | grep -F "Global reserve" | awk '{match($0,"used: ([0-9]+)",a)}END{print a[1]}')
PERC=$(awk "BEGIN { pc=100*${USED}/${SIZE}; i=int(pc); print (pc-i<0.5)?i:i+1 }")
echo "<?xml version=\"10.0\" encoding=\"UTF-8\" ?><prtg>
<result><channel>Device size</channel><value>$SIZE</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>
<result><channel>Device allocated</channel><value>$ALLO</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>
<result><channel>Device unallocated</channel><value>$UNAL</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>
<result><channel>Device missing</channel><value>$MISS</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>
<result><channel>Used</channel><value>$USED</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>
<result><channel>Free (est.)</channel><value>$FREE</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>
<result><channel>Free (min.)</channel><value>$FMIN</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>
<result><channel>Global reserve</channel><value>$RESE</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>
<result><channel>Global reserve (used)</channel><value>$RUSE</value><unit>BytesDisk</unit><VolumeSize>GigaByte</VolumeSize></result>
<result><channel>Used (%)</channel><value>$PERC</value><unit>Percent</unit><LimitMode>1</LimitMode><LimitMaxWarning>90</LimitMaxWarning><LimitMaxError>95</LimitMaxError></result>"
echo "<text>Volume: $VOL</text></prtg>"
exit