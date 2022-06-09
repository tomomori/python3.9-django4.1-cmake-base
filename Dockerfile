FROM python:3.9-slim

WORKDIR /home/user1/app
COPY ./app/requirements.txt /home/user1/app/requirements.txt

# 環境変数の定義
ENV TZ=Asia/Tokyo
ENV USER user1
ENV PYTHONUNBUFFERED 1

# SSH用ファイルをコピーする
COPY sshd_config /etc/ssh/
COPY init.sh /usr/local/bin/

# パッケージのインストールおよびユーザの追加
RUN apt-get update && apt-get install -y --no-install-recommends \
    tzdata sudo vim openssh-server \
 && rm -rf /var/lib/apt/lists/* \
 && python -m pip install --upgrade pip \
 && pip install -r requirements.txt \
 && useradd -s /bin/bash -m ${USER} --uid 1000 \
 && gpasswd -a ${USER} sudo \
 && echo "${USER}:password" | chpasswd \
 && chmod u+x /usr/local/bin/init.sh \
 && echo 'root:Docker!' | chpasswd

# ソースファイルをコピー
COPY --chown=user1:user1 ./app/ /home/user1/app/

# django,ssh起動
EXPOSE 8000 2222
ENTRYPOINT ["/usr/local/bin/init.sh"]

