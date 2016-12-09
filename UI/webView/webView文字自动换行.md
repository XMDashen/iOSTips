##webView文字自动换行

content为html内容

//自动换行
    NSString *contentAutoResize=[NSString stringWithFormat:@"<body width=%lfpx style=\"word-wrap:break-word; font-family:Arial\">%@",[UIScreen mainScreen].bounds.size.width,content];



