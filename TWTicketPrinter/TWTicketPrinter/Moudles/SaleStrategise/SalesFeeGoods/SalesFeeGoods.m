//
//  SalesFeeGoods.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "SalesFeeGoods.h"
#import "ELCocoaExts.h"
#import "GoodsItem.h"
#import "OutputBuilder.h"

NSString *const Sales_FeeGoods_NeedsKey = @"BuyNum";
NSString *const Sales_FeeGoods_FeeKey   = @"FeeNum";

@interface SalesFeeGoods ()
@property (nonatomic, assign) NSUInteger needsNumber;
@property (nonatomic, assign) NSUInteger feeNumber;
@property (nonatomic, copy) NSString *strategyName;
@end

@implementation SalesFeeGoods

#pragma mark - Instance LifeCycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.needsNumber = 1;
        self.feeNumber   = 0;
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.needsNumber = [dict unsignedIntegerValueForKey:Sales_FeeGoods_NeedsKey];
        self.feeNumber   = [dict unsignedIntegerValueForKey:Sales_FeeGoods_FeeKey];
    }
    
    return self;
}

- (instancetype)initWithNeedsNumber:(NSUInteger)needsNumber
                          feeNumber:(NSUInteger)feeNumber {
    if (self = [super init]) {
        self.needsNumber = needsNumber;
        self.feeNumber   = feeNumber;
    }
    
    return self;
}

#pragma mark - ISaleStrategy Implement

- (void)calcResultsForData:(GoodsItem *)data {
    NSUInteger payCount = [self calcPayNumber:data];
    NSUInteger feeCount = data.count - payCount;
    CGFloat    price    = data.price;
    
    /**
     *  这里会有一个问题，假如活动是买三送一，那么用户买了七个，按照算法来是这样（3+1(赠送)）+（3+0(赠送)）
     *  结果导致了用户买最后一组，没法享受赠送优惠。
     */
    
    data.totalPrice  = payCount * price;
    data.savePrice   = feeCount * price;
}

- (void)setStrategyDescription:(NSString *)name {
    _strategyName = name;
}

- (NSString *)strategyDescription {
    return self.strategyName;
}

#pragma mark - output

- (void)buildOutput:(OutputBuilder *)output data:(GoodsItem *)data {
    NSUInteger feeCount = data.count - [self calcPayNumber:data];
    NSString *goodsInfo = [NSString stringWithFormat:@"名称：%@, 数量：%@，单价：%.2f(元), 小计:%.2f(元)",
                           data.goodsName,
                           [NSString stringWithFormat:@"%ld%@", data.count, data.unitsName],
                           data.price,
                           data.totalPrice];
    
    NSString *extraData = [NSString stringWithFormat:@"名称：%@, 数量：%@",
                           data.goodsName,
                           [NSString stringWithFormat:@"%ld%@", feeCount, data.unitsName]];
    
    
    [output addBaseData:goodsInfo];
    [output addExtraData:extraData forType:self.strategyName];
}

#pragma mark - Private Methods

- (NSUInteger)calcPayNumber:(GoodsItem *)data {
    NSUInteger number = data.count;
    NSUInteger tmp = self.needsNumber + self.feeNumber;
    
    return (number / tmp) * self.needsNumber + number % tmp;
}

@end
