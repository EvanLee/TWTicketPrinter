//
//  TicketOutputer.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  TicketOutputor 专门负责打印
 */

@interface TicketOutputor : NSObject

/**
 *  打印所有的
 */
- (void)add:(id)data;
- (void)printAll;

@end
