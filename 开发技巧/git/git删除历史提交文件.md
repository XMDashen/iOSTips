##git删除历史提交文件

删除提交记录中所有的同名文件或目录

git rm --cached --ignore-unmatch 文件名称

git rm -r --cached --ignore-unmatch 目录名称

最后在.gitignore中添加该文件,即可忽略以后提交该文件了


