//
//  UIAlertViewTouchQuitAnyWhere.m
//  TestWindow
//
//  Created by 金成日 on 14-4-21.
//  Copyright (c) 2014年 金成日. All rights reserved.
//

#import "UIAlertViewTouchQuitAnyWhere.h"

@interface UIAlertViewTouchQuitAnyWhere () <UIGestureRecognizerDelegate>
// 点击背景取消
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end

@implementation UIAlertViewTouchQuitAnyWhere


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)tapAction:(UITapGestureRecognizer *)tapGesture{
    CGPoint touchPoint = [tapGesture locationInView:self];
    if (!CGRectContainsPoint(self.frame, touchPoint)) {
        [self.superview removeFromSuperview];
    }
}


@end
