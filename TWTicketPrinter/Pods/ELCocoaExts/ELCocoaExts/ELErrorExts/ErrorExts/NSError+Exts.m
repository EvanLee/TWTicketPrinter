//
//  NSError+Exts.m
//  Example
//
//  Created by Evan on 13/11/17.
//  Copyright © 2013年 WewaySoft. All rights reserved.
//

#import "NSError+Exts.h"

@implementation NSError (Exts)

#pragma mark - Static Public Methods

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                  customInfoKey:(NSString *)key
                          value:(id)value
{
    NSDictionary *dict = @{key: value};
    return [NSError errorWithDomain:domain code:code userInfo:dict];
}

+ (instancetype)errorWithCustomInfoKey:(NSString *)key value:(id)value
{
    return [self.class errorWithDomain:@"" code:0 customInfoKey:key value:value];
}

+ (instancetype)errorWithFailureReason:(NSString *)reason
{
    return [self.class errorWithDomain:@""
                                  code:0
                         failureReason:reason];
}

+ (instancetype)errorWithDescription:(NSString *)description
{
    return [self.class errorWithDomain:@""
                                  code:0
                            description:description];
}


+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                  failureReason:(NSString *)reason
{
    return [self.class errorWithDomain:domain
                                  code:code
                         customInfoKey:NSLocalizedFailureReasonErrorKey
                                 value:reason];
}


+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                    description:(NSString *)description
{
    return [self.class errorWithDomain:domain
                                  code:code
                         customInfoKey:NSLocalizedFailureReasonErrorKey
                                 value:description];
}

#pragma mark - Public Methods

- (id)userInfoForKey:(NSString *)key
{
    NSDictionary *dict = self.userInfo;
    return [dict objectForKey:key];
}


@end
