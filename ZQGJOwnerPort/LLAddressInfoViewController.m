//
//  LLAddressInfoViewController.m
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLAddressInfoViewController.h"
#import "LLAddressInfoTableViewCell.h"

@interface LLAddressInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation LLAddressInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"地址信息"];
    [self creatTableView];
    // Do any additional setup after loading the view.
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

// 创建tableview
- (void)creatTableView{
    //CGFloat tableHeigth = (CGFloat)(_dataArray.count*100 + 100);
    CGFloat tableHeigth = 600;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
    [_tableView registerNib:[UINib nibWithNibName:@"LLAddressInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"LLAddressInfoTableViewCell"];
    [self.view addSubview:_tableView];
    [self creatFooterView];
}

- (void)creatFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 80)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, 30, kScreenSize.width-80, 40);
    [button setTitle:@"新增" forState:UIControlStateNormal];
    button.backgroundColor = LLMainColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    //[self.view addSubview:footerView];
    _tableView.tableFooterView = footerView;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return _dataArray.count;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLAddressInfoTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"LLAddressInfoTableViewCell"];
    if (!cell) {
        cell = [[LLAddressInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LLAddressInfoTableViewCell"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *detail = [Sb instantiateViewControllerWithIdentifier:@"LLAddressDetailViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)addBtnClick:(UIButton *)btn{
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *detail = [Sb instantiateViewControllerWithIdentifier:@"LLAddressDetailViewController"];
    [self.navigationController pushViewController:detail animated:YES];
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
