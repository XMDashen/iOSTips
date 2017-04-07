phpMyAdmin 修改远程登录访问权限

phpMyAdmin conf文件夹里 httpd-app.conf配置文件

AllowOverride None
Order allow,deny
#Allow from 127.0.0.1（限定只能从特定ip访问）
Allow from all