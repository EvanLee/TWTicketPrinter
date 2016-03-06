//
//  TicketOutputer.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "TicketOutputor.h"
#import "IPrintable.h"

@interface TicketOutputor ()

@property (nonatomic, strong) NSMutableString *output;
@property (nonatomic, strong) NSArray<id<IPrintable>> *printList;
@property (nonatomic, strong) NSArray<id<IPrintable>> *extrasList;
@end

@implementation TicketOutputor

#pragma mark - Instance LifeCycle

- (instancetype)initWithOutput:(id)output {
    self = [super init];
    if (self) {
        self.output = output;
    }
    return self;
}

#pragma mark - Public Methods

- (void)add:(id)data {
    NSMutableArray *array = (NSMutableArray *)self.printList;
    [array addObject:nil];
}

- (void)printAll {
//    NSMutableString *results = [NSMutableString stringWithString:@"***<没钱赚商店>购物清单***\n"];
    
    if (!self.extrasList) {
        return;
    }
    
    for (id<IPrintable> obj in self.extrasList) {
        [self.output appendString:[obj printString]];
        [self.output appendString:@"\n"];
    }
    
    [self.output appendString:@"----------------------\n"];
}

#pragma mark - Private Methods

- (void)printGoodFee {
    for (id<IPrintable> obj in self.printList) {
        [self.output appendString:[obj printString]];
        [self.output appendString:@"\n"];
    }
    
    [self.output appendString:@"----------------------\n"];
}

#pragma mark - Getters & Setters

- (NSArray<id<IPrintable>> *)printList {
    if (!_printList) {
        _printList = [NSMutableArray array];
    }
    return _printList;
}

@end
