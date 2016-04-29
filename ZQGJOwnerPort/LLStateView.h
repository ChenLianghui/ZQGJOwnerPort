//
//  LLStateView.h
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/19.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLStateView : UIView
@property (weak, nonatomic) IBOutlet UIView *point1;
@property (weak, nonatomic) IBOutlet UIView *point2;
@property (weak, nonatomic) IBOutlet UIView *point3;
@property (weak, nonatomic) IBOutlet UIView *point4;
@property (weak, nonatomic) IBOutlet UIView *point5;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (nonatomic,assign) int condition;
+ (LLStateView *)instanceView;
- (void)changeStateWithState:(int)state;

@end
