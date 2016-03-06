//
//  IPrintStrategy.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IPrintStrategy <NSObject>

@required
- (void)buildOutput:(id)output data:(id)data;

@end
