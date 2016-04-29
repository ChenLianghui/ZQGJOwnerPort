//
//  LLWaterPayDetailController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/14.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLWaterPayDetailController.h"

@interface LLWaterPayDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *balanceMountLabel;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UILabel *UsedMountLabel;
@property (weak, nonatomic) IBOutlet UILabel *PayMountLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *hadPayedLabel;
@property (weak, nonatomic) IBOutlet UIView *noPayedView;
@property (weak, nonatomic) IBOutlet UIButton *walletBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UIButton *noPayBtn;
@property (nonatomic,assign) BOOL havePayed;

@end

@implementation LLWaterPayDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"水费支付"];
    self.view.backgroundColor = LLColorMaker(250, 250, 250, 1.0);
    [self addRound];
    _havePayed = NO;
    if (_havePayed) {
        _noPayedView.hidden = YES;
    }else{
        _hadPayedLabel.hidden = YES;
    }
    // Do any additional setup after loading the view.
}

- (void)addRound{
    [MyControl addRoundWithView:_detailView andRadius:5];
    [MyControl addRoundWithView:_walletBtn andRadius:5];
    [MyControl addRoundWithView:_wechatBtn andRadius:5];
    [MyControl addRoundWithView:_noPayBtn andRadius:5];
}

- (IBAction)walletBtnClick:(UIButton *)sender {
}
- (IBAction)wechatBtnClick:(UIButton *)sender {
}
- (IBAction)noPayBtnClick:(UIButton *)sender {
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
