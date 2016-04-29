//
//  LLReceivePackageCell.m
//  ZQGJOwnerPort
//
//  Created by 陈良辉 on 16/4/14.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLReceivePackageCell.h"

@implementation LLReceivePackageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailLabel.adjustsFontSizeToFitWidth = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
