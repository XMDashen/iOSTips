 iOS真机调试程序，报如下错误信息：
failed to get the task for process XXX
 
原因：
证书问题，project和targets的证书都必须是开发证书，ADHOC的证书会出现此问题。
 
解决方案：
    project和targets的证书使用开发证书。