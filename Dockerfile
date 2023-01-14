FROM python:3.9-slim

# ファイルのコピー
WORKDIR /app
COPY ./app/requirements.txt /app/requirements.txt

# 環境変数の定義
ENV TZ=Asia/Tokyo
ENV USER user1
ENV PYTHONUNBUFFERED 1

# 起動用ファイルをコピーする
COPY init.sh /usr/local/bin/

# パッケージのインストールおよびユーザの追加
RUN apt-get update && apt-get install -y --no-install-recommends \
    tzdata sudo vim openssh-server build-essential cmake \
 && rm -rf /var/lib/apt/lists/* \
 && python -m pip install --upgrade pip \
 && pip install -r requirements.txt \
 && useradd -s /bin/bash -m ${USER} --uid 1000 \
 && gpasswd -a ${USER} sudo \
 && echo "${USER}:password" | chpasswd \
 && chmod u+x /usr/local/bin/init.sh \
 && echo 'root:Docker!' | chpasswd

# SSH用ファイルをコピーする
COPY sshd_config /etc/ssh/

# ソースファイルをコピー
COPY ./app /app

# ポート公開
EXPOSE 8000 2222

# django,ssh起動
ENTRYPOINT ["/usr/local/bin/init.sh"]
