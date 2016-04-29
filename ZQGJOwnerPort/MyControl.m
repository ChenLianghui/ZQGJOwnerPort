//
//  MyControl.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/11.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "MyControl.h"
#import "MBProgressHUD.h"

@implementation MyControl
+(void)createShadeView{
    
}
+ (void)addRoundWithView:(UIView *)view andRadius:(CGFloat)radius{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = radius;
}

+ (void)addRoundWithView:(UIView *)view andRadius:(CGFloat)radius andBorderColor:(UIColor *)color andBorderWidth:(CGFloat)width{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = radius;
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = width;
}

//创建一个button
+ (UIButton *)creatButtonWithFrame:(CGRect)frame target:(id)target selector:(SEL)sel tag:(int)tag image:(NSString *)image title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    //取消button的点击效果
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = frame;
    button.tag = tag;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UILabel *)creatLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)tColor bgcolor:(UIColor *)bgcolor font:(CGFloat)size{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = tColor;
    label.backgroundColor = bgcolor;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:size];
    return label;
}

/**
 计算普通文本的高度
 
 - parameter text:     源文本
 - parameter width:    填充文本的宽度
 - parameter fontSize: 字体大小
 
 - returns: 返回文本的高度
 */

+ (CGFloat)textHeigthFromTextString:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return rect.size.height;
    
}
//判断输入手机号的格式
+ (BOOL)isTurePhoneNumberWithText:(NSString *)text{
    NSString *match = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",match];
    if ([predicate evaluateWithObject:text]) {
        return YES;
    }else{
        return NO;
    }
}
//判断密码格式
+ (BOOL)isTurePasswordWithText:(NSString *)text{
    NSString *codeMatch = @"[A-Za-z0-9]{6,12}";
    NSPredicate *codePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeMatch];
    if ([codePredicate evaluateWithObject:text]) {
        return YES;
    }
    return NO;
}

//震动view
+ (void)lockAnimationForView:(UIView*)view
{
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
}
//添加纯文本hud
+ (void)addHUDViewOnView:(UIView *)view WithText:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(text, @"HUD message title");
    hud.offset = CGPointMake(0.f,0.f);
    hud.bezelView.backgroundColor = LLMainColor;
    
    [hud hideAnimated:YES afterDelay:1.5f];
}

@end
