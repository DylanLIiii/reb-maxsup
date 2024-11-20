# Set variables
EXPERIMENT_NAME=$1
MODEL="mobilenet_v2"
LABLESMOOTHING=$2
MAXSUP=$3
DECOMPOSE=$4

DATA_PATH="/home/couser/imagenet/data"
OUTPUT_DIR="/home/couser/rebuttals"

NUM_GPUS=4
mkdir -p "${OUTPUT_DIR}/${MODEL}/${EXPERIMENT_NAME}"
touch "${OUTPUT_DIR}/${MODEL}/${EXPERIMENT_NAME}/outputs.txt"

CUDA_VISIBLE_DEVICES=4,5,6,7 torchrun --standalone --nnodes=1 --nproc_per_node=4 /home/couser/rebuttals/train.py \
  --model ${MODEL} \
  --amp \
  --data-path "${DATA_PATH}" \
  --workers 16 \
  --batch-size 512 \
  --epochs 300 \
  --opt sgd \
  --momentum 0.9 \
  --lr 0.36 \
  --lr-step-size 1 \
  --lr-gamma 0.98 \
  --wd 0.00004 \
  --interpolation bilinear \
  --val-resize-size 256 \
  --val-crop-size 224 \
  --train-crop-size 224 \
  --print-freq 100 \
  --output-dir "${OUTPUT_DIR}/${MODEL}/${EXPERIMENT_NAME}" \
  --label-smoothing ${LABLESMOOTHING} \
  --decompose ${DECOMPOSE} \
  --max-sup ${MAXSUP} \
  | tee "${OUTPUT_DIR}/${MODEL}/${EXPERIMENT_NAME}/outputs.txt"