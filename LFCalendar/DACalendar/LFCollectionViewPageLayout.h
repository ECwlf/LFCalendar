//
//  LFCollectionViewPageLayout.h
//  DAalendar
//
//  Created by linfeng wang on 2019/6/28.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 从左到右的 FlowLayout
 例:pages = 2， lines = 2， lineInteritems = 3 的布局如下
 -------------------------
 | 1 2 3 | 7  8  9   |
 | 4 5 6 | 10 11 12  |
 ------------------------
 */

NS_ASSUME_NONNULL_BEGIN

@interface LFCollectionViewPageLayout : UICollectionViewFlowLayout

/**
 页数
 */
@property (nonatomic, assign) NSInteger pages;

/**
 行数
 */
@property (nonatomic, assign) NSInteger lines;

/**
 列数
 */
@property (nonatomic, assign) NSInteger lineInteritems;

@end

NS_ASSUME_NONNULL_END
