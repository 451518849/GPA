//
//  Validator.m
//  GPA
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "Validator.h"

@implementation Validator
+(BOOL)validateNumber:(NSString*)textString
{
    NSString *number = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}
@end
