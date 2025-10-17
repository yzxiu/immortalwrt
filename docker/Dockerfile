# OpenWrt/ImmortalWrt 构建环境 Dockerfile
# 基于 Ubuntu 22.04 LTS，包含完整的构建工具链
# 解决 -lgcc: No such file or directory 链接错误

FROM ubuntu:22.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# 设置工作目录
WORKDIR /openwrt

# 更新包列表并安装构建依赖
# 参考 OpenWrt 官方文档和您的 GitHub Actions 工作流
RUN apt-get update && apt-get install -y \
    # 基础构建工具
    build-essential \
    clang \
    flex \
    bison \
    g++ \
    gawk \
    make \
    # 多架构支持 - 解决 -lgcc 错误的关键
    gcc-multilib \
    g++-multilib \
    libc6-dev \
    libc6-dev-i386 \
    lib32gcc-s1 \
    lib32stdc++6 \
    # 开发库
    gettext \
    git \
    libncurses5-dev \
    libssl-dev \
    libssl3 \
    # Python 工具
    python3 \
    python3-setuptools \
    python3-dev \
    python3-pip \
    # 其他必要工具
    rsync \
    swig \
    unzip \
    zlib1g-dev \
    file \
    wget \
    curl \
    # 网络工具
    ca-certificates \
    # 额外的构建依赖
    pkg-config \
    autoconf \
    automake \
    libtool \
    # Linux 内核编译依赖 - 解决 objtool libelf.so.1 错误
    libelf-dev \
    libelf1 \
    elfutils \
    libdw-dev \
    # 清理缓存
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 创建符号链接确保 gcc 库正确链接
RUN ln -sf /usr/lib/gcc/x86_64-linux-gnu/11/libgcc.a /usr/lib/libgcc.a || true && \
    ln -sf /usr/lib/gcc/x86_64-linux-gnu/11/libgcc_s.so /usr/lib/libgcc_s.so || true

# 创建非root用户用于构建（推荐）
RUN useradd -m -s /bin/bash openwrt && \
    usermod -aG sudo openwrt && \
    echo "openwrt ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# GitHub Actions 兼容性：创建与 GitHub Actions 兼容的用户
# GitHub Actions 通常使用 UID 1001 的用户
RUN useradd -m -s /bin/bash -u 1001 runner && \
    usermod -aG sudo runner && \
    echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 设置 GitHub Actions 兼容的用户
USER runner

# 显示工具版本信息
RUN echo "=== 构建环境信息 ===" && \
    gcc --version && \
    g++ --version && \
    make --version && \
    python3 --version && \
    echo "=== 库文件检查 ===" && \
    ls -la /usr/lib/libgcc* 2>/dev/null || echo "libgcc 库文件检查完成" && \
    echo "=== 环境设置完成 ==="

# 设置默认命令
CMD ["/bin/bash"]
