##collectionView详解

###collectionView的创建
```
	//创建布局flowLayout
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    
   //滑动方向(cell里加collectionView最好用xib拖，问题较少，[self.collectionView setCollectionViewLayout:layout];)
   //layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    //最小行距
    layout.minimumLineSpacing=10;
    
    //最小列距
    layout.minimumInteritemSpacing=4;
    
    //创建
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake collectionViewLayout:layout];
    
    //添加到父视图
    [self.view addSubview:_collectionView];
    
    //内边距
    _collectionView.contentInset=UIEdgeInsetsMake(20, 0, 49, 0);
    
    //设置代理
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    
    //注册普通cell
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGoodsCategoryCell class]) bundle:nil] forCellWithReuseIdentifier:GoodsCell];
    
    //注册sectionHeader/Footer***(需要用supplementary注册)
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMHomeSectionHeaderCell class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HomeSectionHeader];
```


###代理方法/数据源
```
//板块数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 4;
}

//每个板块item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 3;
        case 1:
            return 4;
        case 2:
            return 3;
        case 3:
            return 6;
        case 4:
            return 2;
    }
    
    return 0;
}

//cell创建
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
        
        //复用
        XMNavCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NavCell forIndexPath:indexPath];
        
        return cell;
    }
   
    return nil;
}

#pragma mark cell点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

#pragma mark collectionViewFlowLayout代理方法
//布局方式
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize itemSize;
    
    CGFloat screenWidth=self.view.bounds.size.width;
    
    if (indexPath.section==0) {
        
        //单元格间距
        CGFloat margin=3;
        
        CGFloat itemW=(screenWidth-2*margin)/3;
        CGFloat itemH=itemW*95/125;
        
        itemSize=CGSizeMake(itemW, itemH);
        
    }
    
    return itemSize;
}

//每个板块headerView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section>=0) {
        
        //判断类型heaer/footer
        if (kind==UICollectionElementKindSectionHeader) {
            
            XMHomeSectionHeaderCell *headerCell=[collectionView dequeueReusableSupplementaryViewOfKind:	kind withReuseIdentifier:HomeSectionHeader forIndexPath:indexPath];
            
            return headerCell;
        }
    }
    
    return nil;
}

//headerView高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize sectionHeaderSize=CGSizeMake(self.view.bounds.size.width, 40);
    
    if (section==0) {
        sectionHeaderSize=CGSizeMake(0, 0);
    }
    
    return sectionHeaderSize;
}

//板块大小
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section>=0) {
        
        return UIEdgeInsetsMake(0, 0, 14, 0);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

```