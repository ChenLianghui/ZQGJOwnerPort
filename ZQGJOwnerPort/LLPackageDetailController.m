//
//  LLPackageDetailController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/14.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLPackageDetailController.h"
#import "TQStarRatingView.h"
#import "LLStateView.h"

@interface LLPackageDetailController ()
@property (weak, nonatomic) IBOutlet UIView *MainView2;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;//到达物业时间
@property (weak, nonatomic) IBOutlet UILabel *commanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel1;//快递单号
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel2;//本地单号
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel2;//到达业主时间
@property (weak, nonatomic) IBOutlet UILabel *CourierLabel;
@property (weak, nonatomic) IBOutlet UIButton *CourierNumbelBtn;
@property (weak, nonatomic) IBOutlet UILabel *PSLabel;
@property (weak, nonatomic) IBOutlet UIView *starView;

@property (weak, nonatomic) IBOutlet UIView *pointView;

@property (nonatomic,assign) BOOL hasZiQu;

@end

@implementation LLPackageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"包裹详情"];
    if (self.hasZiQu) {
        //自取界面
        _MainView2.hidden = YES;
        [self ZiquViewInit];
    }else{
        //已完成界面
        self.state = 5;
        [self initPointView];
        [self createStarView];
    }
    // Do any additional setup after loading the view.
}

- (void)ZiquViewInit{
    UIView *ziquView = [[UIView alloc] initWithFrame:CGRectMake(0, 176, kScreenSize.width, kScreenSize.height-176)];
    [self.view addSubview:ziquView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 80, 28)];
    titleLabel.text = @"取件时间";
    [ziquView addSubview:titleLabel];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 28)];
    timeLabel.text = @"2016-04-11  19:42";
    [ziquView addSubview:timeLabel];
    UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width/2-50/2, kScreenSize.height-50, 50, 50)];
    stateLabel.text = @"已自取";
    [ziquView addSubview:stateLabel];
}

- (void)initPointView{
    LLStateView *stateView = [LLStateView instanceView];
    stateView.condition = 1;
    [stateView changeStateWithState:self.state];
    [self.pointView addSubview:stateView];
}

- (void)createStarView{
    TQStarRatingView *starView = [[TQStarRatingView alloc] initWithFrame:self.starView.bounds numberOfStar:5];
    [starView setScore:4 withAnimation:NO];
    [self.starView addSubview:starView];
}


#pragma mark - 拨打快递员电话
- (IBAction)CourierNumberBtnClick:(UIButton *)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:sender.titleLabel.text]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sender.titleLabel.text]];
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
