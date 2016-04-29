//
//  LLPackageTableViewCell.h
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLPackageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *StateLabel;

@end
