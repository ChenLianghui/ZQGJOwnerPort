//
//  LLBarrelledWaterViewController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLBarrelledWaterViewController.h"
#import "LLShadeView.h"

@interface LLBarrelledWaterViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_typeArray;
    UIView *_lineView;
    CGFloat _BtnWidth;
    float _price;
    UITableView *_addressTableView;
    NSArray *_dataArray;
    LLShadeView *_shadeView;
    UIView *_ADView;//优惠广告视图
    UIView *_ADView2;
}
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UIButton *BuyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BuyBtnTop;
@property (weak, nonatomic) IBOutlet UIScrollView *MainScrollView;

@end

@implementation LLBarrelledWaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"桶装水购买"];
    [self selectViewInit];
    //_MainScrollView.contentSize = CGSizeMake(0, 700);
    _MainScrollView.alwaysBounceVertical = YES;
    _BuyBtn.layer.masksToBounds = NO;
    _BuyBtn.layer.cornerRadius = 5;
    _lineView = [[UIView alloc] init];
    _amountTF.delegate = self;
    _moneyTF.delegate = self;
    _selectView.userInteractionEnabled = NO;
    // Do any additional setup after loading the view.
}


- (void)selectViewInit {
    _typeArray = [NSArray arrayWithObjects:@"哇哈哈纯净水",@"哇哈哈矿物质水",@"农夫山泉",@"水桶押金", nil];
    for (int i = 0; i < _typeArray.count; i++) {
        _BtnWidth = kScreenSize.width/_typeArray.count;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(_BtnWidth*i, 10, _BtnWidth, 60);
        button.tag = 50 + i;
        [button setTitle:_typeArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor orangeColor];
        [button addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_selectView addSubview:button];
    }
}

- (void)typeBtnClick:(UIButton *)button {
    long j = button.tag - 50;
    [UIView animateWithDuration:0.01 animations:^{
        _lineView.frame = CGRectMake(_BtnWidth*j, CGRectGetMaxY(button.frame), _BtnWidth, 3);
    } completion:nil];
    _lineView.backgroundColor = LLMainColor;
    [_selectView addSubview:_lineView];
    
    switch (button.tag) {
        case 50:
        {
            //哇哈哈纯净水
            _price = 12.00;
        }
            break;
        case 51:
        {
            //哇哈哈矿物质水
            _price = 14.00;
        }
            break;
        case 52:
        {
            //农夫山泉
            _price = 18.00;
        }
            break;
        case 53:
        {
            //水桶押金
            _price = 40.00;
        }
            break;
            
        default:
            break;
    }
    if (button.tag != 53) {
        if (!_ADView2) {
            _ADView2 = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_ADView.frame)+10, kScreenSize.width-40, 20)];
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_ADView2.frame), 20)];
            textLabel.text = @"下单总计返现2.00元";
            [_ADView2 addSubview:textLabel];
            [_MainScrollView addSubview:_ADView2];
        }
        _BuyBtnTop.constant = 20 + CGRectGetHeight(_ADView2.frame) + CGRectGetHeight(_ADView.frame);
    }else{
        [_ADView2 removeFromSuperview];
        _ADView2 = nil;
        _BuyBtnTop.constant = 20 + CGRectGetHeight(_ADView.frame);
    }
    _amountTF.text = @"1";
    _moneyTF.text = [NSString stringWithFormat:@"%.2f",_price];
}

- (IBAction)BuyBtnClick:(UIButton *)sender {
    UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLWaterOrderViewController"];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}



#pragma mark - UITextFeildDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //NSUInteger lengthOfString = string.length;
    NSUInteger proposedNewLength = textField.text.length-range.length+string.length;
    if (proposedNewLength > 2) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    float count = [textField.text floatValue];
    float money = _price*count;
    _moneyTF.text = [NSString stringWithFormat:@"%.2f",money];
    return YES;
}

- (IBAction)addressBtnClick:(UIButton *)sender {
    _shadeView = [[LLShadeView alloc] initWithFrame:CGRectMake(40, kScreenSize.height/2-200/2, kScreenSize.width-80, 200)];
    
    _dataArray = [NSArray arrayWithObjects:@"名城燕园-1-103",@"名城燕园-2-103",@"名城燕园-3-103", nil];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_shadeView.selectView.frame), 50)];
    titleLabel.text = @"选择地址";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = LLGrayBackgroundColor;
    _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth(titleLabel.frame), 150) style:UITableViewStylePlain];
    _addressTableView.delegate = self;
    _addressTableView.dataSource = self;
    _addressTableView.rowHeight = 50;
    [_shadeView.selectView addSubview:titleLabel];
    [_shadeView.selectView addSubview:_addressTableView];
}

#pragma mark - UItableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectView.userInteractionEnabled = YES;
    [_addressBtn setTitle:_dataArray[indexPath.row] forState:UIControlStateNormal];
    [_shadeView removeFromSuperview];
    
    //添加ADView
    _ADView = [[UIView alloc] initWithFrame:CGRectMake(0, 450, kScreenSize.width, 50)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
    titleLabel.text = @"节日优惠";
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, kScreenSize.width, 20)];
    detailLabel.text = @"立即下单，单桶水即时返现2元";
    [_ADView addSubview:titleLabel];
    [_ADView addSubview:detailLabel];
    [_MainScrollView addSubview:_ADView];
    _BuyBtnTop.constant = 20 + CGRectGetHeight(_ADView.frame);
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
