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

@property (nonatomic, strong) NSArray<id<IPrintable>> *baseList;
@property (nonatomic, strong) NSMutableDictionary *extraMap;

@end

@implementation TicketOutputor

#pragma mark - Public Methods

- (void)addBaseData:(id<IPrintable>)printData {
    NSMutableArray *array = (NSMutableArray *)self.baseList;
    [array addObject:printData];
}

- (void)addExtraData:(id<IPrintable>)printExtraData forType:(NSString *)type {
    NSMutableArray<id<IPrintable>> *array = [self.extraMap objectForKey:type];
    
    if (!array) {
        array = [NSMutableArray<id<IPrintable>> array];
        [self.extraMap setValue:array forKey:type];
    }
    
    [array addObject:printExtraData];
}

- (void)printAllToString:(NSMutableString *)outputString {
    [outputString appendString:@"***<没钱赚商店>购物清单***\n"];

    [self printBaseInfoToString:outputString];
    [self printExtraInfoToString:outputString];
}

#pragma mark - Private Methods

- (void)printBaseInfoToString:(NSMutableString *)outputString {
    for (id<IPrintable> obj in self.baseList) {
        [outputString appendString:[obj printString]];
        [outputString appendString:@"\n"];
    }
    
    [self printEndSection:outputString];
}

- (void)printExtraInfoToString:(NSMutableString *)outputString {

    [self.extraMap enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *list, BOOL * _Nonnull stop) {
        [outputString appendString:[NSString stringWithFormat:@"%@:\n", key]];
        
        for (id<IPrintable> obj in list) {
            [outputString appendString:[obj printString]];
            [outputString appendString:@"\n"];
        }
        
        if (list && list.count) {
            [self printEndSection:outputString];
        }
    }];
}

- (void)printEndSection:(NSMutableString *)outputString {
    [outputString appendString:@"----------------------\n"];
}

#pragma mark - Getters & Setters

- (NSArray<id<IPrintable>> *)baseList {
    if (!_baseList) {
        _baseList = [NSMutableArray array];
    }
    return _baseList;
}

- (NSMutableDictionary *)extraMap {
    if (!_extraMap) {
        _extraMap = [NSMutableDictionary dictionary];
    }
    return _extraMap;
}

@end
