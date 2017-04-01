###wordpress 搭建

云主机环境：centos 7.2
php,apache 2,mysql,phpmyadmin


#####下载wordpress 上传到服务器根目录（访问根目录）
wordpress内所有内容拷贝到根目录下
有域名：eg: /var/www/域名/

无域名 上传到apache服务器根目录下
eg: /apache2/htdocs/

#####配置数据库
找到：phpmyadmin 软连接到根目录下

cd到根目录下
cd /apache2/htdocs/
执行：
sudo ln -s /usr/share/phpmyadmin

浏览器访问http://127.0.0.1/phpmyadmin
建立wordpress数据库，配置好用户名密码

#####配置wordpress
访问http://ip/wp-admin/install.php

按提示配置好数据库用户名密码
若提示不成功则手动复制内容生成wp-config.php文件拷贝到根目录下（原来为wp-config-sample.php），用此配置来安装wordpress即可



