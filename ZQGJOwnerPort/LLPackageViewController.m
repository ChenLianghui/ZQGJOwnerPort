//
//  LLPackageViewController.m
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/6.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLPackageViewController.h"
#import "KSGuideManager.h"
#import "YQYPiecewiseView.h"
#import "LLPackageTableViewCell.h"
#import "SGPopSelectView.h"
#import "LLSendPackageViewController.h"
#import "LLReceivePackageCell.h"
#import "LLApplyForDeliveryController.h"
#import "LLPackageOrderViewController.h"
#import "LLDateView.h"
#import "LLShadeView.h"

@interface LLPackageViewController ()<YQYPiecewiseViewDelegate,UITableViewDelegate,UITableViewDataSource,LLDateDelegate>
{
    LLShadeView *_ShadeView;
    UIScrollView *_scrollView;
    UITableView *_receiveTableView;//送件列表
    UITableView *_sendTableView;//寄件列表
    UITableView *_addressTableView;//地址列表
    NSArray *_receiveArray;//送件数据
    NSArray *_sendArray;//寄件数据
    NSArray *_AddressArray;//地址数据
    UIButton *_disongBtn;
    UIAlertController *_alert;
}
@property (nonatomic, strong) NSArray *selections;
@property (nonatomic, strong) SGPopSelectView *popView;
@property (nonatomic, assign) CGPoint offsite;
@property (nonatomic, copy) NSString *SelectedAddress;
@property (nonatomic, assign)BOOL isUsable;
@property (nonatomic, assign)int state1;//申请寄件状态
@property (nonatomic, assign)int state2;//送件状态,1为选择自取，2为其他
@property (nonatomic, assign)BOOL isZiQuSelected;//自取button是否被选中
@property (nonatomic, assign)int selectedNumber;//单选框被选中的数量
@end

@implementation LLPackageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    _scrollView.contentOffset = _offsite;//防止跳到其他界面后返回，产生异常偏移
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *paths = [NSMutableArray new];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"4" ofType:@"jpg"]];
    [[KSGuideManager shared] showGuideViewWithImages:paths];
    
    [self addTitleViewWithName:@"智取包裹"];
    [self addImageWithName:@"" andTarget:self andAction:nil isLeft:YES];
    _isUsable = NO;
    _selectedNumber = 0;
    [self creatScrollView];
    [self getAddressArray];
    [self createAlertController];
    //[self createPopUpView];
    // Do any additional setup after loading the view.
}

- (void)createAlertController{
    _alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未登录，是否前去登录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIStoryboard * Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *login = [Sb instantiateViewControllerWithIdentifier:@"LLLoginViewController"];
        [self.navigationController pushViewController:login animated:YES];
    }];
    [_alert addAction:cancelAction];
    [_alert addAction:commitAction];
    [self presentViewController:_alert animated:YES completion:nil];
}


- (NSArray *)AddressArray{
    if (_AddressArray) {
        _AddressArray = [[NSArray alloc] init];
    }
    return _AddressArray;
}


- (void)creatScrollView{
    NSArray *titleArray = [NSArray arrayWithObjects:@"送件",@"寄件", nil];
    YQYPiecewiseView *pieceWiseView = [[YQYPiecewiseView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, 40)];
    pieceWiseView.type = PiecewiseInterfaceTypeMobileLin;
    pieceWiseView.backgroundColor = [UIColor whiteColor];
    pieceWiseView.delegate = self;
    pieceWiseView.textNormalColor = [UIColor blackColor];
    pieceWiseView.textSeletedColor = LLMainColor;
    pieceWiseView.linColor = LLMainColor;
    [pieceWiseView loadTitleArray:titleArray];
    [self.view addSubview:pieceWiseView];
    
    //创建dateView
    UIView *dateBGView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pieceWiseView.frame), kScreenSize.width, 50)];
    LLDateView *dateView = [LLDateView instanceView];
    dateView.frame = CGRectMake(0, 0, kScreenSize.width, 50);
    dateView.year = 2016;
    dateView.month = 4;
    dateView.delegate = self;
    [dateBGView addSubview:dateView];
    [self.view addSubview:dateBGView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dateBGView.frame), kScreenSize.width*2, kScreenSize.height-CGRectGetMaxY(dateBGView.frame)-50)];
    _scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(kScreenSize.width*2, 0);
    [self.view addSubview:_scrollView];
    
    //送件部分
    _receiveTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, CGRectGetHeight(_scrollView.frame)-70) style:UITableViewStylePlain];
    _receiveTableView.delegate = self;
    _receiveTableView.dataSource = self;
    _receiveTableView.tag = 30;
    _receiveTableView.rowHeight = 100;
    _receiveTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_receiveTableView registerNib:[UINib nibWithNibName:@"LLReceivePackageCell" bundle:nil] forCellReuseIdentifier:@"LLReceivePackageCell"];
    [_scrollView addSubview:_receiveTableView];
    
    _disongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _disongBtn.frame = CGRectMake(15, CGRectGetMaxY(_receiveTableView.frame)+15, kScreenSize.width-30, 40);
    _disongBtn.tag = 40;
    [_disongBtn setTitle:@"申请递送" forState:UIControlStateNormal];
    _disongBtn.backgroundColor = LLMainColor;
    [_disongBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MyControl addRoundWithView:_disongBtn andRadius:5];
    [_disongBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (!_isUsable) {
        _disongBtn.userInteractionEnabled = NO;
        _disongBtn.backgroundColor = [UIColor grayColor];
    }
    [_scrollView addSubview:_disongBtn];
    
    //寄件部分
    _sendTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenSize.width, 0, kScreenSize.width, CGRectGetHeight(_scrollView.frame)-70) style:UITableViewStylePlain];
    _sendTableView.delegate = self;
    _sendTableView.dataSource = self;
    _sendTableView.tag = 31;
    _sendTableView.rowHeight = 70;
    _sendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_sendTableView registerNib:[UINib nibWithNibName:@"LLPackageTableViewCell" bundle:nil] forCellReuseIdentifier:@"LLPackageTableViewCell"];
    [_scrollView addSubview:_sendTableView];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(15+kScreenSize.width, CGRectGetMaxY(_receiveTableView.frame)+15, kScreenSize.width-30, 40);
    button2.tag = 41;
    [button2 setTitle:@"申请寄件" forState:UIControlStateNormal];
    button2.backgroundColor = LLMainColor;
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MyControl addRoundWithView:button2 andRadius:5];
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button2];
    
    
}

#pragma mark YQYPiecewiseDelegete
- (void)piecewiseView:(YQYPiecewiseView *)piecewiseView index:(NSInteger)index{
    switch (index) {
        case 0:
        {
            [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentOffset = CGPointMake(0, 0);
                _offsite = _scrollView.contentOffset;
            }];
        }
            break;
        case 1:
        {
            [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentOffset = CGPointMake(kScreenSize.width, 0);
                _offsite = _scrollView.contentOffset;
            }];
        }
            
            break;
        default:
            break;
    }
}

//申请按钮点击事件
- (void)buttonClick:(UIButton *)button{
    switch (button.tag) {
        case 40:
        {
           //申请送件
           [self creatSelectViewWithTag:61];
        }
            break;
        case 41:
        {
           //申请寄件
            [self creatSelectViewWithTag:62];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 创建select View

- (void)creatSelectViewWithTag:(NSInteger)tag{
    _ShadeView = [[LLShadeView alloc] initWithFrame:CGRectMake(40, kScreenSize.height/2-150, kScreenSize.width-80, 300)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_ShadeView.selectView.frame), 50)];
    titleLabel.text = @"选择地址";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_ShadeView.selectView addSubview:titleLabel];
    
    _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(_ShadeView.selectView.frame), CGRectGetHeight(_ShadeView.selectView.frame)-CGRectGetHeight(titleLabel.frame)) style:UITableViewStylePlain];
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_addressTableView.frame)-100, CGRectGetWidth(_addressTableView.frame), 100)];
    UIButton *addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addAddressBtn.frame = CGRectMake(CGRectGetWidth(tableFooterView.frame)/2 - 100/2, 5, 100, 30);
    [addAddressBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    [addAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addAddressBtn.backgroundColor = [UIColor orangeColor];
    [MyControl addRoundWithView:addAddressBtn andRadius:5];
    [addAddressBtn addTarget:self action:@selector(addAdress) forControlEvents:UIControlEventTouchUpInside];
    [tableFooterView addSubview:addAddressBtn];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addAddressBtn.frame)+5, CGRectGetWidth(tableFooterView.frame), 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [tableFooterView addSubview:lineView];
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(15, CGRectGetMaxY(lineView.frame)+7, CGRectGetWidth(tableFooterView.frame)-30, 40);
    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MyControl addRoundWithView:commitBtn andRadius:5];
    commitBtn.tag = tag;
    [commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    commitBtn.backgroundColor = LLMainColor;
    [tableFooterView addSubview:commitBtn];
    
    _addressTableView.tableFooterView = tableFooterView;
    _addressTableView.delegate = self;
    _addressTableView.dataSource = self;
    _addressTableView.rowHeight = 50;
    _addressTableView.tag = 32;
    [_ShadeView.selectView addSubview:_addressTableView];
}


#pragma mark - 新增地址

- (void)addAdress{
    [_ShadeView removeFromSuperview];
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLAddressDetailViewController"];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 提交按钮

- (void)commitBtnClick:(UIButton *)button{
    [_ShadeView removeFromSuperview];
    switch (button.tag) {
        case 61:
        {
            //申请递送
            /*
             提交申请状态
             
             */
            UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LLApplyForDeliveryController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLApplyForDeliveryController"];
            VC.addressStr = _SelectedAddress;
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }
            break;
        case 62:
        {
            //申请寄件
            UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LLSendPackageViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLSendPackageViewController"];
            VC.addressStr = _SelectedAddress;
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - 获取地址源
- (void)getAddressArray{
    _AddressArray = @[@"白金海岸-1-1-103",@"同人广场-1-1-103",@"名城燕园-1-1-103",@"同人春江时代-1-1-103"];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 30:
            //送件
            return 4;
            break;
        case 31:
            //寄件
            return 5;
            break;
        case 32:
            //地址列表
            return _AddressArray.count;
            break;
        default:
            return 1;
            break;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 30:
            //送件
        {
            LLReceivePackageCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"LLReceivePackageCell" owner:nil options:nil] lastObject];
            self.state1 = 1;
            if (self.state1 == 1) {
                //选择自取
                cell.ziquBtn.hidden = NO;
                cell.ziquBtn.tag = indexPath.row;
                //                [cell.ziquBtn setImage:[UIImage imageNamed:@"hollow_pressed"] forState:UIControlStateSelected];
                [cell.ziquBtn setImage:[UIImage imageNamed:@"hollow"] forState:UIControlStateNormal];
                [cell.ziquBtn addTarget:self action:@selector(ziquBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                _isZiQuSelected = NO;
                
            }else{
                cell.ziquBtn.hidden = YES;
            }
            return cell;
        }
            break;
        case 31:
            //寄件
        {
            LLPackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLPackageTableViewCell"];
            if (!cell) {
                cell = [[LLPackageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LLPackageTableViewCell"];
                
            }
            return cell;
        }
            break;
        case 32:
            //地址列表
        {
            static NSString *cellId = @"cellId";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            cell.textLabel.text = _AddressArray[indexPath.row];
            cell.textLabel.textColor = [UIColor grayColor];
            cell.imageView.image = [UIImage imageNamed:@"hollow"];
            
            UIView *view = [[UIView alloc] initWithFrame:cell.bounds];
            view.backgroundColor = LLColorMaker(0, 0, 0, 0.05);
            cell.selectedBackgroundView = view;
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 30:
        {
            //送件列表
            /*
             已完成状态
             
             */
//            UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLPackageDetailController"];
//            [self.navigationController pushViewController:VC animated:YES];
            /*
             签收状态
             
             */
            UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLSignInController"];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case 31:
        {
            //寄件列表
            UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LLPackageOrderViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLPackageOrderViewController"];
            VC.state = 4;//3为支付揽件，4为包裹到物业，5为快递接收揽件
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 32:
        {
            //地址列表
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.textColor = [UIColor orangeColor];
            cell.imageView.image = [UIImage imageNamed:@"hollow_pressed"];
            _SelectedAddress = _AddressArray[indexPath.row];
        }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 30:
        {
            
        }
            break;
        case 31:
        {
            
        }
            break;
        case 32:
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.textColor = [UIColor grayColor];
            cell.imageView.image = [UIImage imageNamed:@"hollow"];
        }
            break;
        default:
            break;
    }
}


#pragma mark - ziquBtnClick

- (void)ziquBtnClick:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        _selectedNumber++;
        [button setImage:[UIImage imageNamed:@"hollow_pressed"] forState:UIControlStateNormal];
    }else{
        _selectedNumber--;
        [button setImage:[UIImage imageNamed:@"hollow"] forState:UIControlStateNormal];
    }
    if (_selectedNumber == 0) {
        _disongBtn.userInteractionEnabled = NO;
        _disongBtn.backgroundColor = [UIColor grayColor];
    }else{
        _disongBtn.userInteractionEnabled = YES;
        _disongBtn.backgroundColor = LLMainColor;
    }
}


#pragma mark - LLDateDelegate

- (void)dateDidChanged{
    //此处重新请求数据，刷新数据源
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
