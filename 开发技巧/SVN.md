svn checkout 第一次克隆项目到本地

svn add . 添加到本地仓库
svn commit -m "" 提交
svn update 更新项目到本地

out of date当本地版本号小于服务器的版本号时不能提交代码(别人提交后，我没更新再提交就不能提交了)
提交前先update一下看有没有冲突,在提交

同时修改同一个文件的同一行代码，更新到本地时就会产生冲突

(p)postpone
(mc)mine-conflict 使用我的代码，覆盖服务器的代码
(tc)their-conflict 使用服务器的代码，覆盖我的代码

svn resolved ''  文件冲突解决

svn help 查看所有命令



svn log 查看所有版本

svn update -r 9   回退到某个版本到本地


创建项目时忽略不需要的文件
