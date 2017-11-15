防止按钮多次点击

- - (void)buttonClicked:(id)sender
{
   //这里是关键，点击按钮后先取消之前的操作，再进行需要进行的操作
   [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(buttonClicked:) object:sender];
   [self performSelector:@selector(buttonClicked: )withObject:sender afterDelay:0.2f];
}