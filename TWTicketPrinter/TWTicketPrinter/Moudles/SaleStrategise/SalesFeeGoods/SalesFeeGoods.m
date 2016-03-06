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
#import "GoodsFeePrinter.h"
#import "IPrintable.h"
#import "GoodsFeeExtraPrinter.h"

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
    NSUInteger number = data.count;
    CGFloat price     = data.price;
    
    NSUInteger tmp = self.needsNumber + self.feeNumber;
    NSUInteger payCount = (number / tmp) * self.needsNumber + number % tmp;
    NSUInteger feeCount = number - payCount;
    
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

- (id<IPrintable>)printInfo:(GoodsItem *)data {
    return [[GoodsFeePrinter alloc] initWithTarget:data];
}

- (id<IPrintable>)printExtraInfo:(GoodsItem *)data {
    NSUInteger number = data.count;
    NSUInteger tmp = self.needsNumber + self.feeNumber;
    NSUInteger payCount = (number / tmp) * self.needsNumber + number % tmp;
    
    GoodsItem *newItem = [GoodsItem new];
    [newItem addWithCount:number - payCount];

    return [[GoodsFeeExtraPrinter alloc] initWithTarget:data];
}

@end
