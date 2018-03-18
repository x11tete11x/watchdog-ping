#!/bin/bash
##########CONFIG############
IP="<IP>"
USER="<BD USER>"
PASSW="<PASS BD USER>"
DATABASE="<DATABASE NAME>"
TRIES=4
############################
PING=$(ping -qc $TRIES $IP)
I1=$(echo -e "$PING" | grep packet)
TX=$(echo -e "$I1" | awk '{ print $1 }')
RX=$(echo -e "$I1" | awk '{ print $4 }')
PERCENT_LOST=$(echo -e "$I1" | awk '{ print $6 }' | tr -d '%')
I2=$(echo -e "$PING" | grep rtt)
I2aux=$(echo -e "$I2" | cut -f 2 -d '=' | tr -d ' ' | tr -d 'ms')
MIN=$(echo -e "$I2aux" | awk 'BEGIN { FS = "/" } ; { print $1 }')
AVG=$(echo -e "$I2aux" | awk 'BEGIN { FS = "/" } ; { print $2 }')
MAX=$(echo -e "$I2aux" | awk 'BEGIN { FS = "/" } ; { print $3 }')
MDEV=$(echo -e "$I2aux" | awk 'BEGIN { FS = "/" } ; { print $4 }')
if [ "$PERCENT_LOST" == "100" ]
then
mysql -u $USER -p$PASSW -D $DATABASE -e "insert INTO ping(status,tx,rx,percent_lost,min,avg,max,mdev) values(\"FAIL\",\"$TX\",\"$RX\",\"$PERCENT_LOST\",\"$MIN\",\"$AVG\",\"$MAX\",\"$MDEV\");"
##### Mail notify ################### 
#<In my script i use mailgun to send me an email, Replace this line with your method to send email>
#####################################
else
mysql -u $USER -p$PASSW -D $DATABASE -e "insert INTO ping(status,tx,rx,percent_lost,min,avg,max,mdev) values(\"OK\",\"$TX\",\"$RX\",\"$PERCENT_LOST\",\"$MIN\",\"$AVG\",\"$MAX\",\"$MDEV\");"
fi
