//
//  Calculator.h
//  GPA
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Formula.h"
@interface Calculator : NSObject

//五分制计算
-(double)calculateWithFivePointSystem:(NSMutableArray*)grade credit:(NSMutableArray*)credit;

//四分制计算
-(double)calculateWithFourPointSystem:(NSMutableArray*)grade credit:(NSMutableArray*)credit;

//计算GPA等级
-(NSString*)calculateForGPALevel:(double)gpa;

//根据成绩显示颜色区间
-(void)changeColorForTextFeild:(UITextField*)textFeild andGrade:(NSString*)grade andCell:(UITableViewCell*)cell;


@end
