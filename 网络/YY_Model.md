##YY_Model

####解析模型数组(返回装有模型的数组)
```
		//取出数据数组
        NSArray *dataArray=responseObject[@"news"];

        //用YYModel解析
        NSArray *modelArray=[NSArray yy_modelArrayWithClass:[XMNewsModel class] json:dataArray];
        ```

####解析单个模型
```
//将单个JSON数据转化为单个模型(用什么类方法调用yymodel就返回该类型的数据)
        XMGoodsDetailModel *modelDict=[XMGoodsDetailModel yy_modelWithJSON:dataDict];

```



   
####model配合cell常用套路
   ```
   //新闻模型
@property(nonatomic,strong) XMNewsModel *model;

//model的set方法里添加属性
-(void)setModel:(XMNewsModel *)model{

	_model=model;
	
     //标题
    self.titleLabel.text=model.title;

}
```

###两个YYModel代理方法
在model里添加YYModel协议
```
        @interface XMNewsModel : NSObject<YYModel>
   ```

####1.属性映射(JSON的key值和属性名不一致时调用该方法)
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。(@"model属性名":@"JSON的KEY")
+(NSDictionary *)modelCustomPropertyMapper{
    
    
    return @{@"desc":@"description"};
}


####2.自定义容器类属性(容器内装的==基本数据类型==(NSString等)的话不用此方法也可以解析)
//容器类属性--返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
//返回@{@"属性名":@"容器内数据类型"}

```
@property(nonatomic,strong) NSArray<XMClass *> *object;
```

```
+(NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"object":@"XMClass"};
}
```

####属性model中套model
可以写在同一.h文件里面
```
@class XMGoodsExtendModel;
@interface XMGoodsDetailModel : NSObject<YYModel>

//商品扩展属性
@property(nonatomic,strong) XMGoodsExtendModel *goods_extend;

@end

@interface XMGoodsExtendModel : NSObject<YYModel>

//主图数组地址
@property(nonatomic,strong) NSArray *slide;

@end
```

写在同一.h文件里的话记得要在.m文件里声明一下
```
@implementation XMGoodsExtendModel


@end
```
