#!/bin/bash
# 基于 main.py 参数解析的训练执行脚本
# 使用方式：bash main.sh [seed] [batch_size] [lr] [epochs] [gpu_id]
# 示例1（使用默认值）：bash main.sh
# 示例2（自定义所有参数）：bash main.sh 42 32 3e-4 10 0

###########################################################################
# 1. 参数定义（未传入则读取 config.py 默认值）
###########################################################################
# 读取 config.py 中的默认值（若用户未传参则使用）
DEFAULT_SEED=$(python -c "import config; print(config.seed)")
DEFAULT_BATCH_SIZE=$(python -c "import config; print(config.batch_size)")
DEFAULT_LR=$(python -c "import config; print(config.lr)")
DEFAULT_EPOCHS=$(python -c "import config; print(config.epoch_num)")
DEFAULT_GPU_ID=$(python -c "import config; print(config.gpu_id)") 

# 命令行参数（未传入则使用默认值）
SEED=${1:-$DEFAULT_SEED}
BATCH_SIZE=${2:-$DEFAULT_BATCH_SIZE}
LR=${3:-$DEFAULT_LR}
EPOCHS=${4:-$DEFAULT_EPOCHS}

###########################################################################
# 2. 动态生成输出目录（避免重复实验）
###########################################################################
OUTPUT_DIR="output/seed${SEED}_bs${BATCH_SIZE}_lr${LR}_epochs${EPOCHS}"

###########################################################################
# 3. 执行前检查与准备
###########################################################################
# 检查训练脚本是否存在
if [ ! -f "main.py" ]; then
    echo "错误：训练脚本 main.py 不存在，请检查路径"
    exit 1
fi

# 检查是否已存在相同配置的实验结果
if [ -d "$OUTPUT_DIR" ]; then
    echo "警告：目录 ${OUTPUT_DIR} 已存在，跳过本次执行"
    exit 0
fi

# 创建输出目录
mkdir -p "$OUTPUT_DIR"
echo "输出目录创建成功：${OUTPUT_DIR}"

###########################################################################
# 4. 执行训练命令（设置GPU环境，传递参数）
###########################################################################
echo "开始训练：seed=${SEED} | batch_size=${BATCH_SIZE} | lr=${LR} | epochs=${EPOCHS}"

# 设置GPU环境变量，调用训练脚本并传递参数
export CUDA_VISIBLE_DEVICES=$GPU_ID
python main.py \
    --seed $SEED \
    --batch-size $BATCH_SIZE \
    --lr $LR \
    --epochs $EPOCHS \
    --output-dir $OUTPUT_DIR

###########################################################################
# 5. 训练状态提示
###########################################################################
if [ $? -eq 0 ]; then
    echo "训练成功！结果保存至：${OUTPUT_DIR}"
else
    echo "训练失败，请检查终端日志排查问题"
    rm -rf "$OUTPUT_DIR"  # 清理失败的空目录
fi