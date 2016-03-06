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
#import "OutputBuilder.h"
#import "GoodsItem.h"
#import "BarCodeParser.h"
#import "IPrintStrategy.h"

@interface TicketPrinter ()

@property (nonatomic, assign) CGFloat total;
@property (nonatomic, assign) CGFloat saveTotal;

@property (nonatomic, strong) id<ISaleStrategy> saleCalculator;
@property (nonatomic, strong) id<IDataParser>   inputParser;

@property (nonatomic, strong) SaleFactory    *saleFactory;
@property (nonatomic, strong) OutputBuilder  *outputor;
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
        printer.outputor    = [OutputBuilder new];
    });
    
    return printer;
}

#pragma mark - Public Methods

- (NSString *)printTicketWithFileName:(NSString *)inputFileName {
    //解析
    self.saveTotal = self.total = 0.f;
    [self.inputParser parse:inputFileName error:nil];
    self.goodsItemList = [self.inputParser getResults];
    
    //处理，计算
    [self processList];
    
    //输出
    [self.outputor beginWrite];
    [self writeTicketEnd];
    [self.outputor endWrite];
    
    return [self.outputor getResultString];
}

#pragma mark - Private Methods

- (void)processList {
    for (GoodsItem *item in self.goodsItemList) {
        [self getResultsForItem:item];
    }
}

- (void)getResultsForItem:(GoodsItem *)item {
    id<ISaleStrategy> calculator = [self.saleFactory createInstanceForObject:item];
    [calculator calcResultsForData:item];
    
    self.total     += item.totalPrice;
    self.saveTotal += item.savePrice;
    
    if ([calculator conformsToProtocol:@protocol(IPrintStrategy)]) {
        id<IPrintStrategy> printer = ((id<IPrintStrategy>)calculator);
        [printer buildOutput:self.outputor data:item];
    }
}

- (void)writeTicketEnd {
    [self.outputor writeString:[NSString stringWithFormat:@"总计：%.2f(元)\n", self.total]];
    if (self.saveTotal > 0) {
        [self.outputor writeString:[NSString stringWithFormat:@"节省：%.2f(元)\n", self.saveTotal]];
    }
    
    [self.outputor writeString:@"***********************\n"];
}


#pragma mark - Getters & Setters

- (SaleFactory *)saleFactory {
    if (!_saleFactory) {
        _saleFactory  = [[SaleFactory alloc] initWithFileName:@"SaleStrategies.plist"];
    }
    
    return _saleFactory;
}

@end
