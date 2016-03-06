//
//  IPrintStrategy.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IPrintable;

@protocol IPrintStrategy <NSObject>

@required
- (id<IPrintable>)printInfo:(id)data;

@optional
- (id<IPrintable>)printExtraInfo:(id)data;

@end
