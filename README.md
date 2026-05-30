# Файлы:
### Weather_script.pdf - отчёт о проделанной работе
### Weather_script.sh - скрипт

# Отчёт о работе

### 1. Устанавливаем веб-сервер

```Bash
sudo apt update
sudo apt install nginx
```


### 2. Делаем проброс порта с хостовой системы в гостевую (8080 > 80)
<img width="624" height="143" alt="image" src="https://github.com/user-attachments/assets/6386842a-f101-4900-a185-9a22e99c0193" />


### 3. Проверяем

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


### 4. Изменяем права на файл /var/www/html/index.nginx-debian.html

```Bash
iadiyanov@iadiyanov:~$ sudo chmod a+w /var/www/html/index.nginx-debian.html 
iadiyanov@iadiyanov:~$ ls -l /var/www/html/
total 4
-rw-rw-rw- 1 root root 615 May 23 10:52 index.nginx-debian.html
```


### 5. Пишем скрипт

```Bash
#!/bin/bash

FILE="/var/www/html/index.nginx-debian.html"

CITY="Perm"

read -r temp humidity <<< $(curl -s wttr.in/${CITY}?format=j1 | jq -r '.current_condition[0] | "\(.temp_C) \(.humidity)"')


{
    echo "<h1>Weather ${CITY}</h1>"
    echo "<p>Temperature: ${temp}<br>"
    echo "Humidity: ${humidity}<br>"
    echo "Date: $(date)</p>"
} > ${FILE}
```
<img width="624" height="211" alt="image" src="https://github.com/user-attachments/assets/4c238efc-394c-4602-aba7-aa2074f3c140" />



### 6. Добавляем в планировщик

```Bash
crontab -e

* * * * * /home/iadiyanov/Weather_script.sh
```

### 7. Смотрим index.html
```Bash
<h1>Weather Perm</h1>
<p>Temperature: 17<br>
Humidity: 50<br>
Date: Sat May 30 01:07:01 PM UTC 2026</p>
```

### 8. Проверяем вывод скрипта и срабатывает ли он каждую минуту
<img width="292" height="209" alt="image" src="https://github.com/user-attachments/assets/277b3471-c776-4708-97df-325be312deb6" />
<img width="290" height="210" alt="image" src="https://github.com/user-attachments/assets/d05a0d48-f6d1-4638-94c4-773c332cfc43" />

