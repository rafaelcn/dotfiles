#!/bin/bash

# Logitech index on pacmd (Pulse Audio)
INDEX=(`pacmd list-sinks | grep -Po "\b[1-9]?[1-9]?[1-9](?=\s\<(alsa_card.usb-Logitech_Logitech_USB_Headset-00>))\b"`)

clear

if [ -z $INDEX ]; then
    echo "Index not found."
    echo "Disconnect and connect the headset."
else    
    echo "The index of the Logitech headset is" $INDEX
    echo "Setting audio output..."
    pacmd set-default-sink $INDEX
fi

#echo "Trying to set an index - 1 (due to a known bug)"
#echo "(doing nothing for now, try to set manually if this doesn't work.)"
