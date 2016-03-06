//
//  SaleNormal.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "SaleNormal.h"
#import "GoodsItem.h"

@implementation SaleNormal

#pragma mark - ISaleStrategy Implement

- (void)calcResultsForData:(GoodsItem *)data {
    NSUInteger number = data.count;
    CGFloat price     = data.price;
    
    data.totalPrice  = number * price;
    data.savePrice   = 0;
}

@end
