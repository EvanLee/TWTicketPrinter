//
//  Parser.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDataParser <NSObject>

@required
/**
 *  处理原始数据
 *
 *  @param data  data
 *  @param error error
 */

- (void)parse:(id)data error:(NSError **)error;

/**
 *  获取处理结果
 *
 *  @return BarCodeParser 这里返回列表
 */
- (id)getResults;


@end

/**
 *  将输入的码进行建模转换,并输出为整理后的购物清单
 */

@interface BarCodeParser : NSObject <IDataParser>


@end
