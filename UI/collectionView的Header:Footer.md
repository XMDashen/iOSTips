##collectionView的Header/Footer

###先注册需要用到的类,注意是Supplementary这个方法
```
[_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMSpecialTitleCell class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SpecialTitle];
```

###通过代理方法设置headerView和footerView,复用时用dequeueReusableSupplementaryViewOfKind这个方法
```
//每个板块headerView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        
        //判断类型
        if (kind==UICollectionElementKindSectionHeader) {
            
            XMSpecialTitleCell *headerCell=[collectionView dequeueReusableSupplementaryViewOfKind:	kind withReuseIdentifier:SpecialTitle forIndexPath:indexPath];
            
            return headerCell;
        }
    
    return nil;
}
```

###定义headerView高度,默认为0
```
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    //header高度
    CGFloat sectionH=self.view.bounds.size.width * 42 / 375;
    
    CGSize sectionHeaderSize=CGSizeMake(self.view.bounds.size.width, sectionH);
    
    return sectionHeaderSize;
}
```