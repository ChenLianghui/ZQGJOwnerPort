//
//  LLPieceWiseViewController.m
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLWithdrawViewController.h"

@interface LLWithdrawViewController ()
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation LLWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"提现"];
    _commitBtn.layer.masksToBounds = YES;
    _commitBtn.layer.cornerRadius = 5;
    // Do any additional setup after loading the view.
}
- (IBAction)commitBtnClick:(UIButton *)sender {
    float balance = [_amountLabel.text floatValue];
    float amount = [_amountTF.text floatValue];
    if (amount > balance || balance == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"提现失败，余额不足！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *commit = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:commit];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
