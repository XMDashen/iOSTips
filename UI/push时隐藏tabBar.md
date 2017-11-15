-(BOOL)hidesBottomBarWhenPushed{
    if (self.navigationController.viewControllers.count>1) {
        self.tabBarController.tabBar.hidden=YES;
        return YES;
    }
    return NO;
}