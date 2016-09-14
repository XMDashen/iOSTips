##YY_Model

用YYModel解析
```
		//取出数据数组
        NSArray *dataArray=responseObject[@"news"];

        //用YYModel解析
        NSArray *modelArray=[NSArray yy_modelArrayWithClass:[XMNewsModel class] json:dataArray];
        ```

在model里添加YYModel协议
```
        @interface XMNewsModel : NSObject<YYModel>
   ```
   
在cell里
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