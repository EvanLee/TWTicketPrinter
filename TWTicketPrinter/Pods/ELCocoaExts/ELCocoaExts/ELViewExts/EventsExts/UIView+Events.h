//
//  UIView+Events.h
//  ELCocoaExts
//
//  Created by Evan on 13/9/24.
//  Copyright (c) 2013年 WewaySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Events)

- (void)setTapActionWithBlock:(void (^)(UIView * view))block;
- (void)setLongPressActionWithBlock:(void (^)(UIView * view))block;

@end
