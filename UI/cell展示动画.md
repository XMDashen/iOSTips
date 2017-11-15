cell展示动画

willDisplayCell里加动画

```
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        POPBasicAnimation *expandAnimation=[POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        expandAnimation.fromValue=[NSValue valueWithCGSize:CGSizeMake(0, 0)];
        expandAnimation.toValue=[NSValue valueWithCGSize:CGSizeMake(1, 1)];
        expandAnimation.duration=1;
        [cell.layer pop_addAnimation:expandAnimation forKey:@"expandAnimation"];
    }
}
```