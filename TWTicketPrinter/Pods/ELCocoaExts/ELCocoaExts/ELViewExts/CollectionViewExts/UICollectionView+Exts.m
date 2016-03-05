//
//  UICollectionView+Exts.m
//  Example
//
//  Created by Evan on 15/12/17.
//  Copyright © 2015年 WewaySoft. All rights reserved.
//

#import "UICollectionView+Exts.h"

@implementation UICollectionView (Exts)

- (void)registerNibClass:(Class)className
{
    NSString *nibName = NSStringFromClass(className);
    [self registerNibName:nibName];
}

- (void)registerNibName:(NSString *)nibName bundle:(NSBundle *)bundleOrNil
{
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:nibName];
}

- (void)registerNibName:(NSString *)nibName
{
    [self registerNibName:nibName bundle:nil];
}

- (void)registerClass:(Class)cellClass
{
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (UICollectionViewCell *)dequeueReusableCellWithReuseClass:(Class)className
                                               forIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = NSStringFromClass(className);
    return [self dequeueReusableCellWithReuseIdentifier:name forIndexPath:indexPath];
}

@end
