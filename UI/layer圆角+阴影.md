另外添加一个背景view

_photoShadowView.layer.shadowColor=[UIColor colorWithHexString:@"313131"].CGColor;
    _photoShadowView.layer.shadowRadius=3;
    _photoShadowView.layer.shadowOffset=CGSizeMake(0, 5);
    _photoShadowView.layer.shadowOpacity=0.7;
    _photoShadowView.layer.cornerRadius=35;
    
######clipsToBounds=no