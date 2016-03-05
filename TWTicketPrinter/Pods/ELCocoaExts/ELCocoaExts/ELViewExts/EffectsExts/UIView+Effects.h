//
//  UIView+Effects.h
//  ELCocoaExts
//
//  Created by Evan on 13/9/25.
//  Copyright (c) 2013年 WewaySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Effects)

@property (nonatomic, weak, readonly) UIView *darkenView;

- (void)addShadowWithOffset:(CGSize)offset
                      color:(UIColor *)color
                    opacity:(CGFloat)opacity;

- (void)addShadowWithOffset:(CGSize)offset
                         cornerRadius:(CGFloat)radius
                      color:(UIColor *)color
                    opacity:(CGFloat)opacity;

- (void)removeShadow;

/**
 *  可以为某个角添加圆角
 *
 *  @param radius  圆角半径
 *  @param corners 具体要添加的哪个角
 */
- (void)addCornersRadius:(CGFloat)radius forCorners:(UIRectCorner)corners;


- (void)addDarkenViewAnimate:(BOOL)animate
                     forRect:(CGRect)rect
                     onTaped:(void (^)(UIView *view))block;
- (void)addDarkenViewAnimate:(BOOL)animate
                     onTaped:(void (^)(UIView *view))block;

- (void)addDarkenViewAnimate:(BOOL)animate;
- (void)removeDarkenViewAnimate:(BOOL)animate;

+ (UIView *)darkenViewForRect:(CGRect)rect;

@end
