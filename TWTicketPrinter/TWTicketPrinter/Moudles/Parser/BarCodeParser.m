//
//  Parser.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "BarCodeParser.h"
#import "ELCocoaExts.h"
#import "GoodsInfo.h"
#import "GoodsItem.h"

NSString * const Goods_DS_File = @"Goods.plist";

@interface BarCodeParser ()

@property (nonatomic, strong) NSArray      *itemList;
@property (nonatomic, strong) NSDictionary *goodsMap;  //所有商品的Map

@end

@implementation BarCodeParser


#pragma mark - Public Methods

- (void)parse:(id)data error:(NSError **)error {
    NSCParameterAssert([data isKindOfClass:[NSString class]]);
    self.itemList = nil;
    
    NSString *jsonString = [self readJsonFromCache:data];
    
    if ([NSString isNullOrEmpty:jsonString]) {
        [self fireErrorWithFailureReson:@"无法读取Json文件!" error:error];
        return;
    }
    
    NSArray *list = [self parseJosnString:jsonString error:error];
    if (error && *error) {
        return;
    }
    
    self.itemList = list;
}

- (id)getResults {
    return self.itemList;
}


#pragma mark - Private Methods

- (NSString *)readJsonFromCache:(NSString *)fileName {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".json"];
    
    return [NSString stringWithContentsOfFile:jsonPath
                                     encoding:NSUTF8StringEncoding
                                        error:nil];
}


- (NSArray *)parseJosnString:(NSString *)jsonString error:(NSError * __autoreleasing *)error {
    NSArray<NSString *> *array  = [jsonString toJSONValue];
    
    if (!array) {
        [self fireErrorWithFailureReson:jsonString error:error];
        return nil;
    }

    return [self buyListFromBarCodeList:array];
}

- (void)fireErrorWithFailureReson:(NSString *)reson error:(NSError * __autoreleasing *)error {
    if (!error) {
        return;
    }
    
    *error = [NSError errorWithFailureReason:reson];
}

/**
 *  将商品码列表转换为购买清单
 *
 *  @param array 商品扫描码列表
 *
 *  @return 购买清单列表
 */
- (NSArray *)buyListFromBarCodeList:(NSArray *)array  {
    NSMutableArray<GoodsItem *> *buyList  = [NSMutableArray<GoodsItem *> array];//输出的清单列表
    NSMutableArray<NSString *>  *orderBuy = [NSMutableArray<NSString *> array];//转换的过程中保证顺序
    NSMutableDictionary       *tempBuyMap = [NSMutableDictionary dictionary];
    
    [self configureBuyMapWithArray:array outOrder:orderBuy outBuyMap:tempBuyMap];
    
    [orderBuy enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [buyList addObject:tempBuyMap[obj]];
    }];
    
    return buyList;
}

/**
 *  将商品扫描码列表转换为 BuyMap
 *
 *  @param array 商品扫描码列表
 *
 *  @return BuyMap
 */
-  (void)configureBuyMapWithArray:(NSArray *)array
                         outOrder:(NSMutableArray *)outOrder
                        outBuyMap:(NSMutableDictionary *)outBuyMap {
    
    @weakify(self);
    [array enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        @strongify(self);
        [self addItemToBuyMap:outBuyMap outOrder:outOrder forBarCode:obj];
    }];
}

- (void)addItemToBuyMap:(NSMutableDictionary *)buyMap
              outOrder:(NSMutableArray *)outOrder
             forBarCode:(NSString *)barCode {
    NSArray *complex = [barCode componentsSeparatedByString:@"-"];
    NSString *standardCode = complex[0]; //获取标准码
    NSUInteger count = complex.count > 1 ? (NSUInteger)[complex[1] integerValue] : 1;
    
    GoodsItem *item = [buyMap objectForKey:standardCode];
    
    if (!item) {
        GoodsInfo *info = [self.goodsMap objectForKey:standardCode];
        if (!info) {
            return;
        }
        item = [[GoodsItem alloc] initWithGoodsInfo:info];
        [buyMap setValue:item forKey:standardCode];
        [outOrder addObject:standardCode];
    }
    
    [item addWithCount:count];
}

/**
 *  生成所有商品信息的列表，供以后查询
 *
 *  @return 所有商品的Map
 */

- (NSDictionary *)configureGoodsMap {
    NSString *path = [[NSBundle mainBundle] pathForResource:Goods_DS_File ofType:nil];
    
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    NSArray *goodsOfAll           = [NSArray arrayWithContentsOfFile:path];
    NSError *error                = nil;
    
    for (NSDictionary *dic in goodsOfAll) {
        GoodsInfo *gInfo = [[GoodsInfo alloc] initWithDictionary:dic error:&error];
        if (error) {
            NSLog(@"转换 GoodsInfo 失败");
            return nil;
        }
        
        [tempDict setValue:gInfo forKey:gInfo.barCode];
    }
    
    return tempDict;
}

#pragma mark - Getters & Setters

- (NSDictionary *)goodsMap {
    if (!_goodsMap) {
        _goodsMap = [self configureGoodsMap];
    }
    return _goodsMap;
}

@end
