//
//  LLAddressDetailViewController.m
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLAddressDetailViewController.h"
#import "LLShadeView.h"

@interface LLAddressDetailViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    NSArray *_dataArray;
    UITableView *_tableView;
    LLShadeView *_shadeView;
    UIPickerView *_communityPickView;
    CGRect _BGframe;
}
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UITextField *communityTF;
@property (weak, nonatomic) IBOutlet UIView *bgView;



@end

@implementation LLAddressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"新增地址"];
    _communityTF.delegate = self;
    [MyControl addRoundWithView:_commitBtn andRadius:5];
    // Do any additional setup after loading the view.
}



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _communityTF) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CommunityList" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:path];
        _communityPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenSize.height-150, kScreenSize.width, 150)];
        _communityPickView.delegate = self;
        _communityPickView.dataSource = self;
        _communityPickView.backgroundColor = [UIColor whiteColor];
        _communityTF.inputView = _communityPickView;
    }
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset = CGRectGetMaxY(frame) - (kScreenSize.height-64 - 216-80);
    if (offset > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            _BGframe = _bgView.frame;
            self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
//    [UIView animateWithDuration:0.5 animations:^{
    self.view.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
//    }];
}

#pragma mark - UIPickViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _communityTF.text = _dataArray[row];
}

//#pragma mark - UITableViewdataSource
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArray.count;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellId = @"cellId";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
//    cell.textLabel.text = _dataArray[indexPath.row];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [_selectBtn setTitle:_dataArray[indexPath.row] forState:UIControlStateNormal];
//    [_shadeView removeFromSuperview];
//}

- (IBAction)commitBtnClick:(UIButton *)sender {
    
}

//隐藏键盘
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
