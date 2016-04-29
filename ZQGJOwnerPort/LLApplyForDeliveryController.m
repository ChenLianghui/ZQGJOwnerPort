//
//  LLApplyForDeliveryController.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/15.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLApplyForDeliveryController.h"
#import "LiuXSlider.h"
#import "LLStateView.h"

@interface LLApplyForDeliveryController ()<UITextFieldDelegate>
{
    NSArray *_dayArray;
    NSArray *_timeArray;
    UIView *_timeSliderView;
    UIButton *_SelectedBtn;
}
@property (weak, nonatomic) IBOutlet UIScrollView *MainScrollView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber1;//智取单号
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;//快递名称
@property (weak, nonatomic) IBOutlet UILabel *orderNumber2;//快递单号
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *noDudyLabel;
@property (weak, nonatomic) IBOutlet UIView *view2;//展示选择递送时间以下部分

@property (weak, nonatomic) IBOutlet UIView *daySliderView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UITextField *NumberTF;
@property (weak, nonatomic) IBOutlet UITextField *NameTF;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel2;
@property (weak, nonatomic) IBOutlet UIButton *walletBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UIImageView *walletImage;
@property (weak, nonatomic) IBOutlet UIImageView *wechatImage;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *RedEnvelopeLabel;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
//@property (nonatomic, assign)BOOL isOnDuty;
@property (nonatomic,copy) NSString *selectedDay;
@property (nonatomic,copy) NSString *selectedTime;
@property (nonatomic,assign) int state;//订单状态，0为申请，1为递送，2为待付，3为已支付，4为完成
@property (weak, nonatomic) IBOutlet UIView *pointView;

@end

@implementation LLApplyForDeliveryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"申请递送"];
//    _MainScrollView.frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
    _MainScrollView.contentSize = CGSizeMake(kScreenSize.width, 750);
    [self creatDaySlider];
    self.state = 1;
    [self initPointView];
    _NameTF.delegate = self;
    _NumberTF.delegate = self;
    [MyControl addRoundWithView:_cancelBtn andRadius:5];
    [MyControl addRoundWithView:_payBtn andRadius:5];
    // Do any additional setup after loading the view.
}

- (void)initPointView{
    LLStateView *stateView = [LLStateView instanceView];
    stateView.condition = 1;
    [stateView changeStateWithState:self.state];
    [self.pointView addSubview:stateView];
}

- (IBAction)walletBtnClick:(UIButton *)sender {
    _SelectedBtn = sender;
    _walletImage.image = [UIImage imageNamed:@"hollow_pressed"];
    _wechatImage.image = [UIImage imageNamed:@"hollow"];
}
- (IBAction)wechatBtnClick:(UIButton *)sender {
    _SelectedBtn = sender;
    _wechatImage.image = [UIImage imageNamed:@"hollow_pressed"];
    _walletImage.image = [UIImage imageNamed:@"hollow"];
}
- (IBAction)cancelBtnClick:(UIButton *)sender {
}
- (IBAction)payBtnClick:(UIButton *)sender {
    if ([_timeLabel.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择递送时间" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *commit = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:commit];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
// 创建天数Slider
- (void)creatDaySlider{
    _dayArray = [NSArray arrayWithObjects:@"今天",@"明天",@"后天", nil];
    LiuXSlider *slider=[[LiuXSlider alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width-15-15, 40) titles:_dayArray firstAndLastTitles:@[_dayArray.firstObject,_dayArray.lastObject] defaultIndex:0 sliderImage:[UIImage imageNamed:@"日历"]];
    [_daySliderView addSubview:slider];
    _selectedDay = @"今天";
    if ([self ifOnDuty:_selectedDay]) {
        _noDudyLabel.hidden = YES;
        [self creatTimeSliderView];
    }else{
        _noDudyLabel.hidden = NO;
    }
    slider.block=^(int index){
        _timeLabel.text = @"";
        [_timeSliderView removeFromSuperview];
        _timeSliderView = nil;
        _selectedDay = _dayArray[index];
        if ([self ifOnDuty:_selectedDay]) {
            _noDudyLabel.hidden = YES;
            [self creatTimeSliderView];
        }else{
            _noDudyLabel.hidden = NO;
        }
    };

}

// 是否展示ondutyLabel



// 判断是否有当值保安
- (BOOL)ifOnDuty:(NSString *)day{
    if ([_selectedDay isEqualToString:@"明天"]) {
        return NO;
    }else{
        return YES;
    }
}

// 创建时间Slider
- (void)creatTimeSliderView{
    _timeSliderView = [[UIView alloc] initWithFrame:CGRectMake(15, 120, kScreenSize.width-15-15, 40)];
    [_view2 addSubview:_timeSliderView];
    _timeArray = [NSArray arrayWithObjects:@"8:00",@"9:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00", nil];
    LiuXSlider *slider=[[LiuXSlider alloc] initWithFrame:_timeSliderView.bounds titles:_timeArray firstAndLastTitles:@[_timeArray.firstObject,_timeArray.lastObject] defaultIndex:0 sliderImage:[UIImage imageNamed:@"日历"]];
    [_timeSliderView addSubview:slider];
    _timeLabel.text = [NSString stringWithFormat:@"%@%@",_selectedDay,_timeArray.firstObject];
    slider.block=^(int index){
        _selectedTime = _timeArray[index];
        _timeLabel.text = [NSString stringWithFormat:@"%@%@",_selectedDay,_selectedTime];
        //[_timeLabel sizeToFit];
    };
}



//隐藏键盘
//为什么这里不起作用？
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
