//
//  NSString+Json.h
//  ELCocoaExts
//
//  Created by Evan on 13/9/25.
//  Copyright (c) 2013年 WewaySoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Exts)

+ (NSString *)generateGUID;
+ (NSString *)stringWithInteger:(NSInteger)intValue;
+ (NSString *)stringWithData:(NSData *)data encodingName:(NSString *)encodingName;
//+ (NSString *)stringWithQueryDictionary:(NSDictionary *)queryDict;

- (NSString*)MD5;
- (NSData*)MD5Data;

- (BOOL)isAllDigits;
- (BOOL)isNumeric;
- (BOOL)containsSystemEmoji;

- (id)toJSONValue;

@end
