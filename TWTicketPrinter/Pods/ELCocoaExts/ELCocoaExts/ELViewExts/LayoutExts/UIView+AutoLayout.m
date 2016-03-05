//
//  UIView+AutoLayout.m
//  ELViewExt
//
//  Created by Evan on 13/10/13.
//  Copyright © 2013年 WewaySoft. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

- (void)updateConstraintsAndLayoutImmediately
{
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
