//
//  LLBaseViewController.h
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/6.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLBaseViewController : UIViewController
- (void)addTitleViewWithName:(NSString *)name;
- (void)addItemWithName:(NSString *)name Target:(id)target Action:(SEL)action IsLeft:(BOOL)isleft;
- (void)addImageWithName:(NSString *)name andTarget:(id)target andAction:(SEL)action isLeft:(BOOL)isleft;
@end
