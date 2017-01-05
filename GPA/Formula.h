//
//  Formula.h
//  GPA
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Formula : NSObject

//四分之计算
-(double)formulaOfFourPointSystem:(NSMutableArray*)grade credit:(NSMutableArray*)credit;

//五分制计算
-(double)formulaOfFivePointSystem:(NSMutableArray*)grade credit:(NSMutableArray*)credit;


@end
