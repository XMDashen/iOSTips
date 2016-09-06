##segue跳转


在storyBoard里拖线，从本控制器拖到下一个控制器的view，并注明segue的identifier

在需要跳转时执行：
```
[self performSegueWithIdentifier:@"iden" sender:nil];
```