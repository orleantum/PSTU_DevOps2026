# Weather_script.pdf - отчёт
# Weather_script.sh - скрипт

# Отчёт о работе

## 1. Устанавливаем веб-сервер

```Bash
sudo apt update sudo apt install nginx
```


## 2. Проверяем, что сервер заработал

```Bash
curl 127.0.0.1
```


## 3. Делаем проброс порта с хостовой системы в гостевую (8080 > 80)


## 4. Проверяем

```Bash
iadiyanov@iadiyanov:~$ curl 127.0.0.1
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```


## 5. Изменяем права на файл /var/www/html/index.nginx-debian.html

```Bash
iadiyanov@iadiyanov:~$ sudo chmod a+w /var/www/html/index.nginx-debian.html 
iadiyanov@iadiyanov:~$ ls -l /var/www/html/
total 4
-rw-rw-rw- 1 root root 615 May 23 10:52 index.nginx-debian.html
```


## 6. Пишем скрипт

```Bash
nano Weather_script.sh

#!/bin/bash

FILE="/var/www/html/index.nginx-debian.html"

curl -s wttr.in/Perm?format=j1 | jq '.["current_condition"][0] | .temp_C,.humidity' > $FILE

date >> $FILE
```


## 7. Добавляем в планировщик

```Bash
crontab -e

* * * * * /home/iadiyanov/Weather_script.sh
```
