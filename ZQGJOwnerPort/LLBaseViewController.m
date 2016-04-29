//
//  LLBaseViewController.m
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/6.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLBaseViewController.h"

@interface LLBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation LLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LLGrayBackgroundColor;
    [self addImageWithName:@"back" andTarget:self andAction:@selector(back) isLeft:YES];
    
    //[self addGestureRecognizerBack];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.barTintColor = LLMainColor;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
//添加navigationTitle

- (void)addTitleViewWithName:(NSString *)name {
    UILabel *titleLabel = [MyControl creatLabelWithFrame:CGRectMake(0, 0, 150, 30) text:name textColor:[UIColor whiteColor] bgcolor:[UIColor clearColor] font:17.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}

//添加文字按钮
- (void)addItemWithName:(NSString *)name Target:(id)target Action:(SEL)action IsLeft:(BOOL)isleft {
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 30, 30) target:target selector:action tag:0 image:nil title:name];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    button.tintColor = [UIColor blackColor];
    if (isleft) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
}


//添加图片按钮
- (void)addImageWithName:(NSString *)name andTarget:(id)target andAction:(SEL)action isLeft:(BOOL)isleft {
    if (name) {
        CGRect frame;
        if (isleft) {
            frame = CGRectMake(-20, 0, 60, 40);
        }else{
            frame = CGRectMake(20, 0, 60, 40);
        }
        UIButton *button = [MyControl creatButtonWithFrame:frame target:target selector:action tag:0 image:name title:nil];
        UIView *buttonView = [[UIView alloc] initWithFrame:button.bounds];
        [buttonView addSubview:button];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
        if (isleft) {
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
            self.navigationItem.leftBarButtonItem = item;
        }else{
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
            self.navigationItem.rightBarButtonItem = item;
        }
    }
}

//添加滑动返回手势
- (void)addGestureRecognizerBack{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [self.view addGestureRecognizer:swipe];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //代理设置成nil，否则会闪退
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //只在二级页面生效
        if ([self.navigationController.viewControllers count]==2) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
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
