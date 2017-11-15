设置TextField内文字距左边框的距离

 //设置文本框左边的view
	 UITextField *textField = [[UITextField alloc]init];
	 textField.frame = CGRectMake(10, 30, 300, 30);
	 [self.view addSubview:textField];
	 textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
	 //设置显示模式为永远显示(默认不显示)
	 textField.leftViewMode = UITextFieldViewModeAlways;