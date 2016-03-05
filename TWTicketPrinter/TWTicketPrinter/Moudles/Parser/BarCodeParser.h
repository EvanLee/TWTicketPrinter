//
//  Parser.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  将输入的码进行建模转换
 */

@interface BarCodeParser : NSObject

- (void)parse:(id)data error:(NSError **)error;
- (id)getResults;

@end
