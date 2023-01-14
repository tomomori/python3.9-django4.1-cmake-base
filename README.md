# python3.9-django4.1-cmake-base

* これはDjangoアプリ用のDockerコンテナを作成するためのひな型
* 以下はWindowsでコンテナを起動し、Djangoアプリを表示するための説明
* 前提
	* Windows10にDocker Desktopがインストール済みであること

<br>

---
1. docker-compose.ymlをテキストエディタで開き下記の値を適宜変更する
    ~~~
        container_name: 'python3.9-django4.1-cmake-base'
        ports:
          - 8000:8000
    ~~~
    * container_nameは既存コンテナ名と重複しないこと
	* portsは下記形式で、使用中ポートと重複しないようホスト側のポートを変更する
		⇒「ホスト側のポート:コンテナ内のポート」
	* 以下2.以降はこれらを未変更として説明する   

<br>

2. DOS窓を起動する。

3. docker-compose.ymlがあるフォルダ(このファイルがあるフォルダと同じ)に移動する
    ~~~
	    cd c:\docker_django_base
    ~~~

4. コンテナを起動する
    ~~~
    	docker-compose up -d
    ~~~

5. ブラウザを起動して下記アドレスにアクセスすると「インストールは成功しました！おめでとうございます！」が表示される
    ~~~
    	 http://127.0.0.1:8000/ 
    ~~~

6. コンテナに接続してbashを起動する場合は下記コマンドを使用する
    ~~~
    	docker-compose exec app /bin/bash
    ~~~

* createsuperuserおよびmigrateは未実施状態となっている
* このファイルと同じフォルダにあるappフォルダがコンテナの/appに接続されている
---

<br>

ここからはメモ

* プロジェクトを作成する
    ~~~
    	django-admin startproject myproj
    ~~~
	
* アプリを作成する
    ~~~
	    cd myproj
	    python manage.py startapp myapp
    ~~~

* スーパーユーザを作成する
    ~~~
	    python manage.py createsuperuser
    ~~~

* スーパーユーザーのパスワード変更の変更
    ~~~
    	python manage.py changepassword [ユーザ名]
    ~~~
	
* マイグレート
    ~~~
    	python manage.py migrate
    ~~~

