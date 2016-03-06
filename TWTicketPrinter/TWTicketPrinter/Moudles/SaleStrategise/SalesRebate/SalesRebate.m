//
//  SalesRebate.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "SalesRebate.h"
#import "ELCocoaExts.h"
#import "GoodsItem.h"

NSString * const Sales_Rebate_Key = @"Rebate";

@interface SalesRebate ()

@property (nonatomic, assign) CGFloat rebate;

@end

@implementation SalesRebate

#pragma mark - Instance LifeCycl

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        id v = [dict objectForKey:Sales_Rebate_Key];
        if ([v respondsToSelector:@selector(floatValue)]) {
            self.rebate = [v floatValue];
        } else {
            self.rebate = 10;
        }
    }
    
    return self;
}

- (instancetype)initWithRebate:(CGFloat)rebate {
    if (self = [super init]) {
        self.rebate = rebate;
    }
    
    return self;
}

#pragma mark - ISaleStrategy 接口

- (void)calcResultsForData:(GoodsItem *)data {
    NSUInteger number = data.count;
    CGFloat price     = data.price;
    CGFloat total     = price * number;
    CGFloat discount  = self.rebate / 10.f;

    data.totalPrice  = total * discount;
    data.savePrice   = total - data.totalPrice;
}

@end
