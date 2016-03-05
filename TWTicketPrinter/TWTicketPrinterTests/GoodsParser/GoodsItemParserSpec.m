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
    context(@"Give a Json File", ^{
        
        it(@"Should be parsed to GoodList", ^{
            NSString *fileName = @"CodeInput";
            NSError *err = nil;
            BarCodeParser * parser = [BarCodeParser new];
            [parser parse:fileName error:&err];
            
            [[err should] beNil];
            
            NSArray<__kindof GoodsItem *> *list = [parser getResults];
            
            [[list shouldNot] beNil];
            [[theValue(list.count) should] equal:theValue(3)];

            [[theValue(list[0].count) should] equal:theValue(5)];
            [[theValue(list[1].count) should] equal:theValue(2)];
            [[theValue(list[2].count) should] equal:theValue(3)];
        });
    });
});



SPEC_END