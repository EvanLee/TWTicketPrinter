//
//  TicketOutputer.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPrintable.h"

/**
 *  TicketOutputor 专门负责打印， 我将打印的内容划分为了2部分，(BaseData 和 ExtraData)
 *  BaseData 认为是打印出所有的商品列表的小计。（这一步是必须，只是他们现实的内容有点小小的不同）
 *  ExtraData是比较特别的附带信息， 比如：买二送一的，赠送的部分详细信息 （把这一部分写通用，有利于扩展）
 */

@interface TicketOutputor : NSObject

/**
 *  打印所有的商品信息，但是不包括 “买二送一” 如：赠送详情，这些额外的信息。
 */
- (void)addBaseData:(id<IPrintable>)printData;

/**
 *  这个方法打印较特别的附带信息，这样做是为了利于需求扩展
 *
 *  @param printExtraData 
 */
- (void)addExtraData:(id<IPrintable>)printExtraData forType:(NSString *)type;

- (void)printAllToString:(NSMutableString *)outputString;

@end
