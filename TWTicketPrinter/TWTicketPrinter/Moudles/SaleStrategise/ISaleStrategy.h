//
//  ISaleStrategy.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISaleStrategy <NSObject>

@required
- (void)calcResultsForData:(id)data;

@end
