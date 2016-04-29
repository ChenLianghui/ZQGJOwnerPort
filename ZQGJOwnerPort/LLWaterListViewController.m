//
//  LLWaterListViewController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLWaterListViewController.h"
#import "LLWaterListCell.h"

@interface LLWaterListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *ApplyBtn;

@end

@implementation LLWaterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"送水信息"];
    _ApplyBtn.layer.masksToBounds = YES;
    _ApplyBtn.layer.cornerRadius = 5;
    // Do any additional setup after loading the view.
}

#pragma mark - UITableView DateSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellId = @"LLWaterListCell";
    LLWaterListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[LLWaterListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLWaterOrderViewController"];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)ApplyBtnClick:(UIButton *)sender {
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *buy = [Sb instantiateViewControllerWithIdentifier:@"LLBarrelledWaterViewController"];
    buy.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:buy animated:YES];
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
