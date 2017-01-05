//
//  myButton.m
//  ButtonEffect
//
//  Created by LIU KAIYANG on 16/1/21.
//  Copyright © 2016年 LIU KAIYANG. All rights reserved.
//

#import "myButton.h"

# define CORNER_BUTTON_DEFAULT_HEIGT 100.0
# define CORNER_BUTTON_DEFAULT_RADIUS 10.0

@implementation myButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)tap:(UIGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:[gesture view]];
    int x = point.x;
    int y = point.y;
    UIView *circleView = [[UIView alloc]initWithFrame:CGRectMake(x-5, y-5, 10, 10)];
    if (self.circleColor) {
        circleView.backgroundColor = self.circleColor;
    }else
        circleView.backgroundColor = [UIColor whiteColor];   //default color
        circleView.layer.cornerRadius = 5;
    circleView.userInteractionEnabled = NO;
        [self addSubview:circleView];
    
        [UIView animateWithDuration:0.7f
                         animations:^{
            circleView.transform = CGAffineTransformMakeScale(40, 40);circleView.alpha = 0.0;}
                         completion:^(BOOL finished){[circleView removeFromSuperview];}];
}

-(CGFloat) cornerScaleFactor { return self.bounds.size.height / CORNER_BUTTON_DEFAULT_HEIGT; }
-(CGFloat) cornerRadius { return CORNER_BUTTON_DEFAULT_RADIUS * [self cornerScaleFactor]; }

-(void) setup
{
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    
    [self addGestureRecognizer:tapGestureRecognizer];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = [self cornerRadius];    
}

-(void)awakeFromNib
{
    [self setup];
}

@end
