//
//  GoodsFeeExtraPrinter.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "GoodsFeeExtraPrinter.h"
#import "GoodsItem.h"

@interface GoodsFeeExtraPrinter ()

@property (nonatomic, strong) GoodsItem *item;

@end

@implementation GoodsFeeExtraPrinter

- (instancetype)initWithTarget:(id)obj {
    self = [super init];
    if (self) {
        self.item = obj;
    }
    return self;
}

- (NSString *)printString {
    return [NSString stringWithFormat:@"名称：%@, 数量：%@",
            self.item.goodsName,
            [NSString stringWithFormat:@"%ld%@", self.item.count, self.item.unitsName]];
}

@end
