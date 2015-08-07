//
//  ViewController.m
//  瀑布流
//
//  Created by piglikeyoung on 15/6/22.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "ViewController.h"
#import "HMWaterflowLayout.h"
#import "MJExtension.h"
#import "HMShop.h"
#import "HMShopCell.h"
#import "MJRefresh.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, HMWaterflowLayoutDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;
@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (_shops == nil) {
        self.shops = [NSMutableArray array];
    }
    return _shops;
}

static NSString *const ID = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化数据
    NSArray *shopArray = [HMShop objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:shopArray];
    
    HMWaterflowLayout *layout = [[HMWaterflowLayout alloc] init];
    layout.columnsCount = 2; // 2列
    layout.rowMargin = 10; // 行间距10
    layout.columnMargin = 10; // 列间距10
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);// section内边距
    layout.delegate = self;
    
    // 2.创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"HMShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 3.增加刷新控件
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadMoreShops];
    }];
}

- (void)loadMoreShops {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shopArray = [HMShop objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shopArray];
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];
    });
}

#pragma mark - <HMWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(HMWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    HMShop *shop = self.shops[indexPath.item];
    // 返回等比例的高度
    return shop.h / shop.w * width;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}



@end
