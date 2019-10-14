//
//  LFCalendarView.m
//  DAalendar
//
//  Created by linfeng wang on 2019/7/2.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import "LFCalendarView.h"
#import "LFCalendarHeaderView.h"
#import "LFCalendarCollectionView.h"
#import "LFCollectionViewPageLayout.h"
#import "NSDate+LFCalendar.h"

static CGFloat CalendarHeaderViewHeight = 70;
static CGFloat CalendarCollectionViewHeight = 225;

@interface LFCalendarView ()

@property (nonatomic, strong) LFCalendarHeaderView *calendarHeaderView;
@property (nonatomic, strong) LFCalendarCollectionView *calendarCollectionView;

/**
 当前显示页面的月份
 */
@property (nonatomic, strong) NSDate *currentShowDate;

@end

@implementation LFCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.calendarHeaderView];
        [self addSubview:self.calendarCollectionView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //推迟赋值，使外部block能捕获初始化时间相关的信息
            if (!self.currentShowDate) {
                self.currentShowDate = [NSDate date];
            }
        });
    }
    return self;
}

#pragma mark -- setter and getter
- (LFCalendarHeaderView *)calendarHeaderView {
    if (!_calendarHeaderView) {
        _calendarHeaderView = [[LFCalendarHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CalendarHeaderViewHeight)];
    }
    return _calendarHeaderView;
}

- (UICollectionView *)calendarCollectionView {
    if (!_calendarCollectionView) {
        __weak LFCalendarView *weakSelf = self;
        LFCollectionViewPageLayout *pageLayout = [[LFCollectionViewPageLayout alloc] init];
        pageLayout.pages = 13;
        pageLayout.lines = 6;
        pageLayout.lineInteritems = 7;
        pageLayout.itemSize = CGSizeMake((self.frame.size.width - 12)/7, 34);
        _calendarCollectionView = [[LFCalendarCollectionView alloc] initWithFrame:CGRectMake(0, CalendarHeaderViewHeight, self.frame.size.width, CalendarCollectionViewHeight) collectionViewLayout:pageLayout];
        _calendarCollectionView.contentInset = UIEdgeInsetsMake(0, 6, 21, 6);
        _calendarCollectionView.contentOffset = CGPointMake(_calendarCollectionView.frame.size.width * 6, 0);
        _calendarCollectionView.calendarCurrentShowDateBlock = ^(NSDate * _Nonnull date) {
            weakSelf.currentShowDate = date;
        };
        _calendarCollectionView.calendarCellSelectedDateBlock = ^(NSDate * _Nonnull date) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *currentDateStr = [dateFormatter stringFromDate:date];
            NSLog(@"%@",currentDateStr);
        };
    }
    return _calendarCollectionView;
}

- (void)setCurrentShowDate:(NSDate *)currentIndexDate {
    _currentShowDate = currentIndexDate;
    [_calendarHeaderView setCurrentShowDate:currentIndexDate];
    NSInteger weekIndex = [currentIndexDate firstWeekDayInMonth];
    NSInteger totalDay = [currentIndexDate totalDaysInMonth];
    NSInteger showLines = ceil((weekIndex + totalDay - 1)/7.0);
    if (self.calenderShowDateBlock) {
        self.calenderShowDateBlock(currentIndexDate, showLines);
    }
}

@end
