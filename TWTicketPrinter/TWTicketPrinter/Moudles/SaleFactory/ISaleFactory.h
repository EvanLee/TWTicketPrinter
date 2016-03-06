//
//  ISaleFactory.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISaleStrategy;

@protocol ISaleFactory <NSObject>

- (id<ISaleStrategy>)createInstanceForObject:(id)object;

@end
