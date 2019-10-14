//
//  LFCalendarView.h
//  DAalendar
//
//  Created by linfeng wang on 2019/7/2.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LFCalenderShowDateBlock)(NSDate * _Nonnull date,NSInteger lines);

NS_ASSUME_NONNULL_BEGIN

@interface LFCalendarView : UIView

@property (nonatomic, copy) LFCalenderShowDateBlock calenderShowDateBlock;

@end

NS_ASSUME_NONNULL_END
