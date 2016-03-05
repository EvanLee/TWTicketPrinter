//
//  NSDictionary+Exts.m
//  ELCocoaExts
//
//  Created by Evan on 13/9/25.
//  Copyright (c) 2013年 WewaySoft. All rights reserved.
//

#import "NSDictionary+Exts.h"

@implementation NSDictionary (Exts)

- (NSString *)toJSONString
{
    __autoreleasing NSError *err = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&err ];
    if (err || !data) {
        NSLog(@"字典转Json失败");
        return nil;
    }
    return [[NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSUInteger)unsignedIntegerValueForKey:(id)key
{
    return [self integerValueForKey:key withDefault:0];
}

- (NSUInteger)unsignedIntegerValueForKey:(id)key withDefault:(NSUInteger)value
{
    id obj = [self objectForKey:key];
    
    if (obj && ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])) {
        return [obj unsignedIntegerValue];
    }
    return value;
}

- (NSInteger)integerValueForKey:(id)key
{
    return [self integerValueForKey:key withDefault:0];
}

- (NSInteger)integerValueForKey:(id)key withDefault:(NSInteger)value
{
    id obj = [self objectForKey:key];
    
    if (obj && ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])) {
        return [obj integerValue];
    }
    return value;
}

- (long)longValueForKey:(id)key
{
    return [self longValueForKey:key withDefault:0];
}

- (long)longValueForKey:(id)key withDefault:(NSInteger)value
{
    id obj = [self objectForKey:key];
    if (!obj) {
        return value;
    }
    
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj longValue];
    }
    
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *strObj = (NSString *)obj;
        return (long)[strObj doubleValue];
    }
    
    return value;
}

- (NSString *)stringValueForKey:(id)key;
{
    return [self stringValueForKey:key withDefalut:nil];
    
}

- (NSString *)stringValueForKey:(id)key withDefalut:(NSString *)value
{
    id obj = [self objectForKey:key];
    
    if (obj && [obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    }
    return value;
}

- (BOOL)boolValueForKey:(id)key
{
    return [self boolValueForKey:key withDefault:NO];
}

- (BOOL)boolValueForKey:(id)key withDefault:(BOOL)value
{
    id obj = [self objectForKey:key];
    
    if (obj && ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]])) {
        return [obj integerValue] == 0 ? NO : YES;
    }
    return value;
}

@end
