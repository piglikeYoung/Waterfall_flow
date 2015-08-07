//
//  HMShopCell.m
//  瀑布流
//
//  Created by piglikeyoung on 15/6/22.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "HMShopCell.h"
#import "HMShop.h"
#import "UIImageView+WebCache.h"

@interface HMShopCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation HMShopCell

- (void)setShop:(HMShop *)shop {
    _shop = shop;
    
    // 1.图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 2.价格
    self.priceLabel.text = shop.price;
}

@end
