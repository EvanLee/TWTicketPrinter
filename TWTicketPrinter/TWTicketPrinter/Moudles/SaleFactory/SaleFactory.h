//
//  SaleFactory.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISaleStrategy.h"
#import "ISaleFactory.h"

/**
 *  SaleFactory 负责算法策略的创建, 享元模式
 */

@interface SaleFactory : NSObject <ISaleFactory>

@property (nonatomic, strong, readonly) NSDictionary *strategyCache;
@property (nonatomic, strong, readonly) NSDictionary *goodsStrategyMap;

- (instancetype)initWithFileName:(NSString *)strategyFileName;

@end
