//
//  UITableView+Exts.h
//  Example
//
//  Created by Evan on 13/11/10.
//  Copyright © 2013年 WewaySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Exts)

/**
 *  注册Nib
 *
 *  @param name nibName
 */
- (void)registerNibClass:(Class)className;
- (void)registerNibName:(NSString *)nibName;
- (void)registerNibName:(NSString *)nibName bundle:(NSBundle *)bundleOrNil;

- (void)registerHeaderFooterNibClass:(Class)className;
- (void)registerHeaderFooterNibName:(NSString *)nibName;
- (void)registerHeaderFooterClass:(Class)cellClass;

/**
 *  注册重用类，默认采用类名做reuser identfer
 *
 *  @param cellClass 类名
 */
- (void)registerClass:(Class)cellClass;
- (UITableViewCell *)dequeueReusableCellWithReuseClass:(Class)className
                                          forIndexPath:(NSIndexPath *)indexPath;

@end
