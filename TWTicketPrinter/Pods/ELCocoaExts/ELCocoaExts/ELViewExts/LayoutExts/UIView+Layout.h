//
//  UIView+Layout.h
//  ELViewExt
//
//  Created by Evan on 13/9/18.
//  Copyright (c) 2013年 WewaySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGPoint CGRectGetCenter(CGRect rect);
extern CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);
extern CGRect  CGRectMakeBySize(CGPoint origin, CGSize size);

@interface UIView (Layout)

@property (nonatomic, assign, readonly) CGPoint bottomLeft;
@property (nonatomic, assign, readonly) CGPoint bottomRight;
@property (nonatomic, assign, readonly) CGPoint topRight;
@property (nonatomic, assign, readonly) CGPoint topLeft;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


- (void)sizeEqualToView:(UIView *)view;

- (void)fillWidth;
- (void)fillHeight;
- (void)fill;

- (UIView *)topSuperView;

@end
