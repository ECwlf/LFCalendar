//
//  LFCalendarHeaderView.m
//  DAalendar
//
//  Created by linfeng wang on 2019/7/2.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import "LFCalendarHeaderView.h"

#define YearAndMonthLabHeight 16
#define WeeksViewHeight 15

#define WeekLabWidth (self.frame.size.width - 12)/7

@interface LFCalendarHeaderView ()

@property (nonatomic, strong) UILabel *yearAndMonthLab;
@property (nonatomic, strong) UIView *weeksView;

@end

@implementation LFCalendarHeaderView {
    NSArray *_weeksNameArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _weeksNameArr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
        [self addSubview:self.yearAndMonthLab];
        [self addSubview:self.weeksView];
    }
    return self;
}

- (void)setCurrentShowDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M月 yyyy"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
//    NSString *currentMonthStr = [currentDateStr substringToIndex:2];
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"];
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.locale = locale;
//    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
//    NSString *str = [formatter stringFromNumber:[NSNumber numberWithInt:[currentMonthStr intValue]]];
//    currentDateStr = [currentDateStr stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:str];
    _yearAndMonthLab.text = currentDateStr;
}

- (UILabel *)yearAndMonthLab {
    if (!_yearAndMonthLab) {
        _yearAndMonthLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, self.frame.size.width, YearAndMonthLabHeight)];
        _yearAndMonthLab.textAlignment = NSTextAlignmentCenter;
        _yearAndMonthLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _yearAndMonthLab.font = [UIFont systemFontOfSize:16];
        [self setCurrentShowDate:[NSDate date]];
    }
    return _yearAndMonthLab;
}

- (UIView *)weeksView
{
    if (!_weeksView) {
        _weeksView = [[UIView alloc] initWithFrame:CGRectMake(6, 50, self.frame.size.width - 12, WeeksViewHeight)];
        for (int i = 0; i < 7; i++) {
            UILabel *weekLab = [[UILabel alloc] initWithFrame:CGRectMake(WeekLabWidth * i, 0, WeekLabWidth, WeeksViewHeight)];
            weekLab.text = _weeksNameArr[i];
            weekLab.font = [UIFont systemFontOfSize:14];
            weekLab.textAlignment = NSTextAlignmentCenter;
            weekLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            [_weeksView addSubview:weekLab];
        }
    }
    return _weeksView;
}

@end
