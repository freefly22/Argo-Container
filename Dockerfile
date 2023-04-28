FROM node:latest
EXPOSE 3000
WORKDIR /app
COPY files/* /app/

RUN echo 'root:10086' | chpasswd
RUN useradd -m cmcc -u 10086  && echo 'cmcc:10086' | chpasswd  && usermod -aG sudo cmcc
USER 10086

RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb &&\
    dpkg -i cloudflared.deb &&\
    rm -f cloudflared.deb &&\
    chmod +x web.js

ENTRYPOINT [ "node", "server.js" ]
