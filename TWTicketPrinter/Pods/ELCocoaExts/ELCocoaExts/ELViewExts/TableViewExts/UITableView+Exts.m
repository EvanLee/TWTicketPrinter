//
//  UITableView+Exts.m
//  Example
//
//  Created by Evan on 13/11/10.
//  Copyright © 2013年 WewaySoft. All rights reserved.
//

#import "UITableView+Exts.h"

@implementation UITableView (Exts)

#pragma mark - Public Methods

- (void)registerNibClass:(Class)className
{
    NSString *nibName = NSStringFromClass(className);
    [self registerNibName:nibName];
}

- (void)registerHeaderFooterNibClass:(Class)className
{
    NSString *nibName = NSStringFromClass(className);
    
    [self registerHeaderFooterNibName:nibName];
}

- (void)registerHeaderFooterNibName:(NSString *)nibName
{
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forHeaderFooterViewReuseIdentifier:nibName];
}

- (void)registerHeaderFooterClass:(Class)cellClass
{
    [self registerClass:cellClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerNibName:(NSString *)nibName bundle:(NSBundle *)bundleOrNil
{
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

- (void)registerNibName:(NSString *)nibName
{
    [self registerNibName:nibName bundle:nil];
}

- (void)registerClass:(Class)cellClass
{
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}


- (UITableViewCell *)dequeueReusableCellWithReuseClass:(Class)className
                                               forIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = NSStringFromClass(className);
    return [self dequeueReusableCellWithIdentifier:name forIndexPath:indexPath];
}

@end
