//
//  HMWaterflowLayout.h
//  瀑布流
//
//  Created by piglikeyoung on 15/6/22.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMWaterflowLayout;

@protocol HMWaterflowLayoutDelegate <NSObject>

/**
 *  告诉代理宽度，让代理计算出图片等比例的高度
 */
- (CGFloat)waterflowLayout:(HMWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;
@end

@interface HMWaterflowLayout : UICollectionViewLayout
/** section的内边距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak) id<HMWaterflowLayoutDelegate> delegate;
@end
