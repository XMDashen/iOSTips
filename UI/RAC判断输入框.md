RAC判断输入框

```
RACSignal *phoneTextSignal=[self.phoneTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
       
        return @(_phoneTextField.text.length==11 ? YES : NO);
    }];

    RACSignal *verifyCodeSignal=[self.codeTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
       
        return @(_codeTextField.text.length>0 ? YES : NO);
    }];

    RACSignal *passWordSignal=[self.passwordField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
       
        return @(_passwordField.text.length>0 ? YES : NO);
    }];

    RACSignal *signUpSignal=[RACSignal combineLatest:@[phoneTextSignal,verifyCodeSignal,passWordSignal] reduce:^id _Nullable(NSNumber *phoneValid, NSNumber *verifyCodeValid,NSNumber *passwordValid){
       
        return @(phoneValid.boolValue && verifyCodeValid.boolValue && passwordValid.boolValue);
    }];
    
    [signUpSignal subscribeNext:^(NSNumber *  _Nullable x) {
       
        self.sureRegister.enabled = [x boolValue];
        self.sureRegister.backgroundColor = [x boolValue] ? UIColorHex(0xFC686B) : [UIColor lightGrayColor];
    }];
    ```