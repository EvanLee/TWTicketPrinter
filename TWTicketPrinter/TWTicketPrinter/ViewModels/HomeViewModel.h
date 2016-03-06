//
//  HomeViewModel.h
//  TWTicketPrinter
//
//  Created by Evan on 16/3/6.
//  Copyright © 2016年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeViewModel : NSObject

@property (nonatomic, copy) NSString *text;

- (void)segmentChanged:(NSNumber *)idx;

@end
