//
//  NSDate+LFCalendar.h
//  DAalendar
//
//  Created by linfeng wang on 2019/7/1.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LFCalendar)

/**
 *  获得当前 NSDate 对象对应的日子
 */
- (NSInteger)dateDay;

/**
 *  获得当前 NSDate 对象对应的月份
 */
- (NSInteger)dateMonth;

/**
 *  获得当前 NSDate 对象对应的年份
 */
- (NSInteger)dateYear;

/**
 获取当前月前或后几个月的日期

 @param offset 偏移量 offset=3 未来第三个月的日期  offset=-3 过去第三个月的日期
 @return 日期
 */
- (NSDate *)offsetMonthDate:(NSInteger)offset;

/**
 *  获得当前 NSDate 对象对应的月份的总天数
 */
- (NSInteger)totalDaysInMonth;

/**
 *  获得当前NSDate对象对应月份第一天在周几  一 二 三 四 五 六 日 ==> 1 2 3 4 5 6 7
 */
- (NSInteger)firstWeekDayInMonth;

/**
 日期转字符串
 @return 字符串
 */
- (NSString *)dateString;

/**
 日期转int 例：201907
 @return int
 */
- (int)yearMonthIntValue;

/**
 日期转NSString 例：20190713
 @return NSString
 */
- (NSString *)yearMonthDayStringValue;

/**
 时间戳转date

 @param timestamp 时间戳(毫秒) 例：1562915933916
 @return date
 */
- (NSDate *)timestampToDate:(long)timestamp;

/**
 时间戳转字符串

 @param timestamp timestamp 时间戳(毫秒) 例：1562915933916
 @return NSString 例：@"20190715"
 */
- (NSString *)timestampToStringStyleDefault:(NSNumber *)timestamp;

/**
 时间戳转字符串
 
 @param timestamp timestamp 时间戳(毫秒) 例：1562915933916
 @return NSString 例：@"2019.07.15"
 */
+ (NSString *)timestampToStringStyle1:(NSNumber *)timestamp;

/**
 获取当前时间戳

 @return 时间戳（毫秒级）
 */
- (NSString *)getNowTimeTimestamp;


@end

NS_ASSUME_NONNULL_END
