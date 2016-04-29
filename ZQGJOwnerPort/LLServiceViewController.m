//
//  LLServiceViewController.m
//  ZQGJOwnerPort
//
//  Created by Administrator on 16/4/6.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LLServiceViewController.h"
#import "LLServiceCollectionViewCell.h"

@interface LLServiceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *_dataArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;

@end

@implementation LLServiceViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageWithName:@"" andTarget:self andAction:nil isLeft:YES];
    [self addTitleViewWithName:@"智取服务"];
    //_dataArray = @[@"公告栏",@"水费",@"物业费",@"桶装水",@"联系我们"];
    _dataArray = [[NSArray alloc] initWithObjects:@"公告栏",@"水费",@"物业费",@"桶装水",@"联系我们", nil];
    _CollectionView.delegate = self;
    _CollectionView.dataSource = self;
    // Do any additional setup after loading the view.
}

//- (NSArray *)dataArray {
//    if (!_dataArray) {
//        _dataArray = [[NSArray alloc] init];
//    }
//    return _dataArray;
//}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"LLServiceCollectionViewCell";
    LLServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.CellImage.layer.masksToBounds = YES;
    cell.CellImage.layer.cornerRadius = CGRectGetWidth(cell.CellImage.frame)/2.0;
    cell.CellTitle.text = _dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLNoticeBoardViewController"];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 1:{
            UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLWaterRateListViewController"];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 2:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该服务暂未开通，敬请期待！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 3:
        {
            UIStoryboard *Sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *VC = [Sb instantiateViewControllerWithIdentifier:@"LLWaterListViewController"];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 4:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该服务暂未开通，敬请期待！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        default:
            break;
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
