//
//  Calculator.m
//  GPA
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator
{
    Formula *formula;
}

-(double)calculateWithFivePointSystem:(NSMutableArray*)grade credit:(NSMutableArray*)credit;
{
    formula = [[Formula alloc]init];
    return [formula formulaOfFivePointSystem:grade credit:credit];
}

-(double)calculateWithFourPointSystem:(NSMutableArray*)grade credit:(NSMutableArray*)credit;
{
    formula = [[Formula alloc]init];
    return [formula formulaOfFourPointSystem:grade credit:credit];
}

-(void)changeColorForTextFeild:(UITextField*)textFeild
                      andGrade:(NSString*)grade
                       andCell:(UITableViewCell*)cell{
    
    double gradeValue = [grade doubleValue];
    
    if (gradeValue >= 90 && gradeValue <= 100)
    {
        double averageChage = (100 - gradeValue) * 20;
        
        cell.backgroundColor = [UIColor colorWithRed:averageChage/255
                                               green:255/255
                                                blue:127/255
                                               alpha:1];
    }
    else if (gradeValue >= 80 && gradeValue <= 89)
    {
        double averageChage = (90 - gradeValue) * 20;
        
        cell.backgroundColor = [UIColor colorWithRed:255/255
                                               green:255/255
                                                blue:averageChage/255
                                               alpha:1];
    }
    else if (gradeValue >= 70 && gradeValue <= 79)
    {
        double averageChage = (10-(80 - gradeValue)) * 15;
        
        cell.backgroundColor = [UIColor colorWithRed:255/255
                                               green:averageChage/255
                                                blue:255/255
                                               alpha:0.5];
        
    }
    else if (gradeValue >= 60 && gradeValue <= 69)
    {
        double averageChage = (70 - gradeValue) * 7.7;
        
        cell.backgroundColor = [UIColor colorWithRed:255/255
                                               green:127/255
                                                blue:averageChage/255
                                               alpha:0.5];
    }
    else if (gradeValue > 0 && gradeValue < 60)
    {
        cell.backgroundColor = [UIColor colorWithRed:255/255
                                               green:0/255
                                                blue:0/255
                                               alpha:0.8];
    }

}

-(NSString*)calculateForGPALevel:(double)gpa;
{
    if (gpa >= 4.5 && gpa <= 5.0)
    {
        return @"A+";
    }
    else if(gpa >= 4 && gpa < 4.5)
    {
        return @"A";
    }
    else if(gpa >= 3.5 && gpa < 4)
    {
        return @"B+";
    }
    else if(gpa >= 3 && gpa < 3.5)
    {
        return @"B";
    }
    else if(gpa >= 2.5 && gpa < 3)
    {
        return @"C+";
    }
    else if(gpa >= 2 && gpa < 2.5)
    {
        return @"C";
    }
    else if(gpa >= 1.5 && gpa < 2)
    {
        return @"D+";
    }
    else if(gpa >= 1 && gpa < 1.5)
    {
        return @"D";
    }
    else if( gpa < 1)
    {
        return @"E";
    }
    return nil;
}
@end
