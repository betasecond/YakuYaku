#!/bin/bash

# 将当前目录添加到PYTHONPATH，以便Python可以找到src包
export PYTHONPATH="$PWD:$PYTHONPATH"

# 设定模型名称
export MODEL_NAME=LNTW_ja2zh
# 设定模型的文件夹路径
export MODEL_DIR=./models
# 设定输入文本的名称
export INPUT_TEXT_NAME="1and2.txt"
# 设定输入文本的文件夹路径
export INPUT_TEXT_DIR="./"
# 设定输出文本的名称
export OUTPUT_TEXT_NAME="1and2.txt"
# 设定输出文本的文件夹路径
export OUTPUT_TEXT_DIR="./output"
# 设定使用的设备，这里是用于CUDA的GPU
export DEVICE=cuda
# 是否需要将繁体转为简体，如果需要则设置为"--convert_t2s"
export CONVERT_T2S="--convert_t2s"

# 安装opencc
pip install opencc
# 执行 cli.py
python src/cli.py \
    --model-name=$MODEL_NAME \
    --model-dir=$MODEL_DIR \
    --input-text-name="$INPUT_TEXT_NAME" \
    --input-text-dir="$INPUT_TEXT_DIR" \
    --output-text-name="$OUTPUT_TEXT_NAME" \
    --output-text-dir="$OUTPUT_TEXT_DIR" \
    --device=$DEVICE

# 使用 src/cleaner.py 处理输出文件
python src/cleaner.py "$OUTPUT_TEXT_DIR/$OUTPUT_TEXT_NAME" "$OUTPUT_TEXT_DIR/cleaned_$OUTPUT_TEXT_NAME" $CONVERT_T2S
