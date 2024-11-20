# Set variables
EXPERIMENT_NAME=$1
MODEL=resnet18
EPOCHS=90
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
  --data-path "${DATA_PATH}" \
  --workers 16 \
  --batch-size 512 \
  --epochs ${EPOCHS} \
  --opt sgd \
  --momentum 0.9 \
  --lr 0.8 \
  --lr-step-size 30 \
  --lr-gamma 0.1 \
  --weight-decay 1e-4 \
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