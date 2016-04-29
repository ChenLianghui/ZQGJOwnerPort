//
//  LLScoreView.h
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/18.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLScoreView : UIView
@property (weak, nonatomic) IBOutlet UIView *starView;


@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UITextField *fuyanTF;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (nonatomic,assign) BOOL isSelected;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
+(LLScoreView *)instanceView;
@end
