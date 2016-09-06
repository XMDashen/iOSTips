##git 常用命令

git init 创建空仓库
git add .将文件变化告诉给git
git commit -am "message" 提交本次更改，并添加更改注释
git log 查看提交日志
git status 查看git状态
git branch 查看所有分支和当前分支
git branch branchname 创建新的分支
git checkout branchname 切换到指定的分支

Git rm 是rm file和git add这两个命令的结合

如果删除文件通过rm file，可以通过git checkout -- file找回；如果删除文件是通过git rm file执行的，那么需要执行两个命令git reset HEAD file和git checkout -- file


