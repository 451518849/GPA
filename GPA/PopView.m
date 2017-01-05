//
//  PopView.m
//  GPA
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "PopView.h"

@implementation PopView

-(void)gotoIntroductionVC:(UIView*)view
{
    if (!_isPopView)
    {
        _isPopView = YES;
        _popView = [[UIView alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 20, 230, 270)];
        _popView.backgroundColor = [UIColor colorWithRed:56/255.0 green:151/255.0 blue:250/255.0 alpha:1];
        _popView.layer.masksToBounds = YES;
        _popView.layer.cornerRadius = 15.0;
        [view addSubview:_popView];
        
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 20, 200, 250)];
        textView.text = @"                    使用说明\n GPA是一款计算平均绩点的小软件，学生可根据自己所在大学对绩点的计算公式，选择和合适的公式进行计算\n\n                    五分制\n    是按照平均绩点最高为5.0为标准的计算方式\n\n                    四分制\n    按照平均绩点最高为4.0为标准的计算方式";
        textView.editable           = NO;
        textView.backgroundColor    = [UIColor clearColor];
        textView.textColor          = [UIColor whiteColor];
        [_popView addSubview:textView];
        
        UIButton *close = [[UIButton alloc]initWithFrame:CGRectMake(200, 5, 30, 30)];
        [close setTitle:@"x" forState:UIControlStateNormal];
        [close addTarget:self action:@selector(closePopView) forControlEvents:UIControlEventTouchUpInside];
        [_popView addSubview:close];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _popView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2 - 120);
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    _popView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2 - 100);
                    
                } completion:^(BOOL finished) {
                    [self popViewAnimation:_popView];
                }];
            }
        }];
        
    }
    
}

-(void)popViewAnimation:(UIView*)view
{
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
        
        _popView.transform = CGAffineTransformMakeRotation(2.0/360.0);
        if (!_isPopView)
        {
            _popView.center = CGPointMake(SCREEN_WIDTH/2-2, SCREEN_HEIGHT/2-100 + 2);
            
        }
        
    } completion:^(BOOL finished) {
        if (finished) {
            
            [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _popView.transform = CGAffineTransformMakeRotation(-1/360.0);
                _popView.center =CGPointMake(SCREEN_WIDTH/2+2, SCREEN_HEIGHT/2-100);
                
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
                        _popView.transform = CGAffineTransformMakeRotation(0);
                        _popView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-100 - 2);
                        
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
                                _popView.transform = CGAffineTransformMakeRotation(2.0/360.0);
                                _popView.center = CGPointMake(SCREEN_WIDTH/2-2, SCREEN_HEIGHT/2-100 + 2);
                                
                            } completion:^(BOOL finished) {
                                [self popViewAnimation:_popView];
                            }];
                        }
                        
                    }];
                }
            }];
        }
    }];
}

-(void)closePopView
{
    _isPopView = NO;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _popView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT*2);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [_popView removeFromSuperview];
        }
    }];
    
    
}


@end
