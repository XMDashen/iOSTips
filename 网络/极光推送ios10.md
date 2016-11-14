参考:http://blog.csdn.net/cloud_pro/article/details/52574637


证书配置注意:开发证书和生产证书

导出P12文件时点击证书导出(不是点击展开钥匙导出)

推送证书关联的APPID,换证书不用换描述文件


获取极光用户注册id,关联自己服务器推送使用
[JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {

}];
