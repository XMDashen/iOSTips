##UICollectionViewController的创建

一定要使用iniWithCollectionViewLayout方法，并传入布局方式，否则不会加载viewDidLoad

添加代码：

```
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    
    UICollectionViewController *btGirlVC=[[XMBtGirlController alloc] initWithCollectionViewLayout:layout];

```

这个协议需要手动添加
```
<UICollectionViewDelegateFlowLayout>
```

记得设置cell的size
```
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{


}
```
