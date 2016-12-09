console.log('run success wxm')

require('UIAlertController')
require('UIAlertControllerStyle')
require('UIAlertView')

defineClass("XMHomeViewController", {
    shutDownAppIfNeeded: function() {
    	var av = UIAlertView.alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("警告", "如果看到此窗口,请马上联系开发者,您现在正在使用盗版软件!!!", null, "取消", "确定", null);
            av.show();
        var alertVc = UIAlertController.alertControllerWithTitle_message_preferredStyle("警告", "非法使用", 1);
        self.presentViewController_animated_completion(alertVc, YES, null);
        console.log('=======================run success =========================');
    }
}, {})
