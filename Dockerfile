FROM python:3.9-slim

WORKDIR /home/user1/app
COPY ./app/requirements.txt /home/user1/app/requirements.txt

# 環境変数の定義
ENV TZ=Asia/Tokyo
ENV USER user1
ENV PYTHONUNBUFFERED 1

# パッケージのインストールおよびユーザの追加
RUN apt-get update && apt-get install -y \
    tzdata sudo vim \
 && rm -rf /var/lib/apt/lists/* \
 && python -m pip install --upgrade pip \
 && pip install -r requirements.txt \
 && useradd -s /bin/bash -m ${USER} --uid 1000 \
 && gpasswd -a ${USER} sudo \
 && echo "${USER}:password" | chpasswd

# ユーザーの切替
USER ${USER}

# ソースファイルをコピー
COPY --chown=user1:user1 ./app/ /home/user1/app/

# djangoを起動
EXPOSE 8000
CMD python3 manage.py runserver 0.0.0.0:8000
