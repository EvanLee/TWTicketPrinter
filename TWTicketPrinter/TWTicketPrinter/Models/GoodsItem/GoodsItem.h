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

@property (nonatomic, assign, readonly) NSUInteger count;

@property (nonatomic, assign) CGFloat totalPrice;
@property (nonatomic, assign) CGFloat savePrice;

- (instancetype)initWithGoodsInfo:(GoodsInfo *)goods;

//叠加商品个数
- (void)addOne;
- (void)addWithCount:(NSUInteger)count;

@end
