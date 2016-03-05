//
//  GoodsInfo.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "GoodsInfo.h"
#import "JSONKeyMapper+MapExtentsion.h"

@implementation GoodsInfo

+ (JSONKeyMapper *)keyMapper {
    return [JSONKeyMapper mapperFromBigCamelCaseToLittleCamelCase];
}

@end
