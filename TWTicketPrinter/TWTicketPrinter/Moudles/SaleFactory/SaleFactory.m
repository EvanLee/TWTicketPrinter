//
//  SaleFactory.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "SaleFactory.h"
#import "SaleStrategy.h"
#import "GoodsItem.h"
#import "SaleNormal.h"
#import "StrategyProxy.h"

NSDictionary *g_strategyMap;

@interface SaleFactory ()

@property (nonatomic, strong) NSArray *strategies;
@property (nonatomic, strong) id<ISaleFactory> factoryProxy;

@end

@implementation SaleFactory

#pragma mark - Instance LifeCycle

+ (void)initialize {
    if (self == [SaleFactory class]) {
        [self loadMap];
    }
}

#pragma mark - ISaleStrategy 接口

- (id<ISaleStrategy>)createInstanceForObject:(GoodsItem *)item {
    NSString *barCode   = [item barCode];
    NSArray *strategies = [g_strategyMap objectForKey:barCode]; //同一个商品会有多种优惠

    if (strategies || strategies.count ) {
        return [SaleNormal new];
    }
    
    /**
     *  思考：本来是打算用一个简单的享元模式, 直接在Map中取一个策略返回。但实际情况是，各种策略之间还有各种关系。
     *  如，组合关系，先后顺序关系等，他们之间的关系组成可能多变，复杂。所以，为满足单一职责原则，这里需要把职责分离出去！
     *  但是返回又必须是一个策略接口，所以选择代理模式
     *
     */
    
    return [StrategyProxy instanceWithTarget:strategies];
}


#pragma mark - Private Methods

+ (void)loadMap {
    #warning - 从数从本地读取的方法需要重构
    NSString *urlPath        = [[NSBundle mainBundle] pathForResource:@"SaleStategies" ofType:@"plist"];
    NSArray *array           = [NSArray arrayWithContentsOfFile:urlPath];
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    
    for (NSDictionary *dic in array) {
       SaleStrategy *strategy = [[SaleStrategy alloc] initWithDictionary:dic error:nil];

        NSArray<NSString *> *products = strategy.products;
        for (NSString *barCode in products) {
            [self configureMap:map forBarCode:barCode];
        }
    }
    
    g_strategyMap = map;
}

+ (void)configureMap:(NSMutableDictionary *)map forBarCode:(NSString *)barCode {
    NSMutableArray *strategys = [map objectForKey:barCode];
    
    if (!strategys) {
        strategys = [NSMutableArray array];
        [map setValue:strategys forKey:barCode];
    }
    
    [strategys addObject:@(1)];
}


@end
