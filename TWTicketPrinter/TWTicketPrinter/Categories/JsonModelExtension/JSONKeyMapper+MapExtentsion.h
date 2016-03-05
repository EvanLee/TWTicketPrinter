//
//  JSONKeyMapper+MapExtentsion.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JSONKeyMapper (MapExtentsion)

/**
 *  将大驼峰命名规则转换为小驼峰命名规则
 *   eg: MyCase-->myCase
 *
 *  @return JSONKeyMapper Instance
 */
+ (instancetype)mapperFromBigCamelCaseToLittleCamelCase;

/**
 *  将大驼峰命名规则转换为小驼峰命名规则
 *
 *  @param map 字典包含的字段，保持和原样输出，不做转换
 *
 *  @return JSONKeyMapper Instance
 */
+ (instancetype)mapperFromBigCamelCaseToLittleCamelCaseWithMap:(NSDictionary *)map;


@end
