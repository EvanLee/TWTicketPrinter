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
#import "BarCodeParser.h"

NSDictionary *goodsInfoMap;

@interface GoodsPrinter ()

@property (nonatomic, assign) CGFloat total;
@property (nonatomic, assign) CGFloat saveTotal;

@property (nonatomic, strong) id<ISaleStrategy> saleCalculator;
@property (nonatomic, strong) id<IDataParser>   inputParser;

@property (nonatomic, strong) SaleFactory    *salefactory;
@property (nonatomic, strong) TicketOutputor *outputor;
@property (nonatomic, strong) NSArray        *goodsItemList;

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
        printer.inputParser = [BarCodeParser new];
        printer.salefactory = [SaleFactory new];
        printer.outputor    = [TicketOutputor new];
    });
    
    return printer;
}

#pragma mark - Public Methods

- (void)printList:(NSString *)jsonString {
    //解析
    [self.inputParser parse:jsonString error:nil];
    self.goodsItemList = [self.inputParser getResults];
    
    //处理，计算
    [self processList];
    
    //输出
    [self.outputor printAll];
}


- (void)processList {
    for (GoodsItem *item in self.goodsItemList) {
        [self getResultsForItem:item];
    }
}

- (void)getResultsForItem:(GoodsItem *)item {
    id<ISaleStrategy> calculator = [self.salefactory createInstanceForObject:item];
    [calculator calcResultsForData:item];
    
    self.total     += item.totalPrice;
    self.saveTotal += item.savePrice;
    
    [self.outputor add:item];
}

#pragma mark - Private Methods


@end
