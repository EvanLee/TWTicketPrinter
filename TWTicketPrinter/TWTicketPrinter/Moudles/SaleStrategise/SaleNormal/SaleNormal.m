//
//  SaleNormal.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "SaleNormal.h"
#import "GoodsItem.h"
#import "NormalPrinter.h"

@interface SaleNormal ()
@end

@implementation SaleNormal

#pragma mark - Instance LifeCycle

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
    }
    
    return self;
}


#pragma mark - ISaleStrategy Implement

- (void)calcResultsForData:(GoodsItem *)data {
    
    NSUInteger number = data.count;
    CGFloat price     = data.price;
    
    data.totalPrice  = number * price;
    data.savePrice   = 0;
}

- (id<IPrintable>)printInfo:(GoodsItem *)data {
    return [[NormalPrinter alloc] initWithTarget:data];
}


@end
