//
//  TicketOutputer.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  OutputBuilder 专门负责打印， 我将打印的内容划分为了2部分，(BaseData 和 ExtraData)
 *  BaseData 认为是打印出所有的商品列表的小计。
 *  ExtraData是比较特别的附带信息， 比如：买二送一的，赠送的部分详细信息 （把这一部分写通用，有利于扩展）
 */

@interface OutputBuilder : NSObject

/**
 *  打印所有的商品信息，但是不包括 “买二送一” 如：赠送详情，这些额外的信息。
 */
- (void)addBaseData:(NSString *)baseString;

/**
 *  这个方法打印较特别的附带信息，这样做是为了利于需求扩展
 *
 *  @param printExtraData 
 */
- (void)addExtraData:(NSString *)extraString forType:(NSString *)type;

/**
 *  write 方法，向流里面写入数据
 */
- (void)beginWrite;
- (void)endWrite;

- (void)writeNewLine;
- (void)writeEndSection;
- (void)writeString:(NSString *)string;

- (NSString *)getResultString;

@end
