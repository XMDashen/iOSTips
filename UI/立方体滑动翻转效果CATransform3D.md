##立方体翻转效果


#####透视效果函数，实现远小近大效果
```
CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}
```
#####滑动时各个View作3D变幻(当前页面，左侧页面，右侧页面同时作3D变幻)
```
#pragma mark - scrollView滑动事件
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //当前页数
    NSInteger currentPage=_segment.selectedIndex;
    
    //当前视图控制器视图
    UIView *currentView=_viewArray[currentPage];
    
    //上一个视图控制器视图
    UIView *lastView=nil;
    
    if (currentPage-1>=0) {
        
        lastView=_viewArray[currentPage-1];
    }
    
    //下一个视图控制器视图
    UIView *nextView;
    
    if (currentPage+1<=3) {
        
        nextView=_viewArray[currentPage+1];
    }
    
    //本次偏移距离
    CGFloat currentOffset=scrollView.contentOffset.x-currentPage*self.view.bounds.size.width;
    
    //本次偏移角度
    CGFloat deltaAngle=currentOffset/self.view.bounds.size.width * M_PI_2;
    
        //****************当前视图移动变幻***************
        
        //设置锚点
        currentView.layer.anchorPoint=CGPointMake(0.5, 0.5);
    
        //向屏幕前方移动
        CATransform3D move = CATransform3DMakeTranslation(0, 0, self.view.bounds.size.width/2);
    
        //旋转
        CATransform3D rotate = CATransform3DMakeRotation(-deltaAngle, 0, 1, 0);
    
        //平移
        CATransform3D plaintMove=CATransform3DMakeTranslation( currentOffset, 0, 0);
    
        //向屏幕后方移动
        CATransform3D back = CATransform3DMakeTranslation(0, 0, -self.view.bounds.size.width/2);
    
        //连接
        CATransform3D concat=CATransform3DConcat( CATransform3DConcat(move, CATransform3DConcat(rotate, plaintMove)),back);
    
        CATransform3D transform=CATransform3DPerspect(concat, CGPointMake(currentOffset/2, self.view.bounds.size.height), 5000.0f);
    
        //添加变幻特效
        currentView.layer.transform=transform;
    
    //****************下一个视图移动变幻***************
    
    //设置锚点
    nextView.layer.anchorPoint=CGPointMake(0.5, 0.5);
    
    //向屏幕前方移动
    CATransform3D move2 = CATransform3DMakeTranslation(0, 0, self.view.bounds.size.width/2);
    
    //旋转
    CATransform3D rotate2 = CATransform3DMakeRotation(-deltaAngle+M_PI_2, 0, 1, 0);
    
    //平移
    CATransform3D plaintMove2=CATransform3DMakeTranslation( currentOffset-self.view.bounds.size.width, 0, 0);
    
    //向屏幕后方移动
    CATransform3D back2 = CATransform3DMakeTranslation(0, 0, -self.view.bounds.size.width/2);
    
    //拼接
    CATransform3D concat2=CATransform3DConcat( CATransform3DConcat(move2, CATransform3DConcat(rotate2, plaintMove2)),back2);
    
    CATransform3D transform2=CATransform3DPerspect(concat2, CGPointMake(self.view.bounds.size.width/2+currentOffset/2, self.view.bounds.size.height), 5000.0f);
    
    //添加变幻特效
    nextView.layer.transform=transform2;
    
    //****************上一个视图移动变幻***************
    
    //设置锚点
    lastView.layer.anchorPoint=CGPointMake(0.5, 0.5);
    
    //向屏幕前方移动
    CATransform3D move3 = CATransform3DMakeTranslation(0, 0, self.view.bounds.size.width/2);
    
    //旋转
    CATransform3D rotate3 = CATransform3DMakeRotation(-deltaAngle-M_PI_2, 0, 1, 0);
    
    //平移
    CATransform3D plaintMove3=CATransform3DMakeTranslation( currentOffset+self.view.bounds.size.width, 0, 0);
    
    //向屏幕后方移动
    CATransform3D back3 = CATransform3DMakeTranslation(0, 0, -self.view.bounds.size.width/2);
    
    //拼接
    CATransform3D concat3=CATransform3DConcat(CATransform3DConcat(move3, CATransform3DConcat(rotate3, plaintMove3)),back3);
    
    CATransform3D transform3=CATransform3DPerspect(concat3, CGPointMake(-self.view.bounds.size.width/2+currentOffset/2, self.view.bounds.size.height), 5000.0f);
    
    //添加变幻特效
    lastView.layer.transform=transform3;
}
```







#####其它资料
CATransform3D可以使用CATransform3DConcat函数连接起来以构造更复杂的变换, 通过这些方法，可以组合出更多的效果来。下面是个翻转的动画, 使用四张同样大小的图片围成一个框，让这个框动画旋转, 形成一个立方体旋转的效果。



IOS 3D翻转 笔记（转） - it__man - 扫地僧的博客
 

相关实现的代码：

CATransform3D move = CATransform3DMakeTranslation(0, 0, 160);

CATransform3D back = CATransform3DMakeTranslation(0, 0, -160);

CATransform3D rotate0 = CATransform3DMakeRotation(-angle, 0, 1, 0);

CATransform3D rotate1 = CATransform3DMakeRotation(M_PI_2-angle, 0, 1, 0);

CATransform3D rotate2 = CATransform3DMakeRotation(M_PI_2*2-angle, 0, 1, 0);

CATransform3D rotate3 = CATransform3DMakeRotation(M_PI_2*3-angle, 0, 1, 0);

CATransform3D mat0 = CATransform3DConcat(CATransform3DConcat(move, rotate0), back);

CATransform3D mat1 = CATransform3DConcat(CATransform3DConcat(move, rotate1), back);

CATransform3D mat2 = CATransform3DConcat(CATransform3DConcat(move, rotate2), back);

CATransform3D mat3 = CATransform3DConcat(CATransform3DConcat(move, rotate3), back);

image0.layer.transform = CATransform3DPerspect(mat0, CGPointZero, 500);

image1.layer.transform = CATransform3DPerspect(mat1, CGPointZero, 500);

image2.layer.transform = CATransform3DPerspect(mat2, CGPointZero, 500);

image3.layer.transform = CATransform3DPerspect(mat3, CGPointZero, 500);

解析：

要形成一个立方体旋转的效果，首先需要构造出一个立方体出来，怎么构造呢？在这个例子里构造的立方体是前后左右四个面的，如果把屏幕当做立方体的“前”面，它的“左”、“后”、“右”面我们是看不见，但是这三个面可以通过“前”面旋转一个角度得到的：以立方体的中心点为支点，将“前”面分别顺时针旋转90度、180度、270。因为屏幕宽度为320，这个立方体的中心点应在屏幕中心点后方160px的地方。

现在需要解决的一个问题就是：怎么实现以立方体的中心点为支点的旋转。我们知道，在CALayer中layer的旋转是以anchorPoint为支点的，而这个anchorPoint并没有在z轴上的维度，所以修改anchorPoint是不可能的，怎么办呢？答案还是通过平移实现，虽然不能修改anchorPoint，但我们可以改变图片的位置，将图片往z轴正方向(靠近用户的方向)平移160px的距离，这时候图片与anchorPoint的相对位置，就等同于图片在原始位置与立方体中心的相对位置，它们所进行的旋转效果是相同的，只是在z轴上的绝对距离不同。旋转完成后，再平移回去，即可达到绕立方体的中心点旋转的效果。这也是变换矩阵mat0为什么要先进行z轴正方向160px平移，执行rotate0旋转之后又进行z轴负方向160px平移的缘故。

要实现旋转动画，就需要动态改变这个立方体的绕y轴的角度，在这个例子里就是添加了一个动态变化的angle达到这个目的。另外注意此例的旋转是绕y轴旋转的，根据此前一篇文章的判断方法，此时旋转的正方向应该是z轴正方向顶点指向x轴正方向顶点，从用户眼睛看来就是逆时针。如果angle是递增的，那么-angle就是递减的，因此实际看到的旋转动画会是顺时针的。

在分析这个例子时，自己又突然想到另外一个问题：对一个layer做平移，会修改它的anchorPoint和position吗？很显然，对旋转和绽放必须要有一个固定的支点，感觉上平移不需要支点也行，是不是就会修改anchorPoint呢？答案是否定时，简单做一下测试，就知道layer在做平移时，anchorPoint和position都不会改变，frame会变化，说明frame不仅受anchorPoint和position影响，还受translation影响.