//
//  UIView+Effects.m
//  ELCocoaExts
//
//  Created by Evan on 13/9/25.
//  Copyright (c) 2013年 WewaySoft. All rights reserved.
//

#import "UIView+Effects.h"
#import <objc/runtime.h>
#import "UIView+Events.h"

#define DARKENVIEW_TAG 8989898

char DarkenViewKey;

@implementation UIView (Effects)

#pragma mark - Public Methods

- (void)addShadowWithOffset:(CGSize)offset
                      color:(nonnull UIColor *)color
                    opacity:(CGFloat)opacity
{
    [self removeShadow];
    [self addShadowWithOffset:offset cornerRadius:0.f color:color opacity:opacity];
}

- (void)addShadowWithOffset:(CGSize)offset
               cornerRadius:(CGFloat)radius
                      color:(nonnull UIColor *)color
                    opacity:(CGFloat)opacity
{
    UIBezierPath *shadowPath = radius <= 0.f ?
                                [UIBezierPath bezierPathWithRect:self.bounds] :
                                [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowPath = shadowPath.CGPath;
}

- (void)removeShadow
{
    self.layer.masksToBounds = YES;
    self.layer.shadowOpacity = 1.f;
    self.layer.shadowPath = nil;
}

- (void)addCornersRadius:(CGFloat)radius forCorners:(UIRectCorner)corners
{
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                           byRoundingCorners: corners
                                                 cornerRadii:CGSizeMake(radius, radius)].CGPath;
    
    self.layer.mask = maskLayer;
}

+ (UIView *)darkenViewForRect:(CGRect)rect
{
    UIView *darkenView = [[UIView alloc] initWithFrame:rect];
    [darkenView setBackgroundColor:[UIColor colorWithWhite:.1f alpha:0.5f]];
    darkenView.tag = DARKENVIEW_TAG;
    darkenView.alpha = 0.f;
    
    return darkenView;
}

- (void)addDarkenViewAnimate:(BOOL)animate
{
    [self addDarkenViewAnimate:animate forRect:self.bounds onTaped:nil];
}

- (void)addDarkenViewAnimate:(BOOL)animate onTaped:(void (^)(UIView *))block
{
    [self addDarkenViewAnimate:animate forRect:self.bounds onTaped:block];
}

- (void)addDarkenViewAnimate:(BOOL)animate forRect:(CGRect)rect onTaped:(void (^)(UIView *view))block
{
    UIView *darkenView = self.darkenView;

    if (!darkenView) {
        darkenView = [self.class darkenViewForRect:rect];
        [self addSubview:darkenView];
        self.darkenView = darkenView;
    }
    
    [darkenView setTapActionWithBlock:block];
    darkenView.frame = rect;
    
    if (animate) {
        [UIView animateWithDuration:.3
                         animations:^{
                             darkenView.alpha = 1.f;
                         } completion:nil];
    } else {
        darkenView.alpha = 1.f;
    }
}

- (void)removeDarkenViewAnimate:(BOOL)animate
{
    if (!self.darkenView) {
        return;
    }
    
    if (!animate) {
        [self.darkenView removeFromSuperview];
        self.darkenView = nil;
    } else {
        __typeof (&*self) __weak weakSelf = self;
        [UIView animateWithDuration:.3
                         animations:^{
                             weakSelf.darkenView.alpha = 0.f;
                         } completion:^(BOOL finished) {
                             [weakSelf.darkenView removeFromSuperview];
                             weakSelf.darkenView = nil;
                         }];
    }
}


#pragma mark - Private Methods
- (void)setDarkenView:(UIView *)darkenView
{
    objc_setAssociatedObject(self,
                             &DarkenViewKey,
                             darkenView,
                             OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)darkenView
{
   return  objc_getAssociatedObject(self, &DarkenViewKey);
}

@end
