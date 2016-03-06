//
//  SaleStrategy.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SaleStrategy : JSONModel

@property (nonatomic, copy) NSString *saleName;      //策略的描述名称
@property (nonatomic, copy) NSString *className;     //策略的类名

@property (nonatomic, strong) NSArray<NSString *> *products;      //支持该策略的单价
@property (nonatomic, strong) NSDictionary        *paramters;     //策略的初始化参数


@end
