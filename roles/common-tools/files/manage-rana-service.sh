#!/bin/bash

# This script is intended to be run by a udev rule when the power
# state of the system changes. It checks if the system is on AC power
# and starts or stops the rana.service accordingly.

# The path to the file indicating AC power status can vary between systems.
# Common paths include:
# /sys/class/power_supply/AC/online
# /sys/class/power_supply/ACAD/online
# /sys/class/power_supply/ADP1/online
#
# This script will attempt to find the correct file.

# Function to find the AC power file
find_ac_power_file() {
    for dir in /sys/class/power_supply/*; do
        if [ -f "$dir/online" ] && [[ "$dir" == *AC* || "$dir" == *ADP* ]]; then
            echo "$dir/online"
            return
        fi
    done
}

AC_POWER_FILE=$(find_ac_power_file)

if [ -n "$AC_POWER_FILE" ] && [ -f "$AC_POWER_FILE" ]; then
    POWER_STATUS=$(cat "$AC_POWER_FILE")

    if [ "$POWER_STATUS" -eq 1 ]; then
        # AC power is connected, start the service
        /usr/bin/systemctl start rana.service
    else
        # AC power is disconnected, stop the service
        /usr/bin/systemctl stop rana.service
    fi
fi
