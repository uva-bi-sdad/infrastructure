#!/bin/bash
REMOTEHOST=sdad.policy-analytics.net
REMOTEPORT=3838
TIMEOUT=1

if nc -w $TIMEOUT -z $REMOTEHOST $REMOTEPORT; then
    echo "I was able to connect to ${REMOTEHOST}:${REMOTEPORT}"
else
    echo "Connection to ${REMOTEHOST}:${REMOTEPORT} failed. Exit code from Netcat was ($?)."
fi