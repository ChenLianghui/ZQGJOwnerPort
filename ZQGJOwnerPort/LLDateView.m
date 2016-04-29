//
//  LLDateView.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/19.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLDateView.h"
#import "LLShadeView.h"

@interface LLDateView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    LLShadeView *_shadeView;
}
@end

@implementation LLDateView


+ (LLDateView *)instanceView{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"LLDateView" owner:nil options:nil];
    return nibViews.firstObject;
}

- (IBAction)leftBtnClick:(UIButton *)sender {
    _month--;
    if (_month == 0) {
        _month = 12;
        _year--;
    }
    [self update];
}
- (IBAction)centerBtnClick:(UIButton *)sender {
    _shadeView = [[LLShadeView alloc] initWithFrame:CGRectMake(40, kScreenSize.height/2-150, kScreenSize.width-80, 200)];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:_shadeView];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_shadeView.selectView.frame), 50)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:headView.bounds];
    titleLabel.text = @"请选择年份";
    titleLabel.backgroundColor = LLGrayBackgroundColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
    [_shadeView.selectView addSubview:headView];

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), CGRectGetWidth(_shadeView.selectView.frame), 150) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 50;
    [_shadeView.selectView addSubview:_tableView];
    
    _dataArray = [NSArray arrayWithObjects:@"2015",@"2016",@"2017", nil];
}
- (IBAction)rightBtnClick:(UIButton *)sender {
    _month++;
    if (_month == 13) {
        _month = 1;
        _year++;
    }
    [self update];
}

- (void)update{
    [_centerBtn setTitle:[NSString stringWithFormat:@"%d-%d",_year,_month] forState:UIControlStateNormal];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dateDidChanged)]) {
        [self.delegate dateDidChanged];
    }
}

#pragma mark - UITableView

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
    _year = [_dataArray[indexPath.row] intValue];
    [self update];
    [_shadeView removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
