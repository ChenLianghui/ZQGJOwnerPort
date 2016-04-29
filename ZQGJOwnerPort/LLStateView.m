//
//  LLStateView.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/19.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLStateView.h"

@implementation LLStateView

+ (LLStateView *)instanceView{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"LLStateView" owner:nil options:nil];
    return nibViews.firstObject;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    switch (self.condition) {
        case 1:
        {
            _label3.text = @"已支付";
            _label4.text = @"递送";
            _label5.text = @"完成";
        }
            break;
        case 2:
        {
            _label3.text = @"途中";
            _label4.text = @"已收";
            _label5.text = @"已发";
        }
            break;
        default:
            break;
    }

    [MyControl addRoundWithView:_point1 andRadius:10];
    [MyControl addRoundWithView:_point2 andRadius:10];
    [MyControl addRoundWithView:_point3 andRadius:10];
    [MyControl addRoundWithView:_point4 andRadius:10];
    [MyControl addRoundWithView:_point5 andRadius:10];
}

- (void)changeStateWithState:(int)state{
        switch (state) {
            case 1:
            {
                _point1.backgroundColor = LLMainColor;
                _label1.textColor = LLMainColor;
            }
            break;
        case 2:
            {
                _point2.backgroundColor = LLMainColor;
                _label2.textColor = LLMainColor;
            }
            break;
        case 3:
            {
                _point3.backgroundColor = LLMainColor;
                _label3.textColor = LLMainColor;
            }
            break;
        case 4:
            {
                _point4.backgroundColor = LLMainColor;
                _label4.textColor = LLMainColor;
            }
            break;
        case 5:
            {
                _point5.backgroundColor = LLMainColor;
                _label5.textColor = LLMainColor;
            }
            break;
        default:
            break;
    }
}


@end
