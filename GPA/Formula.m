//
//  Formula.m
//  GPA
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "Formula.h"

@implementation Formula

-(double)formulaOfFourPointSystem:(NSMutableArray*)grade credit:(NSMutableArray*)credit;
{
    double sumGrades = 0.0;
    double sumCredits = 0.0;

    for (int i = 0; i < grade.count; i++)
    {
        if ([[grade objectAtIndex:i]doubleValue] >= 0 && [[grade objectAtIndex:i]doubleValue] <= 100)
        {
            sumGrades += ([[grade objectAtIndex:i]doubleValue] - 50)/10 * [[credit objectAtIndex:i]doubleValue]; //总绩点
            sumCredits += [[credit objectAtIndex:i]doubleValue] ; //总学分
            
        }
    }
    
    if (sumCredits != 0 && sumGrades != 0)
        return sumGrades/sumCredits;
    else
        return 0.0;
}

-(double)formulaOfFivePointSystem:(NSMutableArray*)grade credit:(NSMutableArray*)credit;
{
    double sumGrades = 0.0;
    double sumCredits = 0.0;
 
    for (int i = 0; i < grade.count; i++)
    {
        if ([[grade objectAtIndex:i]doubleValue] >= 90 && [[grade objectAtIndex:i]doubleValue] <= 100)
        {
            sumGrades +=  [[credit objectAtIndex:i]doubleValue] * 4.0;
        }
        else if ([[grade objectAtIndex:i]doubleValue] >= 85 && [[grade objectAtIndex:i]doubleValue] <= 89)
        {
            sumGrades +=  [[credit objectAtIndex:i]doubleValue] * 3.7;
        }
        else if ([[grade objectAtIndex:i]doubleValue] >= 82 && [[grade objectAtIndex:i]doubleValue] <= 84)
        {
            sumGrades +=  [[credit objectAtIndex:i]doubleValue] * 3.3;
        }
        else if ([[grade objectAtIndex:i]doubleValue] >= 78 && [[grade objectAtIndex:i]doubleValue] <= 81)
        {
            sumGrades +=  [[credit objectAtIndex:i]doubleValue] * 3.0;
        }
        else if ([[grade objectAtIndex:i]doubleValue] >= 75 && [[grade objectAtIndex:i]doubleValue] <= 77)
        {
            sumGrades +=  [[credit objectAtIndex:i]doubleValue] * 2.7;
        }
        else if ([[grade objectAtIndex:i]doubleValue] >= 72 && [[grade objectAtIndex:i]doubleValue] <= 74)
        {
            sumGrades +=  [[credit objectAtIndex:i]doubleValue] * 2.3;
        }
        else if ([[grade objectAtIndex:i]doubleValue] >= 68 && [[grade objectAtIndex:i]doubleValue] <= 71)
        {
            sumGrades +=  [[credit objectAtIndex:i]doubleValue] * 2.0;
        }
        else if ([[grade objectAtIndex:i]doubleValue] >= 64 && [[grade objectAtIndex:i]doubleValue] <= 67)
        {
            sumGrades +=  [[credit objectAtIndex:i]doubleValue] * 1.5;
        }
        else if ([[grade objectAtIndex:i]doubleValue] >= 60 && [[grade objectAtIndex:i]doubleValue] <= 63)
        {
            sumGrades +=  [[credit objectAtIndex:i]doubleValue] * 1.0;
        }
        else if ([[grade objectAtIndex:i]doubleValue] >= 0 && [[grade objectAtIndex:i]doubleValue] < 60)
        {
            sumGrades +=  [[credit objectAtIndex:i]doubleValue] * 0.0;
        }
        sumCredits += [[credit objectAtIndex:i]doubleValue] ; //总学分
    }
    
    if (sumCredits != 0 && sumGrades != 0)
        return sumGrades/sumCredits;
    else
        return 0.0;}

@end
