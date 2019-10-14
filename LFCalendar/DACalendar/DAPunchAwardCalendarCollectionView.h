//
//  DAPunchAwardCalendarCollectionView.h
//  DAalendar
//
//  Created by linfeng wang on 2019/7/1.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DAPunchAwardCalendarCurrentShowDateBlock)(NSDate *date);
typedef void(^DAPunchAwardCalendarCellSelectedDateBlock)(NSDate *date);

@interface DAPunchAwardCalendarCollectionView : UICollectionView

@property (nonatomic, copy) DAPunchAwardCalendarCurrentShowDateBlock calendarCurrentShowDateBlock;
@property (nonatomic, copy) DAPunchAwardCalendarCellSelectedDateBlock calendarCellSelectedDateBlock;

@end

NS_ASSUME_NONNULL_END
