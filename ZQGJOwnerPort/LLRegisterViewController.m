//
//  LLRegisterViewController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/22.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLRegisterViewController.h"
#import "LLVCodeViewController.h"
#import "MBProgressHUD.h"

@interface LLRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *protocolLabel;

@end

@implementation LLRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isRegister) {
        [self addTitleViewWithName:@"注册"];
    }else{
        [self addTitleViewWithName:@"找回密码"];
        _protocolLabel.hidden = YES;
    }
    
    [self addRound];
    _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTF.delegate = self;
    // Do any additional setup after loading the view.
}

#pragma mark - 圆角处理

- (void)addRound{
    [MyControl addRoundWithView:_bgView andRadius:5 andBorderColor:[UIColor lightGrayColor] andBorderWidth:1];
    [MyControl addRoundWithView:_nextBtn andRadius:5];
}
- (IBAction)nextBtnClick:(UIButton *)sender {
    if (![MyControl isTurePhoneNumberWithText:_phoneTF.text]) {
        [MyControl lockAnimationForView:_phoneTF];
        [MyControl addHUDViewOnView:self.navigationController.view WithText:@"请输入正确的手机号码"];
        return;
    }
    
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LLVCodeViewController *vcodeVC = [Sb instantiateViewControllerWithIdentifier:@"LLVCodeViewController"];
    vcodeVC.isRegister = self.isRegister;
    [self.navigationController pushViewController:vcodeVC animated:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.text.length>=11) {
        return NO;
    }
    return YES;
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
