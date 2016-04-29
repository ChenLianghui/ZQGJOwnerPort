//
//  LLPackageOrderViewController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/12.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLPackageOrderViewController.h"
#import "LLStateView.h"

@interface LLPackageOrderViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *MainScrollView;
@property (weak, nonatomic) IBOutlet UILabel *OrderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ToAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *receiveNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet UILabel *kuaidiLabel;
@property (weak, nonatomic) IBOutlet UILabel *kuaidiNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *kuaidiPhonelabel;
@property (weak, nonatomic) IBOutlet UIView *line5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2Heigth;


@end

@implementation LLPackageOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_state) {
        [self addPointViewWithState:_state];
        if (_state == 3) {
            [self addTitleViewWithName:@"确认揽件"];
            _cancelBtn.hidden = NO;
            [MyControl addRoundWithView:_cancelBtn andRadius:5];
            _viewHeight.constant = 188.0;
            //_MainScrollView.contentSize = CGSizeMake(kScreenSize.width, 666);
        }else{
            [self addTitleViewWithName:@"完成揽件"];
            _cancelBtn.hidden = YES;
            if (_state == 4) {
                _viewHeight.constant = 188.0;
                _view2Heigth.constant = 340;
                //_MainScrollView.contentSize = CGSizeMake(kScreenSize.width, 630);
            }else{
                _viewHeight.constant = 240;
                _kuaidiLabel.hidden = NO;
                _kuaidiNameLabel.hidden = NO;
                _kuaidiPhonelabel.hidden = NO;
                _line5.hidden = NO;
                //_MainScrollView.contentSize = CGSizeMake(kScreenSize.width, 648);
            }
        }
    }
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    switch (_state) {
//        case 3:
//            _MainScrollView.contentSize = CGSizeMake(kScreenSize.width, 666);
//            break;
//        case 4:
//            _MainScrollView.contentSize = CGSizeMake(kScreenSize.width, 630);
//            break;
//        case 5:
//            _MainScrollView.contentSize = CGSizeMake(kScreenSize.width, 648);
//            break;
//        default:
//            break;
//    }
//}

- (void)addPointViewWithState:(int)state{
    LLStateView *stateView = [LLStateView instanceView];
    stateView.condition = 2;
    [stateView changeStateWithState:state];
    [_pointView addSubview:stateView];
}

- (IBAction)receivePhoneBtn:(UIButton *)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:sender.titleLabel.text]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sender.titleLabel.text]];
    }
    
}
- (IBAction)cancelBtnClick:(UIButton *)sender {
    
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
