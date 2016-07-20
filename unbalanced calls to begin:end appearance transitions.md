##unbalanced calls to begin/end appearance transitions for uiviewcontroller的解决办法

出现unbalanced calls to begin/end appearance transitions for uiviewcontroller这样的log，其原因就是在容器类的UIViewController（如，UINavigationController, UITabBarController）中动画没做完，然后又开始新的动画.。解决办法就是让动画完后再做新的动画。

