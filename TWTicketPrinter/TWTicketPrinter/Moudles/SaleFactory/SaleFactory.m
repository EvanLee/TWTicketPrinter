//
//  SaleFactory.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "SaleFactory.h"

@interface SaleFactory ()

@end

@implementation SaleFactory

- (id<ISaleStrategy>)calculatorForGoods:(GoodsItem *)item {
    return nil;
}

@end
