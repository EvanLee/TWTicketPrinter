//
//  UIView+Layout.m
//  ELViewExt
//
//  Created by Evan on 13/9/18.
//  Copyright (c) 2013年 WewaySoft. All rights reserved.
//

#import "UIView+Layout.h"

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newRect = CGRectZero;
    newRect.origin.x = center.x - CGRectGetMidX(rect);
    newRect.origin.y = center.y - CGRectGetMidY(rect);
    newRect.size = rect.size;
    return newRect;
}

CGRect CGRectMakeBySize(CGPoint origin, CGSize size)
{
    return (CGRect){origin, size};
}

@implementation UIView (Layout)

#pragma mark - Public Methods
- (void)sizeEqualToView:(UIView *)view
{
    self.frame = CGRectMake(self.left, self.top, view.width, view.height);
}

- (void)fillWidth
{
    self.width = self.superview.width;
}

- (void)fillHeight
{
    self.height = self.superview.height;
}

- (void)fill
{
    self.frame = CGRectMake(0, 0, self.superview.width, self.superview.height);
}

- (UIView *)topSuperView
{
    UIView *topSuperView = self.superview;
    
    if (topSuperView == nil) {
        topSuperView = self;
    } else {
        while (topSuperView.superview) {
            topSuperView = topSuperView.superview;
        }
    }
    
    return topSuperView;
}


#pragma mark - Getters & Setters

- (CGPoint)bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

- (CGPoint)topLeft
{
    return self.frame.origin;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)aPoint
{
    CGRect newFrame = self.frame;
    newFrame.origin = aPoint;
    self.frame = newFrame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize
{
    CGRect newFrame = self.frame;
    newFrame.size = aSize;
    self.frame = newFrame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newHeight
{
    CGRect newFrame = self.frame;
    newFrame.size.height = newHeight;
    self.frame = newFrame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newWidth
{
    CGRect newFrame = self.frame;
    newFrame.size.width = newWidth;
    self.frame = newFrame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newTop
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = newTop;
    self.frame = newFrame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newLeft
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = newLeft;
    self.frame = newFrame;
}

- (CGFloat)x
{
    return self.left;
}

- (void)setX:(CGFloat)x
{
    self.left = x;
}

- (CGFloat)y
{
    return self.top;
}

- (void)setY:(CGFloat)y
{
    self.top = y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)newBottom
{
    CGRect oldFrame = self.frame;
    
    CGFloat newHeight = newBottom -  oldFrame.origin.y;
    if (newHeight < 0) {
        return;
    }
    [self setSize:CGSizeMake(self.width, newHeight)];
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)newRight
{
    CGFloat delta = newRight - (self.frame.origin.x + self.frame.size.width);
    CGRect newFrame = self.frame;
    newFrame.origin.x += delta ;
    self.frame = newFrame;
}

- (CGFloat)centerX
{
    CGRect viewFrame = self.frame;
    return viewFrame.origin.x + viewFrame.size.width / 2.f;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGRect viewFrame = self.frame;
    viewFrame.origin.x = centerX - viewFrame.size.width / 2.f;
    
    self.frame = viewFrame;
}

- (CGFloat)centerY
{
    CGRect viewFrame = self.frame;
    return viewFrame.origin.y + viewFrame.size.height / 2.f;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = centerY - viewFrame.size.height / 2.f;
    
    self.frame = viewFrame;
}

@end
