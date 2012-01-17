#!/bin/bash

SIM_PID=`ps x | grep "iPhone Simulator " | grep -v grep | awk '{print $1}'`
if [ "$SIM_PID" == "" ]; then
	echo "iPhone Simulator.app must be running to turn on slowmo."
	exit 1;
fi

dev_dir=`xcode-select -print-path`
GDB="$dev_dir"/Platforms/iPhoneSimulator.platform/Developer/usr/bin/gdb

cat <<EOM | "$GDB" -quiet > /dev/null
attach $SIM_PID
p (void *)dlopen("$(cd "$(dirname "$0")"; pwd)/_slowmo", 2)
detach
EOM

echo "Press shift three times in the iPhone Simulator to toggle slowmo on and off."
