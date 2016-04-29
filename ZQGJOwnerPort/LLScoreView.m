//
//  LLScoreView.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/18.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLScoreView.h"

@implementation LLScoreView

+(LLScoreView *)instanceView{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"LLScoreView" owner:nil options:nil];
    return [nibView firstObject];
}
- (IBAction)buttonClick:(UIButton *)sender {
//    [UIView animateWithDuration:0.5 animations:^{
//        self.payView.frame = CGRectMake(210, 140, 0, 0);
//    } completion:nil];
    _isSelected = !_isSelected;
    self.payView.hidden = YES;
    switch (sender.tag) {
        case 20:
            [self.payBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
            break;
        case 21:
            [self.payBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
            break;
        case 22:
            [self.payBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
            break;
        case 23:
            [self.payBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
            break;
        case 24:
            [self.payBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self.payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //self.payView.frame = CGRectMake(210, 140, 0, 0);
    self.payView.hidden = YES;
    // Drawing code
}

- (void)payBtnClick:(UIButton *)button{
//    button.selected = !button.selected;
//    if (button.selected) {
////        [UIView animateWithDuration:0.5 animations:^{
////            self.payView.frame = CGRectMake(210, 140, 98, 158);
////        } completion:nil];
//        self.payView.hidden = NO;
//        
//    }else{
////        [UIView animateWithDuration:0.5 animations:^{
////            self.payView.frame = CGRectMake(210, 140, 0, 0);
////        } completion:nil];
//        self.payView.hidden = YES;
//    }
    _isSelected = !_isSelected;
    if (_isSelected) {
        self.payView.hidden = NO;
    }else{
        self.payView.hidden = YES;
    }
}


@end
