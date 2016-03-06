//
//  GoodsItem.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class GoodsInfo;

@interface GoodsItem : NSObject

@property (nonatomic, copy, readonly) NSString   *barCode;
@property (nonatomic, copy, readonly) NSString   *unitsName;
@property (nonatomic, copy, readonly) NSString   *goodsName;

@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, assign, readonly) CGFloat    price;

@property (nonatomic, assign) CGFloat totalPrice;
@property (nonatomic, assign) CGFloat savePrice;

- (instancetype)initWithGoodsInfo:(GoodsInfo *)goods;

- (NSString *)barCode;

//叠加商品个数
- (void)addOne;
- (void)addWithCount:(NSUInteger)count;

@end
