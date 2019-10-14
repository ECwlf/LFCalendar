//
//  NSDate+DAPunchAwardCalendar.m
//  DAalendar
//
//  Created by linfeng wang on 2019/7/1.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import "NSDate+LFCalendar.h"

@implementation NSDate (LFCalendar)

- (NSInteger)dateDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self];
    return components.day;
}

- (NSInteger)dateMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)dateYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    return components.year;
}

- (NSDate *)offsetMonthDate:(NSInteger)offset {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 15;
    components.month += offset;
    NSDate *targetDate = [calendar dateFromComponents:components];
    return targetDate;
}

- (NSInteger)totalDaysInMonth {
    NSInteger totalDays = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    return totalDays;
}

- (NSInteger)firstWeekDayInMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 1; // 定位到当月第一天
    NSDate *firstDay = [calendar dateFromComponents:components];
    NSInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDay] - 1;
    if (firstWeekday == 0) {
        firstWeekday = 7;
    }
    return firstWeekday;
}

- (NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:self];
    return strDate;
}

- (NSString *)yearMonthDayStringValue
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *strDate = [dateFormatter stringFromDate:self];
    return strDate;
}

- (int)yearMonthIntValue
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMM"];
    NSString *strDate = [dateFormatter stringFromDate:self];
    return [strDate intValue];
}

- (NSDate *)timestampToDate:(long)timestamp
{
    return [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
}

- (NSString *)timestampToStringStyleDefault:(NSNumber *)timestamp
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[timestamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString*timeString=[formatter stringFromDate:date];
    return timeString;
}

+ (NSString *)timestampToStringStyle1:(NSNumber *)timestamp
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[timestamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
}
    
- (NSString *)getNowTimeTimestamp
{
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;//客户端当前13位毫秒级时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%llu",recordTime];//时间戳转字符串(13位毫秒级时间戳字符串)
    return timeSp;
}

@end
