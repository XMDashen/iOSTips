##Masonry约束

masonry写约束前，先将约束的对象添加到父视图上

xib创建的控件，用masonry只能约束左上，不能约束右下和宽高？

###约束样本
```
//view1的左边距离父View左边10个点：
[view1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(view1.superview.mas_left).multipliedBy(1).offset(10);
}];
```

###make（约束的对象）
返回MASConstraintMaker类型

###Attribute（约束对象的属性）
返回MASConstraint类型
```
//Basic Attribute
@property (nonatomic, strong, readonly) MASConstraint *left;
@property (nonatomic, strong, readonly) MASConstraint *top;
@property (nonatomic, strong, readonly) MASConstraint *right;
@property (nonatomic, strong, readonly) MASConstraint *bottom;
@property (nonatomic, strong, readonly) MASConstraint *leading;
@property (nonatomic, strong, readonly) MASConstraint *trailing;
@property (nonatomic, strong, readonly) MASConstraint *width;
@property (nonatomic, strong, readonly) MASConstraint *height;
@property (nonatomic, strong, readonly) MASConstraint *centerX;
@property (nonatomic, strong, readonly) MASConstraint *centerY;
@property (nonatomic, strong, readonly) MASConstraint *baseline;

//Margin Attribute
@property (nonatomic, strong, readonly) MASConstraint *leftMargin;
@property (nonatomic, strong, readonly) MASConstraint *rightMargin;
@property (nonatomic, strong, readonly) MASConstraint *topMargin;
@property (nonatomic, strong, readonly) MASConstraint *bottomMargin;
@property (nonatomic, strong, readonly) MASConstraint *leadingMargin;
@property (nonatomic, strong, readonly) MASConstraint *trailingMargin;
@property (nonatomic, strong, readonly) MASConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) MASConstraint *centerYWithinMargins;

//Convenient Attribute
@property (nonatomic, strong, readonly) MASConstraint *edges;
@property (nonatomic, strong, readonly) MASConstraint *size;
@property (nonatomic, strong, readonly) MASConstraint *center;
```

###Relationship（约束关系=、>=、<=）

```
- (MASConstraint * (^)(id attr))equalTo;
- (MASConstraint * (^)(id attr))greaterThanOrEqualTo;
- (MASConstraint * (^)(id attr))lessThanOrEqualTo;
```

###multiplier（倍数）
multipliedBy: 直接设置乘数
dividedBy: 设置乘数的倒数 multiplier = 1.0/dividedBy
一般宽或者高的约束使用multiplier比较多

###Constant
offset: 可以用来设置所有的东西。接受CGFloat类型的值
insets: 用来设置left, right, top, bottom。接受MASEdgeInsets类型值
sizeOffset: 用来设置width, height。接受CGSize类型的值
centerOffset: 用来设置centerX, centerY。接受CGPoint类型的值

一般用offset

###设置或更新约束
对于约束的设置，Masonry提供了3种方法，分别为设置约束、更新约束、重写设置约束

```
// 设置约束    
- (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block;

// 更新约束
- (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *make))block;

// 重新设置约束
- (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block;
```

###批量设置约束
假设有View1，view2，view3三个View，我们想要他们的宽高都等于CGSizeMake(100, 50)。我们可以对他们进行批量设置：
MASConstraintMaker可接收数组

```
NSValue *sizeValue = [NSValue valueWithCGSize:CGSizeMake(100, 50)];
[@[view1,view2,view3] mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.equalTo(sizeValue);
}];
```
由于我们还要设置view的top,left等位置约束。那可不可以在设置位置的mas_makeConstraints里面批量设置宽高呢？实际是可以的！

```
[view1 mas_makeConstraints:^(MASConstraintMaker *make) {
    (void)make.top.left;
    make.size.equalTo(@[view2,view3,sizeValue]);
}];
```


简书：
http://www.jianshu.com/p/1841e6c69611