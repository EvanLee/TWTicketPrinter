//
//  GoodsPrinter.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  小票打印类，外观模式
 */

@interface GoodsPrinter : NSObject

- (NSString *)printList:(NSString *)jsonString;

@end
