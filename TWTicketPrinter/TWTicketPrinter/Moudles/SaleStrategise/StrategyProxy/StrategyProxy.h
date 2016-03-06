//
//  FactoryProxy.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISaleStrategy.h"
#import "IPrintStrategy.h"

/**
 *  策略类的，代理模式。 这是个标准代理，所以必须 和被代理者继承相同的接口。
 */
@interface StrategyProxy : NSObject <ISaleStrategy, IPrintStrategy>

+ (instancetype)instanceWithTarget:(id)target;

@end
