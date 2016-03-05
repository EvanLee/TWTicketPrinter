//
//  UICollectionView+Exts.h
//  Example
//
//  Created by Evan on 15/12/17.
//  Copyright © 2015年 WewaySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Exts)

/**
 *  注册Nib
 *
 *  @param name nibName
 */
- (void)registerNibClass:(Class)className;
- (void)registerNibName:(NSString *)nibName;
- (void)registerNibName:(NSString *)nibName bundle:(NSBundle *)bundleOrNil;

- (UICollectionViewCell *)dequeueReusableCellWithReuseClass:(Class)className
                                               forIndexPath:(NSIndexPath *)indexPath;

/**
 *  注册重用类，默认采用类名做reuser identfer
 *
 *  @param cellClass 类名
 */
- (void)registerClass:(Class)cellClass;

@end
