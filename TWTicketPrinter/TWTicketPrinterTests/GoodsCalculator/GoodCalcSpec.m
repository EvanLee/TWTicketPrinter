//
//  GoodCalcSpec.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "Kiwi.h"
#import "ELCocoaExts.h"
#import "GoodsItem.h"
#import "BarCodeParser.h"
#import "GoodsInfo.h"
#import "SaleNormal.h"
#import "SalesRebate.h"
#import "SalesFeeGoods.h"

SPEC_BEGIN(GoodsCalcSpec123)

describe(@"StrategyTest", ^{
    
    context(@"Give a SalesRebate", ^{
        //九折优惠
        id<ISaleStrategy> ss = [[SalesRebate alloc] initWithRebate:9];
    
        GoodsInfo *info = [GoodsInfo new];
        info.goodsName = @"苹果";
        info.unitsName = @"个";
        info.price     = 6.0;

        GoodsItem *item = [[GoodsItem alloc] initWithGoodsInfo:info];
        [item addWithCount:5];
        
        it(@"SalesRebate Should Pass Testing", ^{
            [ss calcResultsForData:item];
            [[theValue(item.totalPrice) should] equal:theValue(27)];
            [[theValue(item.savePrice)  should] equal:theValue(3)];
        });
    });
    
    context(@"Give a SalesFeeGoods", ^{
        //买三送一
        id<ISaleStrategy> ss = [[SalesFeeGoods alloc] initWithNeedsNumber:3 feeNumber:1];
        
        GoodsInfo *info = [GoodsInfo new];
        info.goodsName = @"可口可乐";
        info.unitsName = @"瓶";
        info.price     = 6.0;
        
        GoodsItem *item = [[GoodsItem alloc] initWithGoodsInfo:info];
        [item addWithCount:5];
        
        it(@"SalesFeeGoods Should Pass Testing", ^{
            [ss calcResultsForData:item];
            [[theValue(item.totalPrice) should] equal:theValue(24)];
            [[theValue(item.savePrice)  should] equal:theValue(6)];
        });
    });
    
    context(@"Give a NormalSale", ^{
        id<ISaleStrategy> ss = [SaleNormal new];
        
        GoodsInfo *info = [GoodsInfo new];
        info.goodsName = @"羽毛球";
        info.unitsName = @"个";
        info.price     = 6.0;
        
        GoodsItem *item = [[GoodsItem alloc] initWithGoodsInfo:info];
        [item addWithCount:5];
        
        it(@"NormalSale Should Pass Testing", ^{
            [ss calcResultsForData:item];
            [[theValue(item.totalPrice) should] equal:theValue(30)];
        });
    });
});



SPEC_END