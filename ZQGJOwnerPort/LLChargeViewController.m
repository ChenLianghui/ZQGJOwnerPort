//
//  LLChargeViewController.m
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLChargeViewController.h"

@interface LLChargeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentAmout;
@property (weak, nonatomic) IBOutlet UITextField *AmountTF;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation LLChargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"充值"];
    _commitBtn.layer.masksToBounds = YES;
    _commitBtn.layer.cornerRadius = 5;
    // Do any additional setup after loading the view.
}
- (IBAction)commitBtnClick:(UIButton *)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
