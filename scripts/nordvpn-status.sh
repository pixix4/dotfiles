#!/bin/sh

STATUS=$(nordvpn status | grep Status | tr -d ' ' | cut -d ':' -f2)

if [ "$STATUS" = "Connected" ]; then
    echo ""
    #nordvpn status | grep IP | tr -d ' ' | cut -d ':' -f2
else
    echo ""
    exit 1
fi
