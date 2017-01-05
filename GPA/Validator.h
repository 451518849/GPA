//
//  Validator.h
//  GPA
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

//正则表达式，检验数字是否为整数或小数
+(BOOL)validateNumber:(NSString*)textString;

@end
