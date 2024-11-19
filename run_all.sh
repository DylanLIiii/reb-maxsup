#!/bin/bash

# Check if experiment name is provided
if [ $# -lt 4 ]; then
    echo "Usage: $0 <experiment_name> <label_smoothing> <max_sup> <decompose>"
    exit 1
fi

EXPERIMENT_NAME=$1
LABEL_SMOOTHING=$2
MAX_SUP=$3
DECOMPOSE=$4

# label smoothing 0.1 另外两个是 0 就是 只有 label smoothing (ls)
# label smoothing 和另外两个都是 0.0 0 0 就是没有 label smoothing (no ls)
# label smoothing 0.0 MAX_SUP 1 Decompose 0 (maxsup)

# Run each model script
for script in mobilenetv2.sh resnet18.sh resnet101.sh; do
    if [ -f "$script" ]; then
        echo "Running $script..."
        bash "$script" "$EXPERIMENT_NAME" "$LABEL_SMOOTHING" "$MAX_SUP" "$DECOMPOSE"
        echo "Finished $script"
        echo "-----------------------------------"
    fi
done

echo "All scripts completed!"