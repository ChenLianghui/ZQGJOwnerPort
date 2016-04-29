//
//  LLConsumeDetailViewController.m
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLConsumeDetailViewController.h"
#import "LLConsumeTableViewCell.h"

@interface LLConsumeDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIDatePicker *_datePicker;
    NSString *_dateString1;
    NSString *_dateString2;
    NSDate *_startDate;
    NSDate *_endDate;
}
@property (weak, nonatomic) IBOutlet UITextField *startDateTF;
@property (weak, nonatomic) IBOutlet UITextField *endDateTF;

@end

@implementation LLConsumeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithName:@"消费明细"];
    _startDateTF.delegate = self;
    _endDateTF.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)createDatePicker:(UITextField *)TF{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 44)];
    toolbar.barTintColor = LLMainColor;
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(dismissDatePick:)];
    if (TF == _startDateTF) {
        item1.tag = 60;
    }else{
        item1.tag = 61;
    }
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissDatePick:)];
    if (TF == _startDateTF) {
        item2.tag = 62;
    }else{
        item2.tag = 63;
    }
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[item2,flexItem,item1];
    toolbar.tintColor = [UIColor whiteColor];
    TF.inputAccessoryView = toolbar;
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 200)];
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.maximumDate = [NSDate date];
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    TF.inputView = _datePicker;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"LLConsumeTableViewCell";
    LLConsumeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LLConsumeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)dateChanged:(UIDatePicker *)dPicker{
//    NSDate *currentDate = dPicker.date;
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    NSLocale *datelocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
//    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy-MM-dd" options:0 locale:datelocale];
//    formatter.dateFormat = dateFormat;
//    formatter.locale = datelocale;
//    _dateString1 = [NSString stringWithFormat:@"%@",[formatter stringFromDate:currentDate]];
}

- (void)dismissDatePick:(UIBarButtonItem *)item {
    switch (item.tag) {
        case 60:
            //起始日期确定
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            NSLocale *datelocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
            NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy-MM-dd" options:0 locale:datelocale];
            formatter.dateFormat = dateFormat;
            formatter.locale = datelocale;
            _startDate = _datePicker.date;
            
            if ([_startDate compare:_endDate] == NSOrderedDescending) {
                //弹出错误
                NSLog(@"error!");
            }else{
                _startDateTF.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_datePicker.date]];
            }
            [_startDateTF resignFirstResponder];
        }
            break;
        case 61:
            //截止日期确定
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            NSLocale *datelocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
            NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy-MM-dd" options:0 locale:datelocale];
            formatter.dateFormat = dateFormat;
            formatter.locale = datelocale;
            _endDate = _datePicker.date;
            
            if ([_startDate compare:_endDate] == NSOrderedDescending) {
                //弹出错误
                NSLog(@"error2!");
            }else{
                _endDateTF.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_datePicker.date]];
            }
            [_endDateTF resignFirstResponder];
        }
            break;
        case 62:
            //起始日期取消
            [_startDateTF resignFirstResponder];
            break;
        case 63:
            //截止日期取消
            [_endDateTF resignFirstResponder];
            break;
        default:
            break;
    }
}

#pragma mark - UITextFeildDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self createDatePicker:textField];
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
