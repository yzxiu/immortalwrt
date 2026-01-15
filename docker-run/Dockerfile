FROM scratch

# 添加 OpenWrt rootfs
ADD immortalwrt-x86-64-generic-rootfs.tar.gz /

# 替换网络配置文件
COPY network /etc/config/network

# 设置工作目录
WORKDIR /

# 暴露常用端口
# 80: HTTP (LuCI Web界面)
# 443: HTTPS
# 22: SSH
# 53: DNS
EXPOSE 80 443 22 53

# 设置启动命令
CMD ["/sbin/init"]

# 构建镜像命令:
# docker build -t immortalwrt-2305 .


# 运行容器命令（需要特权模式）:
# docker run --restart always --name openwrt -d --privileged --network macnet immortalwrt-2305 /sbin/init
#
# 或者使用 start.sh 脚本运行（开发测试模式）:
# ./start.sh