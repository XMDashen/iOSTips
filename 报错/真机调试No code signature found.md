Xcode 8.2.1 真机调试的时候经常安装失败，弹出 App Installation failed, No code signature found. 的报错。

解决
1
$ open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk
将该目录下的 SDKSettings.plist 文件，将CODE_SIGNING_REQUIRED的值，从NO改为YES，再重启 Xcode 即可。

补充
用编辑器例如 Sublime 直接打开是乱码，无法修改，只能通过 Xcode（默认）打开，但是直接在原路径下的原文件修改是无法保存的，会提示没有写的权限。即使在 Xcode.app 的显示简介下面给当前用户读与写的权限，还是一样无法保存。

解决办法

拷贝一份 SDKSettings.plist 到其它目录下，如桌面，进行修改，然后保存，再拖进原路径进行替换，这时只需要“鉴定”输入用户密码即可。