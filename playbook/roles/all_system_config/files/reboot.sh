#!/usr/bin/env bash

if command -v ansible > /dev/null 2>&1;then
    echo "Temporarily don't restart the current host"
else
    shutdown -r now
fi
