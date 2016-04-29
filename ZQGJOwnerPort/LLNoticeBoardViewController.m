//
//  LLNoticeBoardViewController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/11.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLNoticeBoardViewController.h"
#import "NoticeTableViewCell.h"

@interface LLNoticeBoardViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    UIView *_ShadeView;
    NSArray *_dataArray;//社区数据源
    NSArray *_noticeArray;//通知数据源
    UIPickerView *_communityPickView;
    UITableView *_NoticeTableView;//通知列表
    NSInteger _noticeNumber;
}
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITextField *communityTF;


@end

@implementation LLNoticeBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"我的公告"];
    _communityTF.delegate = self;
    // Do any additional setup after loading the view.
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CommunityList" ofType:@"plist"];
    _dataArray = [NSArray arrayWithContentsOfFile:path];
    _communityPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenSize.height-150, kScreenSize.width, 150)];
    _communityPickView.delegate = self;
    _communityPickView.dataSource = self;
    _communityPickView.backgroundColor = [UIColor whiteColor];
    _communityTF.inputView = _communityPickView;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 44)];
    toolbar.barTintColor = LLMainColor;
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(dismissPick)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[flexItem,item1];
    toolbar.tintColor = [UIColor whiteColor];
    _communityTF.inputAccessoryView = toolbar;
    
    _communityTF.text = _dataArray.firstObject;
    
    return YES;
}

- (void)dismissPick{
    [_communityTF resignFirstResponder];
    [_NoticeTableView removeFromSuperview];
    _NoticeTableView = nil;
    [self createNoticeTableView];
}

#pragma mark UIPickerViewDelegate

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
    _noticeNumber = row;
}




- (void)createNoticeTableView{
    _NoticeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), kScreenSize.width, kScreenSize.height-64-CGRectGetHeight(_headView.frame)) style:UITableViewStylePlain];
    _NoticeTableView.backgroundColor = [UIColor clearColor];
    _NoticeTableView.delegate = self;
    _NoticeTableView.dataSource = self;
    _NoticeTableView.rowHeight = 100;
    [_NoticeTableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoticeTableViewCell"];
    [self.view addSubview:_NoticeTableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _noticeNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"NoticeTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
