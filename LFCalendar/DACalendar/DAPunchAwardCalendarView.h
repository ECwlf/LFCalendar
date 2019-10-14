//
//  DAPunchAwardCalendarView.h
//  DAalendar
//
//  Created by linfeng wang on 2019/7/2.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DAPunchAwardCalenderShowDateBlock)(NSDate * _Nonnull date,NSInteger lines);

NS_ASSUME_NONNULL_BEGIN

@interface DAPunchAwardCalendarView : UIView

@property (nonatomic, copy) DAPunchAwardCalenderShowDateBlock calenderShowDateBlock;

@end

NS_ASSUME_NONNULL_END
