//
//  LLSetPWViewController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/22.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLSetPWViewController.h"
#import "LLTextField.h"

@interface LLSetPWViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *textBgView;
@property (weak, nonatomic) IBOutlet LLTextField *textField;

@property (weak, nonatomic) IBOutlet LLTextField *textField2;

@property (weak, nonatomic) IBOutlet UIButton *pointBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic,assign) BOOL secure;
@property (weak, nonatomic) IBOutlet UILabel *pwLabel;

@end

@implementation LLSetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"设置密码"];
    if (self.isRegister) {
        self.pwLabel.text = @"密码";
        [self.nextBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    }else{
        self.pwLabel.text = @"新密码";
        [self.nextBtn setTitle:@"立即修改" forState:UIControlStateNormal];
    }
    [self addRound];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.delegate = self;
    _textField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField2.delegate = self;
    // Do any additional setup after loading the view.
}

#pragma mark - 圆角处理

- (void)addRound{
    [MyControl addRoundWithView:_textBgView andRadius:5 andBorderColor:[UIColor lightGrayColor] andBorderWidth:1];
    [MyControl addRoundWithView:_nextBtn andRadius:5];
}

- (IBAction)pointBtnClick:(UIButton *)sender {
    if (!_secure) {
        [_pointBtn setImage:[UIImage imageNamed:@"hollow_pressed"] forState:UIControlStateNormal];
    }else{
        [_pointBtn setImage:[UIImage imageNamed:@"hollow"] forState:UIControlStateNormal];
    }
    _textField.secureTextEntry = _secure;
    _textField2.secureTextEntry = _secure;
    _secure = !_secure;
    
}
- (IBAction)nextBtnClick:(UIButton *)sender {
    if (![MyControl isTurePasswordWithText:_textField.text]) {
        [MyControl lockAnimationForView:_textField];
        return;
    }
    if (![_textField2.text isEqualToString:_textField.text]) {
        [MyControl lockAnimationForView:_textField2];
        return;
    }
    
    if (self.isRegister) {
        //注册方法，
    }else{
        //忘记密码方法
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.text.length>=12) {
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
