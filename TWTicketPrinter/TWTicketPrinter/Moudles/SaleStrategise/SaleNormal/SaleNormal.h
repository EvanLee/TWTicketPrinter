//
//  SaleNormal.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISaleStrategy.h"
#import "IPrintStrategy.h"

@interface SaleNormal : NSObject <ISaleStrategy, IPrintStrategy>

@end
