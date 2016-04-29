//
//  LLLoginViewController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/22.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLLoginViewController.h"
#import "LLTextField.h"
#import "LLRegisterViewController.h"


@interface LLLoginViewController ()<UITextFieldDelegate>
{
    CGPoint _bgViewCenter;
    CGPoint _loginCenter;
    CGPoint _registerCenter;
    CGPoint _startBgViewCenter;
    CGPoint _startLoginCenter;
    CGPoint _startRegisterCenter;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet LLTextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *eyeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *findBtn;
@property (nonatomic,assign) BOOL secure;

@end

@implementation LLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"登录"];
    [self addRound];
    _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTF.delegate = self;
    _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTF.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _bgView.hidden = YES;
    _loginBtn.hidden = YES;
    _registerBtn.hidden = YES;
    _findBtn.hidden = YES;
//    CGFloat offset = kScreenSize.width;
//    _bgViewCenter = _bgView.center;
//    _loginCenter = _loginBtn.center;
//    _registerCenter = _registerBtn.center;
//    
//    
//    _startBgViewCenter = CGPointMake(_bgViewCenter.x-offset, _bgViewCenter.y);
//    _startLoginCenter = CGPointMake(_loginCenter.x-offset, _loginCenter.y);
//    _startRegisterCenter = CGPointMake(_registerCenter.x, _registerCenter.y+100);
//    _bgView.center = _startBgViewCenter;
//    _loginBtn.center = _startLoginCenter;
//    _registerBtn.center = _startRegisterCenter;
//    _registerBtn.alpha = 0;
//    _findBtn.alpha = 0;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    _bgView.hidden = NO;
    _loginBtn.hidden = NO;
    
    _findBtn.hidden = NO;
    
    CGFloat offset = kScreenSize.width;
    _bgViewCenter = _bgView.center;
    _loginCenter = _loginBtn.center;
    //_registerCenter = _registerBtn.center;
    
    
    _startBgViewCenter = CGPointMake(_bgViewCenter.x-offset, _bgViewCenter.y);
    _startLoginCenter = CGPointMake(_loginCenter.x-offset, _loginCenter.y);
    //_startRegisterCenter = CGPointMake(_registerCenter.x, _registerCenter.y+kScreenSize.height);
    _bgView.center = _startBgViewCenter;
    _loginBtn.center = _startLoginCenter;
   // _registerBtn.center = _startRegisterCenter;
    //_registerBtn.alpha = 1;
    _findBtn.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        _bgView.center = _bgViewCenter;
    }];
    [UIView animateWithDuration:0.5 delay:0.3 options:0 animations:^{
        _loginBtn.center = _loginCenter;
        
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:0 animations:^{
           _registerBtn.hidden = NO;
           _registerCenter = _registerBtn.center;
           _registerCenter.y -= 100;
           _registerBtn.center = _registerCenter;
           _findBtn.alpha = 1;
           
           
       } completion:nil];
    }];
}

#pragma mark - 圆角处理

- (void)addRound{
    [MyControl addRoundWithView:_bgView andRadius:5 andBorderColor:[UIColor lightGrayColor] andBorderWidth:1];
    [MyControl addRoundWithView:_loginBtn andRadius:5];
    [MyControl addRoundWithView:_registerBtn andRadius:2 andBorderColor:LLMainColor andBorderWidth:1];
}

- (IBAction)eyeBtnClick:(UIButton *)sender {
    if (_secure) {
        [_eyeBtn setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
    }else{
        [_eyeBtn setImage:[UIImage imageNamed:@"eye_closed"] forState:UIControlStateNormal];
    }
    _secure = !_secure;
    //_passwordTF.secureTextEntry = _secure;
    [self.passwordTF setSecureTextEntry:_secure];
}
- (IBAction)loginBtnClick:(UIButton *)sender {
    if (![MyControl isTurePhoneNumberWithText:_phoneTF.text]) {
        [MyControl lockAnimationForView:_phoneTF];
        return;
    }
    if (![MyControl isTurePasswordWithText:_passwordTF.text]) {
        [MyControl lockAnimationForView:_passwordTF];
        return;
    }
    //进行登录
    
}
- (IBAction)findPWBtnClick:(UIButton *)sender {
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LLRegisterViewController *registerVC = [Sb instantiateViewControllerWithIdentifier:@"LLRegisterViewController"];
    registerVC.isRegister = NO;
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (IBAction)registerBtnClick:(UIButton *)sender {
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LLRegisterViewController *registerVC = [Sb instantiateViewControllerWithIdentifier:@"LLRegisterViewController"];
    registerVC.isRegister = YES;
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField == _phoneTF&&textField.text.length>=11) {
        return NO;
    }
    if (textField == _passwordTF&&textField.text.length>=12) {
        return NO;
    }else{
        return YES;
    }
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
