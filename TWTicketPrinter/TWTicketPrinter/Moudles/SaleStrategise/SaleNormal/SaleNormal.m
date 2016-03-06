//
//  SaleNormal.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "SaleNormal.h"
#import "GoodsItem.h"
#import "OutputBuilder.h"

@interface SaleNormal ()

@property (nonatomic, copy) NSString *strategyName;

@end

@implementation SaleNormal

#pragma mark - Instance LifeCycle

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
    }
    
    return self;
}


#pragma mark - ISaleStrategy Impl

- (void)calcResultsForData:(GoodsItem *)data {
    
    NSUInteger number = data.count;
    CGFloat price     = data.price;
    
    data.totalPrice  = number * price;
    data.savePrice   = 0;
}

- (void)setStrategyDescription:(NSString *)name {
    _strategyName = name;
}

- (NSString *)strategyDescription {
    return self.strategyName;
}


- (void)buildOutput:(OutputBuilder *)output data:(GoodsItem *)data {
    NSString *goodsInfo = [NSString stringWithFormat:@"名称：%@, 数量：%@，单价：%.2f(元), 小计:%.2f(元)",
                         data.goodsName,
                         [NSString stringWithFormat:@"%ld%@", data.count, data.unitsName],
                         data.price,
                         data.totalPrice];
    
    [output addBaseData:goodsInfo];
}


@end
