//
//  NSDate+Exts.m
//  MiniOA
//
//  Created by Evan on 14-9-24.
//  Copyright (c) 2014年 we way software,Ltd. All rights reserved.
//

#import "NSDate+Exts.h"

@implementation NSDate (Exts)

- (NSString *)toString:(NSString *)format
{
    if (format == nil || format.length == 0) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale =  [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
}

- (NSInteger)getYear
{
    return [[self toString:@"yyyy"] integerValue];
}

- (NSInteger)getMonth
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calender components:NSMonthCalendarUnit fromDate:self];
    
    return [comp month];
}

- (NSInteger)getDay
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calender components:NSDayCalendarUnit fromDate:self];
    
    return [comp day];
}

- (NSString *)toWeekdayString
{
    return [self.class dateToWeekdayString:self];
}

+ (instancetype)dateFromString:(NSString *)dateString withFormat:(NSString *)format
{
    if (dateString == nil || dateString.length == 0
        || format == nil || format.length == 0) {
        return nil;
    }
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = format;
    fmt.locale =  [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDate *utc = [fmt dateFromString:dateString];

    return utc;
}


+ (long)dayDiffWithDate:(NSDate *)date1 sinceDate:(NSDate *)date2
{
    NSDate *fromDate;
    NSDate *toDate;
    
//    NSAssert(date1, @"date1 不能为空");
//    NSAssert(date2, @"sinceDate 不能为空");
    
    if (!date1) {
        NSLog(@"date1 不能为空!");
        date1 = [NSDate date];
    }
    
    if (!date2) {
        NSLog(@"sinceDate 不能为空!");
        date2 = [NSDate date];
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:date2];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:date1];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

//dateNow - date
+ (long)dayDiffWithDateSinceNow:(NSDate *)date
{
    NSDate *dateNow = [NSDate date];
    return [self dayDiffWithDate:dateNow sinceDate:date];
}

+ (NSString *)dateToWeekdayString:(NSDate *)date
{
    NSArray *weekdays = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:(theComponents.weekday - 1)];
}

@end
