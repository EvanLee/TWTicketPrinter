//
//  FactoryProxy.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "StrategyProxy.h"
#import "SalesRebate.h"
#import "SalesFeeGoods.h"
#import "GoodsItem.h"
#import "OutputBuilder.h"

@interface StrategyProxy ()

@property (nonatomic, strong) NSArray *strategise;

@end

@implementation StrategyProxy

#pragma mark - Instance LifeCycle

+ (instancetype)instanceWithTarget:(id)target {
    StrategyProxy *proxy = [StrategyProxy new];
    proxy.strategise = target;
    return proxy;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
    }
    
    return self;
}


#pragma mark - ISaleStrategy Impl

- (void)calcResultsForData:(id)data {
    /**
     *  这里就可以根据需求写的很复杂，将策略进行各种组合逻辑判断，如下面的 strategy 就是一个链式的
     *   for (id<ISaleStrategy> strategy in self.strategise) {
     *        [strategy calcResultsForData:data];
     *   }
     *
     */

    if (self.strategise.count > 1) {
        [self formartList];
    }
    
    for (id<ISaleStrategy> strategy in self.strategise) {
        [strategy calcResultsForData:data];
    }
}


- (void)setStrategyDescription:(NSString *)name {

}

- (NSString *)strategyDescription {
    return @"";
}

#pragma mark - output Impl

- (void)buildOutput:(OutputBuilder *)output data:(GoodsItem *)data {
    for (id<IPrintStrategy> strategy in self.strategise) {
        if ([strategy conformsToProtocol:@protocol(IPrintStrategy)]) {
            [strategy buildOutput:output data:data];
        }
    }
}

#pragma mark - Private Methods

- (void)formartList {
    if (![self shouldRemoveSalesRebate]) {
        return;
    }

    NSMutableArray *array = [NSMutableArray array];

    for (id<ISaleStrategy> strategy in self.strategise) {
        if ([strategy isKindOfClass:[SalesFeeGoods class]]) {
            [array addObject:strategy];
        }
    }
    
    self.strategise = array;
}

/**
 *  当“95折”和“买二赠一”发生冲突的时候 ，只享受"买二送一"
 *
 */
- (BOOL)shouldRemoveSalesRebate {
    __block NSInteger idxRebate   = -1;
    __block NSInteger idxFeeGoods = -1;
    
    [self.strategise enumerateObjectsUsingBlock:^(id<ISaleStrategy> obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[SalesRebate class]]) {
            idxRebate = idx;
        }
        
        if ([obj isKindOfClass:[SalesFeeGoods class]]) {
            idxFeeGoods = idx;
        }
    }];
    
    if (idxRebate != -1 && idxFeeGoods != -1) {
        return YES;
    }
    
    return NO;
}

@end
