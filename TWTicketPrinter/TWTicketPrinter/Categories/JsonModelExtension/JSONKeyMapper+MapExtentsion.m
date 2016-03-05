//
//  JSONKeyMapper+MapExtentsion.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "JSONKeyMapper+MapExtentsion.h"

@implementation JSONKeyMapper (MapExtentsion)

+ (instancetype)mapperFromBigCamelCaseToLittleCamelCase {
    return [self mapperFromBigCamelCaseToLittleCamelCaseWithMap:nil];
}

+ (instancetype)mapperFromBigCamelCaseToLittleCamelCaseWithMap:(NSDictionary *)map {
    NSDictionary *toJMap = nil;
    
    if (map) {
        toJMap = [self swapKeysAndValuesInDictionary:map];
    }
    
    JSONModelKeyMapBlock toModel = ^ NSString* (NSString* keyName) {
        if (map && [map objectForKey:keyName]) {
            return map[keyName];
        }
        
        NSString *firstLetter = [[keyName substringToIndex:1] lowercaseString];
        return [NSString stringWithFormat:@"%@%@", firstLetter, [keyName substringFromIndex:1]];
    };
    
    JSONModelKeyMapBlock toJSON = ^ NSString* (NSString* keyName) {
        
        if (toJMap && [toJMap objectForKey:keyName]) {
            return toJMap[keyName];
        }
        
        NSString *firstLetter = [[keyName substringToIndex:1] uppercaseString];
        return [NSString stringWithFormat:@"%@%@", firstLetter, [keyName substringFromIndex:1]];
    };
    
    return [[self alloc] initWithJSONToModelBlock:toModel modelToJSONBlock:toJSON];
}

+ (NSDictionary *)swapKeysAndValuesInDictionary:(NSDictionary *)dictionary {
    NSMutableDictionary *swapped = [NSMutableDictionary new];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
        NSAssert([value isKindOfClass:[NSString class]], @"Expect keys and values to be NSString");
        NSAssert([key isKindOfClass:[NSString class]], @"Expect keys and values to be NSString");
        swapped[value] = key;
    }];
    
    return swapped;
}


@end
