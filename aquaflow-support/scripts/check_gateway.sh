#!/bin/bash

if ss -lnt | grep -q ":9094"; then
    echo "PASS: AquaFlow TCP Gateway is available on 127.0.0.1:9094"
    exit 0
else
    echo "FAIL: AquaFlow TCP Gateway is unavailable on 127.0.0.1:9094"
    exit 1
fi
