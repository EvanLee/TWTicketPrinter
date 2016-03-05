//
//  NSDate+Exts.h
//  MiniOA
//
//  Created by Evan on 14-9-24.
//  Copyright (c) 2014年 we way software,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Exts)

- (NSString *)toString:(NSString *)format;
- (NSInteger)getYear;
- (NSInteger)getDay;
- (NSInteger)getMonth;
- (NSString *)toWeekdayString;

+ (instancetype)dateFromString:(NSString *)dateString withFormat:(NSString *)format;
+ (long)dayDiffWithDate:(NSDate *)date1 sinceDate:(NSDate *)date2;
+ (long)dayDiffWithDateSinceNow:(NSDate *)date;

/**
 *  根据时间获取星期几
 *
 *  @param date 时间
 *
 *  @return 返回星期几的字符串
 */
+ (NSString *)dateToWeekdayString:(NSDate *)date;

@end
