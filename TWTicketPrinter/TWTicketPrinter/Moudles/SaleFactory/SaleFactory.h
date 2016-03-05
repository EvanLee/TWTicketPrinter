//
//  SaleFactory.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISaleStrategy.h"

@class GoodsItem;

/**
 *  SaleFactory 负责算法策略的创建
 */

@interface SaleFactory : NSObject

- (id<ISaleStrategy>)calculatorForGoods:(GoodsItem *)item;

@end
