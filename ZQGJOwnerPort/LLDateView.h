//
//  LLDateView.h
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/19.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLDateView;
@protocol LLDateDelegate <NSObject>

- (void)dateDidChanged;

@end

@interface LLDateView : UIView


@property (nonatomic,assign) int year;
@property (nonatomic,assign) int month;
@property (weak, nonatomic) IBOutlet UIButton *centerBtn;
@property (nonatomic,weak) id <LLDateDelegate> delegate;
+ (LLDateView *)instanceView;
@end
