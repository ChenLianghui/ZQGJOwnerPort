//
//  LLUserInfoViewController.m
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/6.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLUserInfoViewController.h"

@interface LLUserInfoViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation LLUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"基本信息"];
    _nameField.delegate = self;
    // Do any additional setup after loading the view.
}
- (IBAction)editBtnClick:(UIButton *)sender {
    _nameField.enabled = YES;
    _nameField.placeholder = @"";
    [_nameField becomeFirstResponder];
}
- (IBAction)commitBtnClick:(id)sender {
}

//隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
