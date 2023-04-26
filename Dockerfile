FROM node:latest
EXPOSE 3000
WORKDIR /app
COPY files/* /app/

# 创建一个 UID 为 1001，GID 为 1001 的非 root 用户
RUN groupadd -g 10014 myuser && \
    useradd -u 10014 -g 10014 -m -s /bin/bash myuser

# 设置工作目录并切换到非 root 用户
WORKDIR /app
USER myuser

# 将应用程序文件复制到容器中
COPY app .

# 设置容器启动时要运行的命令
CMD ["./app"]

RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb &&\
    dpkg -i cloudflared.deb &&\
    rm -f cloudflared.deb &&\
    chmod +x web.js

ENTRYPOINT [ "node", "server.js" ]
