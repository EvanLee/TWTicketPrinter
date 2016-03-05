//
//  GoodsPrinter.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "GoodsPrinter.h"
#import <UIKit/UIKit.h>
#import "ISaleStrategy.h"
#import "SaleFactory.h"
#import "GoodsInfo.h"
#import "TicketOutputor.h"
#import "GoodsItem.h"

NSDictionary *goodsInfoMap;

@interface GoodsPrinter ()

@property (nonatomic, strong) NSMutableDictionary *buyMap;

@property (nonatomic, assign) CGFloat total;
@property (nonatomic, assign) CGFloat saveTotal;

@property (nonatomic, strong) id<ISaleStrategy> saleCalculator;

@property (nonatomic, strong) SaleFactory    *factory;
@property (nonatomic, strong) TicketOutputor *outputor;

@property (nonatomic, strong) NSArray *goodsItemList;

@end

@implementation GoodsPrinter

#pragma mark - Instance LifeCycle
+ (void)initialize {
    if (self == [GoodsPrinter class]) {
        goodsInfoMap = [NSMutableDictionary dictionary];
    }
}

+ (instancetype)defaultPrinter {
    static GoodsPrinter *printer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        printer = [GoodsPrinter new];
    });
    
    return printer;
}

#pragma mark - Public Methods

- (void)printList:(NSString *)jsonString {
    //解析 (需要重构)
    [self parseJosnString:jsonString];
    
    //处理，计算
    [self processList];
    
    //输出
    [self.outputor printAll];
}


- (void)processList {
    for (GoodsItem *item in self.goodsItemList) {
        [self processForItem:item];
    }
}

- (void)processForItem:(GoodsItem *)item {
    id<ISaleStrategy> calculator = [self.factory calculatorForGoods:item];
    [calculator calcResultsForData:item];
    
    self.total     += 0;
    self.saveTotal += 0.f;
    
    [self.outputor add:item];
}

#pragma mark - Private Methods

- (NSString *)readJsonFromCache:(NSString *)fileName {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".json"];
    
    return [NSString stringWithContentsOfFile:jsonPath
                                     encoding:NSUTF8StringEncoding
                                        error:nil];
}

- (void)parseJsonForFile:(NSString *)fileName {
    NSString * string = [self readJsonFromCache:fileName];
    [self parseJosnString:string];
}

- (NSArray *)parseJosnString:(NSString *)jsonString {
    //return [self.parser parser]
#warning Not implement
    return nil;
}


@end
