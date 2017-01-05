//
//  GradeCell.m
//  GPA
//
//  Created by apple on 16/1/24.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "GradeCell.h"

@implementation GradeCell

- (void)awakeFromNib
{
    _grade.textAlignment = NSTextAlignmentCenter;
    _credit.textAlignment = NSTextAlignmentCenter;
    
    _grade.keyboardType = UIKeyboardTypeDecimalPad;
    _credit.keyboardType = UIKeyboardTypeDecimalPad;

    _grade.borderStyle = UITextBorderStyleNone;
    _credit.borderStyle = UITextBorderStyleNone;
    
    _grade.textColor =  [UIColor colorWithRed:56/255.0 green:151/255.0 blue:250/255.0 alpha:1];
    _credit.textColor = [UIColor colorWithRed:56/255.0 green:151/255.0 blue:250/255.0 alpha:1];

}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
