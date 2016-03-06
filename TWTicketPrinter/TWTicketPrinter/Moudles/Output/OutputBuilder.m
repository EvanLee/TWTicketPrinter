//
//  TicketOutputer.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "OutputBuilder.h"
#import "IPrintable.h"
#import "ELCocoaExts.h"

@interface OutputBuilder ()

@property (nonatomic, strong) NSArray<NSString *> *baseList;
@property (nonatomic, strong) NSMutableDictionary *extraMap;
@property (nonatomic, strong) NSMutableString *outputString;

@end

@implementation OutputBuilder

#pragma mark - Instance LifeCycle

- (instancetype)init {
    if (self = [super init]) {
        _outputString = [NSMutableString string];
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)addBaseData:(NSString *)baseString {
    NSMutableArray *array = (NSMutableArray *)self.baseList;
    [array addObject:baseString];
}

- (void)addExtraData:(NSString *)extraString forType:(NSString *)type {
    NSMutableArray<NSString *> *array = [self.extraMap objectForKey:type];
    
    if (!array) {
        array = [NSMutableArray<NSString *> array];
        [self.extraMap setValue:array forKey:type];
    }
    
    [array addObject:extraString];
}

- (NSString *)getResultString {
//    [outputString appendString:@"***<没钱赚商店>购物清单***\n"];

    [self buildBaseData];
    [self buildExtraData];
    
    return [self.outputString copy];
}

#pragma mark - Private Methods

- (void)buildBaseData {
    for (NSString *string in self.baseList) {
        [self writeString:string];
        [self writeNewLine];
    }
    
    [self writeEndSection];
}

- (void)buildExtraData {
    if (!self.extraMap || !self.extraMap.count) {
        return;
    }
    
    @weakify(self);
    [self.extraMap enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *list, BOOL * _Nonnull stop) {
        @strongify(self);
        [self writeString:[NSString stringWithFormat:@"%@:\n", key]];
        
        for (NSString *obj in list) {
            [self writeString:obj];
            [self writeNewLine];
        }
        
        if (list && list.count) {
            [self writeEndSection];
        }
    }];
}

- (void)writeEndSection {
    [self.outputString appendString:@"----------------------\n"];
}

- (void)writeNewLine {
    [self.outputString appendString:@"\n"];
}

- (void)writeString:(NSString *)string {
    [self.outputString appendString:string];
}

#pragma mark - Getters & Setters

- (NSArray<NSString *> *)baseList {
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
