#!/bin/bash

set -e

# Check if fio is installed; install if not
if ! command -v fio &> /dev/null; then
    echo "fio not found. Installing..."
    sudo apt update
    sudo apt install -y fio
else
    echo "fio is already installed."
fi

# Directory to test in (change if needed)
TEST_DIR="/home/jovyan"

cd "$TEST_DIR"

# Run fio write throughput test
fio --name=write_throughput \
    --directory=. \
    --numjobs=1 \
    --size=100G \
    --time_based \
    --runtime=30m \
    --ramp_time=2s \
    --ioengine=libaio \
    --direct=1 \
    --verify=crc32c \
    --bs=1M \
    --iodepth=1 \
    --rw=readwrite \
    --group_reporting=1 \
    --continue_on_error=none

