//
//  HomeViewModel.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "HomeViewModel.h"
#import "TicketPrinter.h"
#import "SaleFactory.h"

@interface HomeViewModel ()

@end

@implementation HomeViewModel

#pragma mark - Instance LifeCycle

- (instancetype)init {
    if (self = [super init]) {
    
    }
    
    return self;
}

#pragma mark - Public Methods 

- (void)segmentChanged:(NSNumber *)idx {
    TicketPrinter *printer = [TicketPrinter defaultPrinter];
    SaleFactory *factory   = [self getFactoryWithIdx:[idx integerValue]];

    if (factory) {
        //因为是演示，所以这里暂时用KeyPath设置
        [printer setValue:factory forKey:@"saleFactory"];
        self.text = [printer printTicketWithFileName:@"CodeInput"];
    } else {
        self.text = @"无法初始化工厂";
    }
}

#pragma mark - Private Methods

- (SaleFactory *)getFactoryWithIdx:(NSInteger)idx {

    NSString *fileName = nil;
    switch (idx) {
        case 0:
            fileName = @"SaleStrategies_Fee.plist";
            break;
        case 1:
            fileName = @"SaleStrategies_Rebate.plist";
            break;
        case 2:
            fileName = @"SaleStrategies_Both.plist";
            break;
        case 3:
            fileName = @"SaleStrategies_Normal.plist";
            break;
        case 4:
            fileName = @"SaleStrategies.plist";
            break;
            
        default:
            fileName = @"SaleStrategies_Both.plist";
            break;
    }
    
    return [[SaleFactory alloc] initWithFileName:fileName];
}




@end
