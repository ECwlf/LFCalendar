//
//  LFCalendarCollectionView.h
//  DAalendar
//
//  Created by linfeng wang on 2019/7/1.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LFCalendarCurrentShowDateBlock)(NSDate *date);
typedef void(^LFCalendarCellSelectedDateBlock)(NSDate *date);

@interface LFCalendarCollectionView : UICollectionView

@property (nonatomic, copy) LFCalendarCurrentShowDateBlock calendarCurrentShowDateBlock;
@property (nonatomic, copy) LFCalendarCellSelectedDateBlock calendarCellSelectedDateBlock;

@end

NS_ASSUME_NONNULL_END
