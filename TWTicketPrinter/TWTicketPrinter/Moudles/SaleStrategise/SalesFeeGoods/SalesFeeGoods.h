//
//  SalesFeeGoods.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISaleStrategy.h"
#import "IPrintStrategy.h"

@interface SalesFeeGoods : NSObject <ISaleStrategy, IPrintStrategy>

@property (nonatomic, assign, readonly) NSUInteger needsNumber;
@property (nonatomic, assign, readonly) NSUInteger feeNumber;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (instancetype)initWithNeedsNumber:(NSUInteger)needsNumber feeNumber:(NSUInteger)feeNumber;

@end
