//
//  GoodsFeeExtraPrinter.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPrintable.h"

@interface GoodsFeeExtraPrinter : NSObject<IPrintable>

- (instancetype)initWithTarget:(id)obj;

@end
