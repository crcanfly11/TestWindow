//
//  UIProgressDensityLeft.m
//  LDProgressView
//
//  Created by 金成日 on 14-4-17.
//  Copyright (c) 2014年 Light Design. All rights reserved.
//

#import "UIProgressDensityLeft.h"

@implementation UIProgressDensityLeft

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setProgressTintColor:[UIColor greenColor]];
    }
    return self;
}

//step is longer with time running,it is let you fell quikly end as than average step.
- (NSNumber *) progressDensityLeft:(NSInteger) progress
{
    if(progress) {
        NSInteger step = progress/10;
        
        NSNumber *remainder;
        if(step)
            remainder = @(progress%(step*10));
        else
            remainder = @0;
        
        return @(step*step+(2*step+1)*[remainder doubleValue]/10);
    }
    else {
        return @(progress);
    }
}

- (void)setProgress:(CGFloat)progress {
    //progressDensityLeft方法如果以 objc的语法格式写的话，编译器会爆与C99规范冲突的问题，解决方法：1，修改编译器规则 改成C89，但这样会有隐患；2，以c语言格式 在函数头实现该方法。但这个也要根据你选用的方法来确定。
    //self.progress = progressDensityLeftC(self.progress*100);  //c风格
        
    [super setProgress:[[self progressDensityLeft:progress*100] floatValue]/100];
}

@end
