//
//  myButton.h
//  ButtonEffect
//
//  Created by LIU KAIYANG on 16/1/21.
//  Copyright © 2016年 LIU KAIYANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myButton : UIButton

@property (nonatomic,strong)UIColor *circleColor;
@property (nonatomic) BOOL *circleColorIsSet;

-(instancetype)initWithFrame:(CGRect)frame;
@end
