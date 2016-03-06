//
//  SalesRebate.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ISaleStrategy.h"
#import "IPrintStrategy.h"

@interface SalesRebate : NSObject <ISaleStrategy, IPrintStrategy>

@property (nonatomic, assign, readonly) CGFloat rebate;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (instancetype)initWithRebate:(CGFloat)rebate;

@end
