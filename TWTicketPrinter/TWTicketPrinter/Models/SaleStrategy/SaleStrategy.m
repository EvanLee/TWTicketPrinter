//
//  SaleStrategy.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "SaleStrategy.h"
#import "JSONKeyMapper+MapExtentsion.h"

@implementation SaleStrategy

+ (JSONKeyMapper *)keyMapper {
    return [JSONKeyMapper mapperFromBigCamelCaseToLittleCamelCase];
}

@end
