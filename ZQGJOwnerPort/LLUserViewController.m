//
//  LLUserViewController.m
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/6.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLUserViewController.h"
#import "LLUserTableViewCell.h"
#import "LLAddressInfoViewController.h"

@interface LLUserViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataArray;
}
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIView *HeadView;
@property (weak, nonatomic) IBOutlet UITableView *UserTableView;

@end

@implementation LLUserViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageWithName:@"" andTarget:self andAction:nil isLeft:YES];
    [self addTitleViewWithName:@"个人中心"];
    [self initDataSource];
    [self initHeadView];
    // Do any additional setup after loading the view.
}


- (void)initDataSource {
//    _dataArray1 = [NSArray arrayWithObjects:@"基本信息",@"地址信息",@"零钱包",@"消费明细", nil];
//    _dataArray2 = [NSArray arrayWithObjects:@"关于我们",@"设置", nil];
    _dataArray = [NSArray arrayWithObjects:@"基本信息",@"地址信息",@"零钱包",@"消费明细",@"关于我们",@"设置", nil];
}

- (void)initHeadView {
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = 3;
}

#pragma mark - UITableViewDelegate

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return _dataArray.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleIdentify = @"LLUserTableViewCell";
    LLUserTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentify];
    if (Cell == nil) {
        Cell = [[LLUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleIdentify];
    }
    Cell.cellTitle.text = [_dataArray objectAtIndex:indexPath.row];
    return Cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLUserInfoViewController"];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 1:
        {
            LLAddressInfoViewController *address = [[LLAddressInfoViewController alloc] init];
            address.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:address animated:YES];
        }
            break;
        case 2:
        {
            UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLWalletViewController"];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 3:
        {
            UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLConsumeDetailViewController"];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        
        default:
            break;
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
