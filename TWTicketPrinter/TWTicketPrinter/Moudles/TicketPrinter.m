//
//  GoodsPrinter.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "TicketPrinter.h"
#import <UIKit/UIKit.h>
#import "ISaleStrategy.h"
#import "SaleFactory.h"
#import "GoodsInfo.h"
#import "TicketOutputor.h"
#import "GoodsItem.h"
#import "BarCodeParser.h"
#import "IPrintable.h"
#import "IPrintStrategy.h"

@interface TicketPrinter ()

@property (nonatomic, assign) CGFloat total;
@property (nonatomic, assign) CGFloat saveTotal;

@property (nonatomic, strong) id<ISaleStrategy> saleCalculator;
@property (nonatomic, strong) id<IDataParser>   inputParser;

@property (nonatomic, strong) SaleFactory    *salefactory;
@property (nonatomic, strong) TicketOutputor *outputor;
@property (nonatomic, strong) NSArray        *goodsItemList;

@end

@implementation TicketPrinter

#pragma mark - Instance LifeCycle

+ (instancetype)defaultPrinter {
    static TicketPrinter *printer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        printer = [TicketPrinter new];
        printer.inputParser = [BarCodeParser new];
        printer.salefactory = [SaleFactory new];
        printer.outputor    = [TicketOutputor new];
    });
    
    return printer;
}

#pragma mark - Public Methods

- (NSString *)printTicketWithFileName:(NSString *)inputFileName {
    //解析
    [self.inputParser parse:inputFileName error:nil];
    self.goodsItemList = [self.inputParser getResults];
    
    //处理，计算
    [self processList];
    
    //输出
    NSMutableString *stringBuilder = [NSMutableString string];
    
    [self.outputor printAllToString:stringBuilder];
    [self printTotalTailToString:stringBuilder];
    
    return stringBuilder;
}

#pragma mark - Private Methods

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
    
    if ([calculator conformsToProtocol:@protocol(IPrintStrategy)]) {
        [self addPrintInfo:(id<IPrintStrategy>)calculator item:item];
    }
}

/**
 *  将打印信息
 *
 *  @param obj  <#obj description#>
 *  @param item <#item description#>
 */
- (void)addPrintInfo:(id<IPrintStrategy>)obj item:(GoodsItem *)item {
    id<IPrintable> printInfo = [obj printInfo:item];
    
    if (printInfo) {
        [self.outputor addBaseData:printInfo];
    }
    
    if ([obj respondsToSelector:@selector(printExtraInfo:)]) {
        id<IPrintable> extra = [obj printInfo:item];
        if (extra) {
            id <ISaleStrategy> s = (id <ISaleStrategy>) obj;
            [self.outputor addExtraData:extra forType:[s strategyDescription]];
        }
    }
}

- (void)printTotalTailToString:(NSMutableString *)stringBuilder {
    [stringBuilder appendString:[NSString stringWithFormat:@"总计：%.2f(元)\n", self.total]];
    
    if (self.saveTotal > 0) {
        [stringBuilder appendString:[NSString stringWithFormat:@"节省：%.2f(元)\n", self.saveTotal]];
    }
    [stringBuilder appendString:@"***********************\n"];
}


@end
