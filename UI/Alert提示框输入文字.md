##Alert提示框输入文字

```

	//实例化AlertController控制器
 	UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"请输入要分享的标题和内容" 	preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //标题输入框
        UITextField *titleTextField=alert.textFields.firstObject;
        
        //内容输入框
        UITextField *contentTextField=alert.textFields.lastObject;
}

	//添加动作
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
    
    //********添加输入框***********
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder=@"请输入分享的标题";
    }];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"请输入分享的内容";
    }];
    
    //弹出提示框
    [self presentViewController:alert animated:YES completion:nil];

```

