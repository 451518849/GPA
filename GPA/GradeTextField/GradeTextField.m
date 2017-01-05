//
//  GradeTextField.m
//  GPA
//
//  Created by apple on 16/1/24.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "GradeTextField.h"

@implementation GradeTextField

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:56/255.0 green:151/255.0 blue:250/255.0 alpha:1].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
}

@end
