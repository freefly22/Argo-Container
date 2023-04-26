FROM node:latest
EXPOSE 3000
WORKDIR /app
COPY files/* /app/

# 创建一个 UID 为 1001，GID 为 1001 的非 root 用户
RUN groupadd -g 1001 myuser && \
    useradd -u 1001 -g 1001 -m -s /bin/bash myuser

# 设置工作目录并切换到非 root 用户
WORKDIR /app
USER myuser

# 将应用程序文件复制到容器中
COPY app .

# 设置容器启动时要运行的命令
CMD ["./app"]

在这个示例中，我们从一个名为 "someimage:latest" 的基础镜像开始。然后，我们使用 `RUN` 命令创建一个 UID 为 1001，GID 为 1001 的非 root 用户。我们还将用户的主目录设置为 `/home/myuser`，默认 shell 设置为 `/bin/bash`。

接下来，我们使用 `WORKDIR` 命令将工作目录设置为 `/app`。最后，我们使用 `USER` 命令切换到之前创建的 `myuser` 用户。

从此之后，在 Dockerfile 中运行的任何命令（如 `COPY` 或 `CMD`）都将以 `myuser` 用户身份执行，而不是以 root 用户身份执行。这可以通过减少容器的攻击面来提高安全性。

RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb &&\
    dpkg -i cloudflared.deb &&\
    rm -f cloudflared.deb &&\
    chmod +x web.js

ENTRYPOINT [ "node", "server.js" ]
