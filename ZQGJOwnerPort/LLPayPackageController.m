//
//  LLPayPackageController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/19.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLPayPackageController.h"
#import "LLStateView.h"

@interface LLPayPackageController ()
{
    UIButton *_SelectedBtn;
}
@property (weak, nonatomic) IBOutlet UILabel *zhiquOrderLabel;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UIImageView *walletImage;
@property (weak, nonatomic) IBOutlet UILabel *yueLabel;
@property (weak, nonatomic) IBOutlet UILabel *hongbaoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *wechatImage;
@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@end

@implementation LLPayPackageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"支付揽件"];
    [self initPointView];
    [MyControl addRoundWithView:_cancelBtn andRadius:5];
    [MyControl addRoundWithView:_payBtn andRadius:5];
    // Do any additional setup after loading the view.
}

- (void)initPointView{
    LLStateView *stateView = [LLStateView instanceView];
    stateView.condition = 2;
    [stateView changeStateWithState:3];
    [self.pointView addSubview:stateView];
}

- (IBAction)walletBtnClick:(UIButton *)sender {
    _SelectedBtn = sender;
    _walletImage.image = [UIImage imageNamed:@"hollow_pressed"];
    _wechatImage.image = [UIImage imageNamed:@"hollow"];
}
- (IBAction)wechatBtnClick:(UIButton *)sender {
    _SelectedBtn = sender;
    _wechatImage.image = [UIImage imageNamed:@"hollow_pressed"];
    _walletImage.image = [UIImage imageNamed:@"hollow"];
}
- (IBAction)cancelBtnClick:(UIButton *)sender {
    
}
- (IBAction)payBtnClick:(UIButton *)sender {
    
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
