//
//  SaleFactory.m
//  TWTicketPrinter
//
//  Created by Evan on 16/3/5.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import "SaleFactory.h"
#import "SaleStrategy.h"
#import "GoodsItem.h"
#import "SaleNormal.h"
#import "StrategyProxy.h"

@interface SaleFactory ()

@property (nonatomic, strong) NSString *fileName;

//存放所有的strategy 的缓存 即：NSDictionary<strategyName, strategyInstances>
@property (nonatomic, strong) NSDictionary *strategyCache;

//商品和他对应要用到的策略类,即:NSDictionary<barcode, list<strategyInstances>>
@property (nonatomic, strong) NSDictionary *goodsStrategyMap;

@end

@implementation SaleFactory

#pragma mark - Instance LifeCycle

- (instancetype)init {
    if (self = [super init]) {
    
    }
    
    return self;
}

- (instancetype)initWithFileName:(NSString *)strategyFileName {
    if (self = [super init]) {
        self.fileName = strategyFileName;
        [self configureMaps];
    }
    
    return self;
}


#pragma mark - ISaleStrategy 接口

- (id<ISaleStrategy>)createInstanceForObject:(GoodsItem *)item {
    NSString *barCode   = [item barCode];
    NSArray *strategies = [self.goodsStrategyMap objectForKey:barCode]; //同一个商品会有多种优惠

    if (!strategies || !strategies.count ) {
        return [SaleNormal new];
    }
    
    /**
     *  思考：本来是打算用一个简单的享元模式, 直接在Map中取一个策略返回。但实际情况是，各种策略之间还有各种关系。
     *  如，组合关系，先后顺序关系等，他们之间的关系组成可能多变，复杂。所以，为满足单一职责原则，这里需要把职责分离出去！
     *  但是返回又必须是一个策略接口，所以选择代理模式
     *
     */
    
    return [StrategyProxy instanceWithTarget:strategies];
}


#pragma mark - Private Methods

/**
 *  将策略信息从内存文件中读出来， 并转化为2个map
 */
- (void)configureMaps {
    NSString *urlPath  = [[NSBundle mainBundle] pathForResource:self.fileName ofType:nil];
    NSArray  *array    = [NSArray arrayWithContentsOfFile:urlPath];
    
    NSCParameterAssert(urlPath);
    NSCParameterAssert(array);

    self.goodsStrategyMap = [NSMutableDictionary dictionary];
    self.strategyCache    = [NSMutableDictionary dictionary];
    
    for (NSDictionary *dic in array) {
       SaleStrategy *strategy = [[SaleStrategy alloc] initWithDictionary:dic error:nil];

        if (strategy) {
            NSArray<NSString *> *products = strategy.products;
            
            //分类，生成 goodsStrategyMap
            for (NSString *barCode in products) {
                [self configureGoodsStrategyMap:(NSMutableDictionary *)self.goodsStrategyMap
                                     forBarCode:barCode
                                   saleStrategy:strategy];
            }
        }
    }
}

- (void)configureGoodsStrategyMap:(NSMutableDictionary *)map
                       forBarCode:(NSString *)barCode
                     saleStrategy:(SaleStrategy *)info {
    NSMutableArray *strategys = [map objectForKey:barCode];
    
    if (!strategys) { //添加商品到map
        strategys = [NSMutableArray array];
        [map setValue:strategys forKey:barCode];
    }

    //从缓存中读取/构造，策略对象
    id<ISaleStrategy> sales = [self strategyFromCache:info];
    
    if (sales) {   //添加商品策略到list中
        [strategys addObject:sales];
    }
}

- (id<ISaleStrategy>)strategyFromCache:(SaleStrategy *)strategyInfo {
    NSCParameterAssert(strategyInfo.className);
    NSCParameterAssert(strategyInfo.saleName);
    
    NSString *className = strategyInfo.className;
    NSString *saleName  = strategyInfo.saleName;
    id<ISaleStrategy> s = [self.strategyCache objectForKey:saleName];
    
    if (!s) {//反射创建对象
        Class cls = NSClassFromString(className);
        
        if (cls != Nil && [cls conformsToProtocol:@protocol(ISaleStrategy)]) {
            s = [[cls alloc] initWithDict:strategyInfo.paramters];
            [self.strategyCache setValue:s forKey:saleName];
            [((id <ISaleStrategy>)s) setStrategyDescription:saleName];
        } else {
            NSLog(@"--找不到类:%@ ", className);
        }
    }
    
    return s;
}


@end
