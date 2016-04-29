//
//  LLVCodeViewController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/22.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLVCodeViewController.h"
#import "LLSetPWViewController.h"

@interface LLVCodeViewController (){
    NSTimer *_timer;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *textBgView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *againBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic, assign)int countDown;

@end

@implementation LLVCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"填写验证码"];
    [self addRound];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _countDown = 5;
    // Do any additional setup after loading the view.
}
#pragma mark - 圆角处理

- (void)addRound{
    [MyControl addRoundWithView:_textBgView andRadius:5 andBorderColor:[UIColor lightGrayColor] andBorderWidth:1];
    [MyControl addRoundWithView:_nextBtn andRadius:5];
    [MyControl addRoundWithView:_againBtn andRadius:5 andBorderColor:[UIColor grayColor] andBorderWidth:1];
}


- (IBAction)againBtnClick:(UIButton *)sender {
    sender.enabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ontimer) userInfo:nil repeats:YES];
}

- (void)ontimer{
    if (_countDown > 0) {
        [_againBtn setTitle:[NSString stringWithFormat:@"%d秒重新获取",_countDown] forState:UIControlStateDisabled];
        _countDown--;
    }else{
        _countDown = 5;
        [_timer invalidate];
        _timer = nil;
        [_againBtn setTitle:@"5秒重新获取" forState:UIControlStateDisabled];
        [_againBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
        _againBtn.enabled = YES;
    }
}

- (IBAction)nextBtnClick:(UIButton *)sender {
    LLSetPWViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"LLSetPWViewController"];
    VC.isRegister = self.isRegister;
    [self.navigationController pushViewController:VC animated:YES];
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
