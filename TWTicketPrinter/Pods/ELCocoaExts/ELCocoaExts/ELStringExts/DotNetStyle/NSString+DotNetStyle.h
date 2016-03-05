//
//  NSString+DotNet.h
//  ELCocoaExts
//
//  Created by Evan on 13/9/25.
//  Copyright (c) 2013年 WewaySoft. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSString Capsulation of Java/C# style
 */

@interface NSString (DotNetStyle)

+ (BOOL)isNullOrEmpty:(NSString *)str;


- (unichar)charAt:(NSInteger)index;


/**
 *  Compares two strings lexicographically.
 *
 *  @param anotherString anotherString
 *
 *  @return  the value 0 if the argument string is equal to this string;
 *           a value less than 0 if this string is lexicographically less than the string argument;
 *           and a value greater than 0 if this string is lexicographically greater than the string argument.
 */
- (NSInteger)compareTo:(NSString*) anotherString;
- (NSInteger)compareToIgnoreCase:(NSString*) str;
- (NSInteger)indexOfChar:(unichar)ch;
- (NSInteger)indexOfChar:(unichar)ch fromIndex:(NSInteger)index;
- (NSInteger)indexOfString:(NSString*)str;
- (NSInteger)indexOfString:(NSString*)str fromIndex:(NSInteger)index;
- (NSInteger)lastIndexOfChar:(unichar)ch;
- (NSInteger)lastIndexOfChar:(unichar)ch fromIndex:(NSInteger)index;
- (NSInteger)lastIndexOfString:(NSString*)str;
- (NSInteger)lastIndexOfString:(NSString*)str fromIndex:(NSInteger)index;

- (BOOL)isEmpty;
- (BOOL)contains:(NSString*)str;
- (BOOL)ignoreCaseContains:(NSString*)str;
- (BOOL)startsWith:(NSString*)prefix;
- (BOOL)endsWith:(NSString*)suffix;
- (BOOL)equals:(NSString*) anotherString;
- (BOOL)equalsIgnoreCase:(NSString*) anotherString;

- (NSString *)substringFromIndex:(NSInteger)beginIndex toIndex:(NSInteger)endIndex;
- (NSString *)toLower;
- (NSString *)toUpper;
- (NSString *)trim;
- (NSString *)replaceAll:(NSString*)origin with:(NSString*)replacement;
- (NSArray *)split:(NSString*) separator;

@end
