//
//  GoodsInfo.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSONModel.h"

/**
 *  商品的基本信息
 */

@interface GoodsInfo : JSONModel

@property (nonatomic, copy) NSString *goodName;      //商品名称
@property (nonatomic, copy) NSString *barCode;      //条形码
@property (nonatomic, copy) NSString *unitsName;    //单位名称

@property (nonatomic, assign) CGFloat price;        //单价

@end
