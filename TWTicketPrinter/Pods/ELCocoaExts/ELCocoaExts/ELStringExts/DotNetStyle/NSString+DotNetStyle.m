//
//  NSString+DotNet.m
//  ELCocoaExts
//
//  Created by Evan on 13/9/25.
//  Copyright (c) 2013年 WewaySoft. All rights reserved.
//

#import "NSString+DotNetStyle.h"

#define StringNotFound -1

@implementation NSString (DotNetStyle)

#pragma mark - Static methods

+ (BOOL)isNullOrEmpty:(NSString *)str
{
    return str == nil || [str length] == 0;
}


#pragma mark - Public Methods

- (unichar)charAt:(NSInteger)index
{
    return [self characterAtIndex:index];
}

- (NSInteger)compareTo:(NSString*) anotherString
{
    return [self compare:anotherString];
}

- (NSInteger)compareToIgnoreCase:(NSString*) str
{
    return [self compare:str options:NSCaseInsensitiveSearch];
}

- (NSInteger)indexOfChar:(unichar)ch
{
    return [self indexOfChar:ch fromIndex:0];
}

- (NSInteger)indexOfChar:(unichar)ch fromIndex:(NSInteger)index
{
    NSInteger len = (NSInteger)self.length;
    for (NSInteger i = index; i < len; ++i) {
        if (ch == [self charAt:i]) {
            return i;
        }
    }
    return StringNotFound;
}

- (NSInteger)indexOfString:(NSString*)str
{
    NSRange range = [self rangeOfString:str];
    if (range.location == NSNotFound) {
        return StringNotFound;
    }
    return (NSInteger)range.location;
}

- (NSInteger)indexOfString:(NSString*)str fromIndex:(NSInteger)index
{
    NSRange fromRange = NSMakeRange(index, self.length - index);
    NSRange range = [self rangeOfString:str options:NSLiteralSearch range:fromRange];
    if (range.location == NSNotFound) {
        return StringNotFound;
    }
    return (NSInteger)range.location;
}

- (NSInteger)lastIndexOfChar:(unichar)ch
{
    NSInteger len = (NSInteger)self.length;
    for (NSInteger i = len-1; i >=0; --i) {
        if ([self charAt:i] == ch) {
            return i;
        }
    }
    return StringNotFound;
}

- (NSInteger)lastIndexOfChar:(unichar)ch fromIndex:(NSInteger)index
{
    NSInteger len = (NSInteger)self.length;
    if (index >= len) {
        index = len - 1;
    }
    for (NSInteger i = index; i >= 0; --i) {
        if ([self charAt:i] == ch) {
            return index;
        }
    }
    return StringNotFound;
}

- (NSInteger)lastIndexOfString:(NSString*)str
{
    NSRange range = [self rangeOfString:str options:NSBackwardsSearch];
    if (range.location == NSNotFound) {
        return StringNotFound;
    }
    return (NSInteger)range.location;
}

- (NSInteger)lastIndexOfString:(NSString*)str fromIndex:(NSInteger)index
{
    NSRange fromRange = NSMakeRange(0, index);
    NSRange range = [self rangeOfString:str options:NSBackwardsSearch range:fromRange];
    if (range.location == NSNotFound) {
        return StringNotFound;
    }
    return (NSInteger)range.location;
}

- (BOOL)isEmpty
{
    return [self length] == 0;
}

- (BOOL)contains:(NSString*)str
{
    NSRange range = [self rangeOfString:str];
    return (range.location != NSNotFound);
}

- (BOOL)ignoreCaseContains:(NSString*)str 
{
    NSRange range = [self rangeOfString:str
                                options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch];
    return (range.location != NSNotFound);
}

- (BOOL)startsWith:(NSString*)prefix
{
    return [self hasPrefix:prefix];
}

- (BOOL)endsWith:(NSString*)suffix
{
    return [self hasSuffix:suffix];
}

- (BOOL)equals:(NSString*) anotherString
{
    return [self isEqualToString:anotherString];
}

- (BOOL)equalsIgnoreCase:(NSString*) anotherString
{
    return [[self toLower] equals:[anotherString toLower]];
}

- (NSString *)substringFromIndex:(NSInteger)beginIndex toIndex:(NSInteger)endIndex
{
    if (endIndex <= beginIndex) {
        return @"";
    }
    NSRange range = NSMakeRange(beginIndex, endIndex - beginIndex);
    return [self substringWithRange:range];
}

- (NSString *)toLower
{
    return [self lowercaseString];
}

- (NSString *)toUpper
{
    return [self uppercaseString];
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)replaceAll:(NSString*)origin with:(NSString*)replacement
{
    return [self stringByReplacingOccurrencesOfString:origin withString:replacement];
}

- (NSArray *)split:(NSString*) separator
{
    return [self componentsSeparatedByString:separator];
}


@end
