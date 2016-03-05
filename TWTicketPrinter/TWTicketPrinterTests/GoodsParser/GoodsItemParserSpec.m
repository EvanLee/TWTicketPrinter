//
//  GoodsItemParser.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "Kiwi.h"
#import "ELCocoaExts.h"
#import "GoodsItem.h"
#import "BarCodeParser.h"

SPEC_BEGIN(GoodsItemParserSpec)

describe(@"Parser List", ^{
    context(@"Give a Json", ^{
        
        it(@"Should be parsed to GoodList", ^{
            NSString *fileName = @"CodeInput";
            NSError *err = nil;
            BarCodeParser * parser = [BarCodeParser new];
            [parser parse:fileName error:&err];
            
            [[theValue(err) should] beNil];
            NSArray<__kindof GoodsItem *> *list = [parser getResults];
        
            [[theValue(list.count) should] equal:@(3)];
            
            CGFloat allCount = 0;
            for (GoodsItem *item in list) {
                allCount += item.count;
            }
            
            [[theValue(allCount) should] equal:@(5)];
            
        });
    });
});



SPEC_END