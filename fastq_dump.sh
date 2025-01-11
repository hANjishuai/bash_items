#!/bin/bash
#传输SRR文件的父文件路径，循环进入每一个以SRR开头的文件夹，对sra文件进行bash命令行操作（默认为fastq-dump操作），输出在sra文件所在文件夹中
#蓟方涵；0.0.1；2025.01.11

# 检查是否传递了父文件夹路径
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <parent_directory> [command_to_run]"
    exit 1
fi

# 获取父文件夹路径
parent_dir="$1"

# 设置默认命令
default_command="fastq-dump --gzip -O $(pwd) --split-3 *.sra"

# 获取要执行的命令，如果没有提供则使用默认命令
command_to_run="${2:-$default_command}"

# 进入父文件夹
cd "$parent_dir" || exit

# 遍历父文件夹中的所有子文件夹
for dir in SRR*/; do
    # 进入子文件夹
    cd "$dir" || continue

    # 执行操作
    echo "Processing directory: $(pwd)"
    eval "$command_to_run"

    # 返回父文件夹
    cd ..
done
