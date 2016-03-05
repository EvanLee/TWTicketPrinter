//
//  UIViewController+Extensions.h
//  Example
//
//  Created by Evan on 13/10/23.
//  Copyright © 2013年 WewaySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Exts)

+ (instancetype)controllerWithStoryboardName:(NSString *)name identifier:(NSString *)identifier;

@end
