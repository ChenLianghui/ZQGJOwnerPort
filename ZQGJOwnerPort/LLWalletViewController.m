//
//  LLWalletViewController.m
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLWalletViewController.h"
#import "YQYPiecewiseView.h"
#import "LLChongzhiTableViewCell.h"

@interface LLWalletViewController ()<YQYPiecewiseViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *_scrollView;
    UITableView *_chongzhiTB;
    UITableView *_tixianTB;
}
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *AmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *WithdrawBtn;
@property (weak, nonatomic) IBOutlet UIButton *ChargeBtn;

@end

@implementation LLWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"智取钱包余额"];
    [self headViewInit];
    [self creatScrollView];
    // Do any additional setup after loading the view.
}

- (void)headViewInit{
    _WithdrawBtn.layer.masksToBounds = YES;
    _WithdrawBtn.layer.cornerRadius = 3;
    _ChargeBtn.layer.masksToBounds = YES;
    _ChargeBtn.layer.cornerRadius = 3;
}

- (void)creatScrollView{
    NSArray *titleArray = [NSArray arrayWithObjects:@"充值记录",@"提现记录", nil];
    
    YQYPiecewiseView *pieceWiseView = [[YQYPiecewiseView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), kScreenSize.width, 40)];
    pieceWiseView.type = PiecewiseInterfaceTypeMobileLin;
    pieceWiseView.backgroundColor = [UIColor whiteColor];
    pieceWiseView.delegate = self;
    pieceWiseView.textNormalColor = [UIColor blackColor];
    pieceWiseView.textSeletedColor = LLMainColor;
    pieceWiseView.linColor = LLMainColor;
    [pieceWiseView loadTitleArray:titleArray];
    [self.view addSubview:pieceWiseView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pieceWiseView.frame), kScreenSize.width, kScreenSize.height-CGRectGetMaxY(pieceWiseView.frame))];
    _scrollView.contentSize = CGSizeMake(kScreenSize.width*2, 0);
    //_scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.scrollEnabled = NO;
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, kScreenSize.width-40, 100)];
//    label1.text = @"暂无充值记录";
//    label1.textAlignment = NSTextAlignmentCenter;
//    label1.textColor = LLMainColor;
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20+kScreenSize.width, 50, kScreenSize.width-40, 100)];
//    label2.textColor = LLMainColor;
//    label2.textAlignment = NSTextAlignmentCenter;
//    label2.text = @"暂无提现记录";
//    [_scrollView addSubview:label1];
//    [_scrollView addSubview:label2];
    
    _chongzhiTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, _scrollView.frame.size.height) style:UITableViewStylePlain];
    [_chongzhiTB registerNib:[UINib nibWithNibName:@"LLChongzhiTableViewCell" bundle:nil] forCellReuseIdentifier:@"LLChongzhiTableViewCell"];
    _chongzhiTB.delegate = self;
    _chongzhiTB.dataSource = self;
    _chongzhiTB.rowHeight = 70;
    [_scrollView addSubview:_chongzhiTB];
    
    _tixianTB = [[UITableView alloc] initWithFrame:CGRectMake(kScreenSize.width, 0, kScreenSize.width, _scrollView.frame.size.height) style:UITableViewStylePlain];
    [_tixianTB registerNib:[UINib nibWithNibName:@"LLChongzhiTableViewCell" bundle:nil] forCellReuseIdentifier:@"LLChongzhiTableViewCell"];
    _tixianTB.delegate = self;
    _tixianTB.dataSource = self;
    _tixianTB.rowHeight = 70;
    [_scrollView addSubview:_tixianTB];
    
    [self.view addSubview:_scrollView];
}
//提现
- (IBAction)WithdrawBtnClick:(UIButton *)sender {
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *Withdraw = [Sb instantiateViewControllerWithIdentifier:@"LLWithdrawViewController"];
    [self.navigationController pushViewController:Withdraw animated:YES];
}
- (IBAction)ChargeBtnClick:(id)sender {
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *charge = [Sb instantiateViewControllerWithIdentifier:@"LLChargeViewController"];
    [self.navigationController pushViewController:charge animated:YES];
}

#pragma mark YQYPiecewiseDelegete
- (void)piecewiseView:(YQYPiecewiseView *)piecewiseView index:(NSInteger)index{
    switch (index) {
        case 0:
        {
            [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentOffset = CGPointMake(0, 0);
            }];
        }
            NSLog(@"充值记录");
            break;
         case 1:
        {
            [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentOffset = CGPointMake(kScreenSize.width, 0);
            }];
        }
            
            NSLog(@"提现记录");
            break;
        default:
            break;
    }
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLChongzhiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLChongzhiTableViewCell"];
    if (!cell) {
        cell = [[LLChongzhiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LLChongzhiTableViewCell"];
    }
    return cell;
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
