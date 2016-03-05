//
//  NSError+Exts.h
//  Example
//
//  Created by Evan on 13/11/17.
//  Copyright © 2013年 WewaySoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Exts)

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                  customInfoKey:(NSString *)key
                          value:(id)value;

+ (instancetype)errorWithCustomInfoKey:(NSString *)key value:(id)value;

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                  failureReason:(NSString *)reason;

+ (instancetype)errorWithFailureReason:(NSString *)reason;

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                    description:(NSString *)description;

+ (instancetype)errorWithDescription:(NSString *)description;

- (id)userInfoForKey:(NSString *)key;

@end
