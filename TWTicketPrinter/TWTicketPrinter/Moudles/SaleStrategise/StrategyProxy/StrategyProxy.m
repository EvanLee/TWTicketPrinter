//
//  FactoryProxy.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "StrategyProxy.h"

@interface StrategyProxy ()

@property (nonatomic, strong) id strategy;

@end

@implementation StrategyProxy

#pragma mark - Instance LifeCycle

+ (instancetype)instanceWithTarget:(id)target {
    StrategyProxy *proxy = [StrategyProxy new];
    proxy.strategy = target;
    return proxy;
}

#pragma mark - SuperClass Override Methods

- (void)calcResultsForData:(id)data {
    
}

@end
