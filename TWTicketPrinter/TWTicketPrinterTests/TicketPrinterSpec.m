//
//  TicketPrinterSpec.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "Kiwi.h"
#import "TicketPrinter.h"
#import "SaleFactory.h"

SPEC_BEGIN (SaleTicketPrinterSpec)

describe(@"SaleTicketSpec", ^{
    
    context(@"Give a Printer", ^{
        TicketPrinter *printer = [TicketPrinter defaultPrinter];
        
        [printer stub:@selector(saleFactory)
            andReturn:[[SaleFactory alloc] initWithFileName:@"SaleStrategies_Fee.plist"]];
        
        it(@"Should be pass testing", ^{
            [[printer shouldNot] beNil];
            NSString *ret = [printer printTicketWithFileName:@"CodeInput"];
            
            NSLog(@"\n\n\n%@\n\n", ret);
            [[ret shouldNot] beNil];
            [[ret shouldNot] beEmpty];
        });
    });
});

SPEC_END
