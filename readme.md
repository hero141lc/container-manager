# 🐳 Docker 容器管理脚本

这是一个功能强大、交互友好的 Shell 脚本，帮助你管理本地所有 Docker 容器（包括运行中和已停止的），支持一键操作和多种管理功能。

---

## 🔧 脚本名称

```bash
container-manager.sh
```
## ✅ 支持功能

    查看所有容器（运行中与已停止）

    进入容器终端（bash/sh）

    启动容器

    停止容器

    重启容器

    删除容器

    查看容器日志（实时跟踪）

    查看容器资源使用（CPU、内存等）

    导出容器镜像为 .tar 文件

    查看容器详细配置信息（docker inspect）

## 🚀 使用方法
1. 赋予执行权限

`chmod +x container-manager.sh`

2. 运行脚本

`./container-manager.sh`

### 添加到bin直接运行
```
cp "$(pwd)/container-manager.sh" /usr/local/bin/container-manager
chmod +x /usr/local/bin/container-manager
container-manager
```

## 🧠 示例界面

```
容器列表（含运行中与已停止）：
-------------------------------------------------------------
序号: 0 | 状态: Up 3 hours | 名称: my-app | 镜像: nginx:latest
序号: 1 | 状态: Exited (0) | 名称: old-db | 镜像: mysql:5.7
-------------------------------------------------------------
请输入要操作的容器序号: 0
可选操作：
1) 进入终端
2) 停止容器
3) 启动容器
4) 重启容器
5) 删除容器
6) 查看日志
7) 查看资源使用 (docker stats)
8) 导出镜像为 tar 文件
9) 查看容器详细信息
```
### 📦 镜像导出说明

    第 8 项功能会将容器对应的镜像导出为 容器名_日期.tar 文件，保存在当前目录下。

## 📋 环境要求

    操作系统：Linux / macOS

    已安装 Docker 且当前用户具备 docker 执行权限

## 🛠 建议扩展功能

    快速新建容器（基于已有镜像）

    TUI 图形化终端（使用 dialog 或 fzf）

    容器配置备份与恢复

