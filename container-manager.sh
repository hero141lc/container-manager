#!/bin/bash

green='\033[0;32m'
yellow='\033[1;33m'
red='\033[0;31m'
blue='\033[1;34m'
nc='\033[0m'

# 获取所有容器 ID
all_ids=($(docker ps -a -q))
if [ ${#all_ids[@]} -eq 0 ]; then
  echo -e "${red}当前没有任何容器。${nc}"
  exit 0
fi

echo -e "${green}容器列表（含运行中与已停止）：${nc}"
echo "-------------------------------------------------------------"

declare -A id_map
index=0
for id in "${all_ids[@]}"; do
  info=$(docker ps -a --filter "id=$id" --format "序号: $index | 状态: {{.Status}} | 名称: {{.Names}} | 镜像: {{.Image}}")
  id_map[$index]=$id
  echo "$info"
  ((index++))
done
echo "-------------------------------------------------------------"

read -p "请输入要操作的容器序号: " selection

selected_id=${id_map[$selection]}
if [ -z "$selected_id" ]; then
  echo -e "${red}无效的序号。${nc}"
  exit 1
fi

name=$(docker inspect --format '{{.Name}}' "$selected_id" | cut -c2-)
image=$(docker inspect --format '{{.Config.Image}}' "$selected_id")

echo -e "${yellow}选中容器: $name ($selected_id)${nc}"
echo "可选操作："
echo "1) 进入终端"
echo "2) 停止容器"
echo "3) 启动容器"
echo "4) 重启容器"
echo "5) 删除容器"
echo "6) 查看日志"
echo "7) 查看资源使用 (docker stats)"
echo "8) 导出镜像为 tar 文件"
echo "9) 查看容器详细信息"
read -p "请输入操作编号 (1-9): " op

case "$op" in
  1)
    echo "进入容器终端..."
    docker exec -it "$selected_id" /bin/bash 2>/dev/null || docker exec -it "$selected_id" /bin/sh
    ;;
  2)
    echo "停止容器..."
    docker stop "$selected_id"
    ;;
  3)
    echo "启动容器..."
    docker start "$selected_id"
    ;;
  4)
    echo "重启容器..."
    docker restart "$selected_id"
    ;;
  5)
    read -p "确认要删除容器 $name？(y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      docker rm -f "$selected_id"
      echo -e "${green}容器已删除。${nc}"
    else
      echo -e "${yellow}已取消。${nc}"
    fi
    ;;
  6)
    echo "显示日志 (按 Ctrl+C 退出)..."
    docker logs -f "$selected_id"
    ;;
  7)
    echo "容器资源使用情况："
    docker stats --no-stream "$selected_id"
    ;;
  8)
    filename="${name}_$(date +%Y%m%d_%H%M%S).tar"
    echo "正在导出镜像 $image 到 $filename ..."
    docker save "$image" -o "$filename"
    echo -e "${green}镜像已导出为 $filename${nc}"
    ;;
  9)
    echo "容器详细信息："
    docker inspect "$selected_id"
    ;;
  *)
    echo -e "${red}无效选项。${nc}"
    ;;
esac
