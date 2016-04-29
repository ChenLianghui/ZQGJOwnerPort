//
//  MyControl.h
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/11.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyControl : NSObject

+(void)createShadeView;

+ (void)addRoundWithView:(UIView *)view andRadius:(CGFloat)radius;

+ (void)addRoundWithView:(UIView *)view andRadius:(CGFloat)radius andBorderColor:(UIColor *)color andBorderWidth:(CGFloat)width;

+ (UIButton *)creatButtonWithFrame:(CGRect)frame target:(id)target selector:(SEL)sel tag:(int)tag image:(NSString *)image title:(NSString *)title;

+ (UILabel *)creatLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)tColor bgcolor:(UIColor *)bgcolor font:(CGFloat)size;

+ (CGFloat)textHeigthFromTextString:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize;

+ (BOOL)isTurePhoneNumberWithText:(NSString *)text;

+ (BOOL)isTurePasswordWithText:(NSString *)text;
+ (void)lockAnimationForView:(UIView*)view;

+ (void)addHUDViewOnView:(UIView *)view WithText:(NSString *)text;

@end
