#!/system/bin/sh
# loggy.sh.
rm /cache/*.txt

_date=date +%F_%H-%M-%S
logcat -b all -v time -f  /cache/logcat_${_date}.txt &
logcat -b crash -D -f /cache/logcat_crash_${_date).txt &
dmesg -w > /cache/kmsg_${_date}.txt
