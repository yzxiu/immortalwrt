# 构建新版本镜像（修复 libelf 依赖问题）
docker build -t q946666800/openwrt-build:v23.05_3 .
docker push q946666800/openwrt-build:v23.05_3