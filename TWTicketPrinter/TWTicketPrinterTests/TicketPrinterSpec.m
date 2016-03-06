//
//  TicketPrinterSpec.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "Kiwi.h"
#import "TicketPrinter.h"

SPEC_BEGIN (SaleTicketPrinterSpec1)

describe(@"SaleTicketSpec", ^{
    
    context(@"Give a Printer", ^{
        TicketPrinter *printer = [TicketPrinter defaultPrinter];
        
        it(@"Should be pass testing", ^{
            [[printer shouldNot] beNil];
            NSString *ret = [printer printTicketWithFileName:@"CodeInput"];
            
            NSLog(@"\n\n\n%@", ret);
        });
    });
});

SPEC_END
