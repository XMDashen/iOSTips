[[[_searchTextField.rac_textSignal throttle:0.5] distinctUntilChanged] subscribeNext:^(NSString * _Nullable x) {
           
            [_searchVc requestDataWithKeySearchWord:_searchTextField.text];
        }];