//
//  UIViewController+Extensions.m
//  Example
//
//  Created by Evan on 13/10/23.
//  Copyright © 2013年 WewaySoft. All rights reserved.
//

#import "UIViewController+Exts.h"

@implementation UIViewController (Exts)

#pragma mark - Public Methods
+ (instancetype)controllerWithStoryboardName:(nonnull NSString *)name
                                  identifier:(nonnull NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
    if (!storyboard) {
        return nil;
    }
    
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

@end
