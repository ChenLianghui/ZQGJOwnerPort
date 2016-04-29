//
//  LLSignInController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/18.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLSignInController.h"
#import "LLShadeView.h"
#import "LLScoreView.h"
#import "TQStarRatingView.h"
#import "LLStateView.h"

@interface LLSignInController ()<UITextFieldDelegate,StarRatingViewDelegate>
{
    LLShadeView *_shadeView;
    LLScoreView *_scoreView;
    TQStarRatingView *_starView;
}
@property (weak, nonatomic) IBOutlet UIScrollView *MainScrollView;
@property (weak, nonatomic) IBOutlet UILabel *localOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (nonatomic,assign) int state;//订单状态，1为申请，2为待付，3为已支付，4为递送，5为完成

@end

@implementation LLSignInController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.state = 4;
    [MyControl addRoundWithView:_commitBtn andRadius:5];
    [self addTitleViewWithName:@"签收"];
    [self initPointView];
    // Do any additional setup after loading the view.
}

- (void)initPointView{
    LLStateView *stateView = [LLStateView instanceView];
    stateView.condition = 1;
    [stateView changeStateWithState:self.state];
    [self.pointView addSubview:stateView];
}


- (IBAction)phoneBtnClick:(UIButton *)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:sender.titleLabel.text]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sender.titleLabel.text]];
    }
}
- (IBAction)commitBtnClick:(UIButton *)sender {
    _shadeView = [[LLShadeView alloc] initWithFrame:CGRectMake(20, kScreenSize.height/2-350/2, kScreenSize.width-40, 350)];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:_shadeView];
    [MyControl addRoundWithView:_shadeView.selectView andRadius:10];
    _scoreView = [LLScoreView instanceView];
    _scoreView.frame = CGRectMake(0, 0, CGRectGetWidth(_shadeView.selectView.frame), CGRectGetHeight(_shadeView.selectView.frame));
    _scoreView.fuyanTF.delegate = self;
    [MyControl addRoundWithView:_scoreView.commitBtn andRadius:kNUMBER_OF_STAR];
    [_scoreView.commitBtn addTarget:self action:@selector(tijiaoClick) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_scoreView addGestureRecognizer:tap];
    _starView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)numberOfStar:5];
    _starView.delegate = self;
    [_starView setScore:0 withAnimation:NO];
    [_scoreView.starView addSubview:_starView];
    [_shadeView.selectView addSubview:_scoreView];
}
- (void)tap{
    [_scoreView.fuyanTF resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        _shadeView.selectView.frame = CGRectMake(20, kScreenSize.height/2-350/2, kScreenSize.width-40, 350);
    } completion:nil];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:_starView];
//    
//}

- (void)tijiaoClick{
    [_shadeView removeFromSuperview];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.5 animations:^{
        _shadeView.selectView.frame = CGRectMake(20, kScreenSize.height/2-350/2-100, kScreenSize.width - 40, 350);
    } completion:nil];
    
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score{
    _scoreView.scoreLabel.text = [NSString stringWithFormat:@"%0.0f分",score * 5 ];

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
