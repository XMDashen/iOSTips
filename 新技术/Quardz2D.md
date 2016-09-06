#Quartz2D

Quartz2D属于CoreGraphic框架的

自定义控件：继承自UIView，重写drawRect方法，可画出任意形状的控件

###一、获得上下文
```
***获取当前上下文***
CGContextRef context=UIGraphicsGetCurrentContext();

***保存上下文***
CGContextSaveGState(context);

***恢复上下文（恢复到保存时的状态）***
CGContextRestoreGState(context);

***开启新的图片上下文**
//尺寸
//是否透明
//放大倍数
UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);

***获取当前图片上下文的图片***
UIImage *clipedImage=UIGraphicsGetImageFromCurrentImageContext();

```

###二、绘制图形

***设置起点***
```
CGContextMoveToPoint(context, 0, 0);
```

***绘制线段***
```
CGContextAddLineToPoint(context, 100, 100);
```

***画圆***
```
CGContextAddEllipseInRect(context, CGRectMake(0, 0, 100, 300));
```

***画圆弧***
```
//圆心
//半径
//起始角度
//终止角度
//clockwise：0-顺时针，1-逆时针

 CGContextAddArc(context, self.bounds.size.width/2, self.bounds.size.height, 100, -M_PI_4, M_PI_4 * 3, 1);
```

***切割***(后面画的东西才会受裁剪影响)
```
CGContextClip(context);
```

***圆角***
```
   CGContextRef context=UIGraphicsGetCurrentContext();

   CGContextAddEllipseInRect(context, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));

   CGContextClip(context);

   CGContextFillPath(context);
```

***画文字***
```
NSString *str=@"Hellow";

[str drawInRect:CGRectMake(0, 0, 50, 50) withAttributes:nil];

[str drawAtPoint: withAttributes:];
```

***画图片***
```
UIImage *image=[UIImage imageNamed:@""];

//原大小
[image drawAtPoint:CGPointMake(0, 0)];
//拉伸
[image drawInRect:CGRectMake(0, 0, 50, 50)];
//平铺
[image drawAsPatternInRect:CGRectMake(0, 0, 600, 600)];
```

***贝塞尔曲线***
```
//控制点、结束点、clockwise
CGContextAddQuadCurveToPoint(context, 100, 100, 200, 0);
```

***设置线条宽度***
```
 CGContextSetLineWidth(context, 20);
```

***设置线条颜色***
```
[[UIColor redColor] set];
```

***设置线条颜色***
```
 CGContextSetRGBStrokeColor(context, 0.5, 0.4, 0.9, 1.0);
```

***设置填充颜色***
```
 CGContextSetRGBFillColor(context, 0.5, 0.4, 0.9, 1.0);
```

***关闭路径，连接起点和终点***
```
CGContextClosePath(context);
```

###三、将图形渲染到上下文

***空心线条***
```
CGContextStrokePath(context);
```

***填充***
```
CGContextFillPath(context);
```

***线段***
```
CGContextStrokeLineSegments(context, shadowPoints, 2);
```