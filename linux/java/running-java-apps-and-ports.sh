echo -e "\n\n  Information about running java processes on this host\n\n"
for pid in `jps | awk ' { print $1 } '`; do
    echo "pid: $pid started from `ls -l /proc/$pid/cwd | awk ' { print $11 } '`";
    echo -e " ports:\n` netstat -tlpn  1> /dev/stdout 2> /dev/null | grep $pid | awk ' { print "   " $4; } ' | sed 's/0.0.0.0://' | sort -n`"
done
