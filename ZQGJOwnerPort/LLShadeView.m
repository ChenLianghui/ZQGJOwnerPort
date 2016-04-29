//
//  LLSelectView.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/13.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLShadeView.h"

@interface LLShadeView()<UIGestureRecognizerDelegate>

@end

@implementation LLShadeView

//- (instancetype)init{
//    
//}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 20, kScreenSize.width, kScreenSize.height-20);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:self];
        _selectView = [[UIView alloc] init];
        //_selectView = [[UIView alloc] initWithFrame:frame];
        _selectView.frame = CGRectMake(frame.origin.x,0-frame.size.height, frame.size.width, 0);
        _selectView.backgroundColor = [UIColor whiteColor];
        _selectView.layer.masksToBounds = YES;
        _selectView.layer.cornerRadius = 10;
        _selectView.alpha = 0.1;
        [self addSubview:_selectView];
//        [UIView animateWithDuration:1 animations:^{
//            _selectView.frame = frame;
//        }];
//        [UIView animateWithDuration:1 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
//            _selectView.frame = frame;
//        } completion:nil];
        [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.9 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _selectView.frame = frame;
            _selectView.alpha = 1;
        } completion:nil];
    }
    return self;
}

-(void)tap{
    [self removeFromSuperview];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:_selectView]) {
        return NO;
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
