//
//  NSDictionary+Exts.h
//  ELCocoaExts
//
//  Created by Evan on 13/9/25.
//  Copyright (c) 2013年 WewaySoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Exts)

- (NSString *)toJSONString;

- (NSString *)stringValueForKey:(id)key;
- (NSString *)stringValueForKey:(id)key withDefalut:(NSString *)value;

- (NSInteger)integerValueForKey:(id)key;
- (NSInteger)integerValueForKey:(id)key withDefault:(NSInteger)value;

- (NSUInteger)unsignedIntegerValueForKey:(id)key;
- (NSUInteger)unsignedIntegerValueForKey:(id)key withDefault:(NSUInteger)value;

- (long)longValueForKey:(id)key;
- (long)longValueForKey:(id)key withDefault:(NSInteger)value;

- (BOOL)boolValueForKey:(id)key;
- (BOOL)boolValueForKey:(id)key withDefault:(BOOL)value;

@end
