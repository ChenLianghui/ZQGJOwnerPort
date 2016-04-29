//
//  LLWaterOrderViewController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLWaterOrderViewController.h"

@interface LLWaterOrderViewController ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *walletBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UIButton *noPayBtn;
@property (weak, nonatomic) IBOutlet UIView *hiddenView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *MainViewHeight;

@end

@implementation LLWaterOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"桶装水支付"];
    // Do any additional setup after loading the view.
    [self changeBackground:_walletBtn];
    [self changeBackground:_wechatBtn];
    [self changeBackground:_noPayBtn];
    self.hasFanxian = NO;
    if (!self.hasFanxian) {
        _timeLabelTop.constant = 20;
        _hiddenView.hidden = YES;
        _MainViewHeight.constant = 360-46;
    }
}

- (void)changeBackground:(UIButton *)button {
    [button setTitleColor:LLMainColor forState:UIControlStateNormal];
    [button setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[self createImageWithColor:LLMainColor] forState:UIControlStateHighlighted];
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (IBAction)walletBtnClick:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"零钱包余额不足" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:alertAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)wechatBtnClick:(id)sender {
}
- (IBAction)noPayBtnClick:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
