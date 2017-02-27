//
//  Mobliejudge.h
//  DongDongWedding
//
//  Created by gyz on 16/8/3.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mobliejudge : NSObject
+ (NSString *)valiMobile:(NSString *)mobile;
+ (BOOL)verifyIDCardNumber:(NSString *)value;
+ (BOOL)isChinese:(NSString *)value;
+ (BOOL)checkChinese:(NSString *)chinese;
+(BOOL)isValidateEmail:(NSString *)email;
+ (BOOL) isValidZipcode:(NSString*)value;
@end
