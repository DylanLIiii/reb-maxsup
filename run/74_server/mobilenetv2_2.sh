# Set variables
EXPERIMENT_NAME=$1
MODEL="mobilenet_v2"
LABLESMOOTHING=$2
MAXSUP=$3
DECOMPOSE=$4
LOGITPENALTY=$5

DATA_PATH="/datadrive/hengl/ILSVRC/Data/CLS-LOC/"
OUTPUT_DIR="/datadrive/hengl/rebuttals"
NUM_GPUS=4
mkdir -p "${OUTPUT_DIR}/${MODEL}/${EXPERIMENT_NAME}"
touch "${OUTPUT_DIR}/${MODEL}/${EXPERIMENT_NAME}/outputs.txt"

CUDA_VISIBLE_DEVICES=0,1,2,3 torchrun --standalone --nnodes=1 --nproc_per_node=4 /home/hengl/lbsm/rebuttals/train.py \
  --amp \
  --model ${MODEL} \
  --data-path "${DATA_PATH}" \
  --workers 12 \
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
  --logit-penalty ${LOGITPENALTY} \
  | tee "${OUTPUT_DIR}/${MODEL}/${EXPERIMENT_NAME}/outputs.txt"