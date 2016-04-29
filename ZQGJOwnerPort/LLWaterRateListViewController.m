//
//  LLWaterRateListViewController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/11.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLWaterRateListViewController.h"
#import "YQYPiecewiseView.h"
#import "LLWaterOrderListCell.h"

@interface LLWaterRateListViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,YQYPiecewiseViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIScrollView *_scrollView;
    NSArray *_dataArray;//社区数据源
    UITableView *_communityTableView;//社区列表
    UITableView *_tableView1;//2015
    UITableView *_tableView2;//2016
    UIPickerView *_communityPickView;
    NSInteger _noticeNumber;
}
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITextField *communityTF;


@end

@implementation LLWaterRateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"水费清单"];
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
    [_scrollView removeFromSuperview];
    _scrollView = nil;
    //重新请求数据，传人_communityTF.text
    [self creatScrollView];
    
}

- (void)creatScrollView{
    NSArray *titleArray = [NSArray arrayWithObjects:@"2015年",@"2016年", nil];
    YQYPiecewiseView *pieceWiseView = [[YQYPiecewiseView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), kScreenSize.width, 40)];
    pieceWiseView.type = PiecewiseInterfaceTypeMobileLin;
    pieceWiseView.backgroundColor = [UIColor whiteColor];
    pieceWiseView.delegate = self;
    pieceWiseView.textNormalColor = [UIColor blackColor];
    pieceWiseView.textSeletedColor = LLMainColor;
    pieceWiseView.linColor = LLMainColor;
    [pieceWiseView loadTitleArray:titleArray];
    [self.view addSubview:pieceWiseView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pieceWiseView.frame), kScreenSize.width*2, kScreenSize.height-64-40-64)];
    _scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(kScreenSize.width*2, 0);
    [self.view addSubview:_scrollView];
    
    //2015
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, CGRectGetHeight(_scrollView.frame)) style:UITableViewStylePlain];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.tag = 30;
    _tableView1.rowHeight = 100;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView1 registerNib:[UINib nibWithNibName:@"LLWaterOrderListCell" bundle:nil] forCellReuseIdentifier:@"LLWaterOrderListCell"];
    [_scrollView addSubview:_tableView1];
    
    
    //2016
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(kScreenSize.width, 0, kScreenSize.width, CGRectGetHeight(_scrollView.frame)) style:UITableViewStylePlain];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.tag = 31;
    _tableView2.rowHeight = 100;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView2 registerNib:[UINib nibWithNibName:@"LLWaterOrderListCell" bundle:nil] forCellReuseIdentifier:@"LLWaterOrderListCell"];
    [_scrollView addSubview:_tableView2];
    
    
    
    
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



#pragma mark YQYPiecewiseDelegete
- (void)piecewiseView:(YQYPiecewiseView *)piecewiseView index:(NSInteger)index{
    switch (index) {
        case 0:
        {
            [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentOffset = CGPointMake(0, 0);
            }];
            
            NSLog(@"2015");
        }
            break;
        case 1:
        {
            [UIView animateWithDuration:0.5 animations:^{
               _scrollView.contentOffset = CGPointMake(kScreenSize.width, 0);
            }];
            
            NSLog(@"2016");
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"LLWaterOrderListCell";
    LLWaterOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LLWaterOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLWaterPayDetailController"];
    [self.navigationController pushViewController:VC animated:YES];
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
