//
//  LLSendPackageViewController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/12.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLSendPackageViewController.h"
#import "LLStateView.h"
#import "LLShadeView.h"

@interface LLSendPackageViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    LLShadeView *_ShadeView;
    UITableView *_CompanyTB;//快递列表
}
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *desTF;
@property (weak, nonatomic) IBOutlet UILabel *fromAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *ExpressBtn;//快递button

@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (nonatomic,strong) NSArray *CompanyArray;//快递数据源
@property (nonatomic,assign) int state;//订单状态，1为申请，2为待付，3为途中，4为已收，5为已发
@property (weak, nonatomic) IBOutlet UIView *textBgView;
@property (weak, nonatomic) IBOutlet UIScrollView *MainScrollView;

@end

@implementation LLSendPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"申请揽件"];
    _fromAddressLabel.text = self.addressStr;
    [MyControl addRoundWithView:_commitBtn andRadius:5];
    self.state = 1;
    [self initPointView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
    [_textBgView addGestureRecognizer:tap];
}

- (void)initPointView{
    LLStateView *stateView = [LLStateView instanceView];
    stateView.condition = 2;
    [stateView changeStateWithState:self.state];
    [self.pointView addSubview:stateView];
}


//- (NSArray *)CompanyArray{
//    if (!_CompanyArray) {
//        _CompanyArray = [[NSArray alloc] init];
//    }
//    return _CompanyArray;
//}

- (void)getCompanyArray{
//    _CompanyArray = [[NSArray alloc] init];
//    _CompanyArray = @[@"快递总公司",@"申通快递",@"圆通快递",@"全峰快递",@"芝麻开门"];
    _CompanyArray = [NSArray arrayWithObjects:@"快递总公司",@"申通快递",@"圆通快递",@"全峰快递",@"芝麻开门", nil];
}

#pragma mark - 选择快递
- (IBAction)ExpressBtnClick:(UIButton *)sender {
    //申请寄件
    [self getCompanyArray];
    
    _ShadeView = [[LLShadeView alloc] initWithFrame:CGRectMake(40, kScreenSize.height/2-150, kScreenSize.width-80, 300)];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_ShadeView.selectView.frame), 50)];
    titleLabel.text = @"选择快递";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = LLGrayBackgroundColor;
    [_ShadeView.selectView addSubview:titleLabel];
    
    _CompanyTB = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(_ShadeView.selectView.frame), CGRectGetHeight(_ShadeView.selectView.frame)-CGRectGetHeight(titleLabel.frame)) style:UITableViewStylePlain];
    _CompanyTB.delegate = self;
    _CompanyTB.dataSource = self;
    _CompanyTB.rowHeight = 50;
    _CompanyTB.tableFooterView = [[UIView alloc] init];
    [_ShadeView.selectView addSubview:_CompanyTB];

}

- (void)tap{
    [_ShadeView removeFromSuperview];
}

#pragma mark - 提交按钮
- (IBAction)commitBtnClick:(UIButton *)sender {
    
}



#pragma mark - UITableViewDelegate DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _CompanyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _CompanyArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_ShadeView removeFromSuperview];
    [_ExpressBtn setTitle:_CompanyArray[indexPath.row] forState:UIControlStateNormal];
}


- (void)hiddenKeyBoard{
    [_nameTF resignFirstResponder];
    [_addressTF resignFirstResponder];
    [_phoneTF resignFirstResponder];
    [_desTF resignFirstResponder];
}

#pragma mark -UITextfieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset = CGRectGetMaxY(frame) - (kScreenSize.height-64 - 216-90);
    if (offset > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.view.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
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
