
# Restarts interfaces if they are down
# You might want to run this from cron like this:
# 31 * * * * /home/pi/bin/restartif wlan0 >> /somewhere/restartif.log 2>&1
#

if [ -z $1 ]; then 
    echo "Specify interface"
    exit 911
fi

IF=$1

echo $IF

date=`/bin/date`
ifconfig=`/sbin/ifconfig $IF 2>&1`

notconfig=`/bin/echo ${ifconfig} | grep "Device not found" -c`

if [ "${notconfig}" -eq "1" ] ; then
   /bin/echo "${date}: ${IF} is not configured, doing nothing"
   exit 0
fi

isup=`/bin/echo ${ifconfig} | grep "inet addr" -c`

if [ "$isup" -eq "1" ] ; then
   /bin/echo "${date}: ${IF} is up, doing nothing" 
else
   sudo /sbin/ifdown $IF
   sleep 10
   sudo /sbin/ifup $IF
   /bin/echo "$date attempted bringing up $IF"
fi
