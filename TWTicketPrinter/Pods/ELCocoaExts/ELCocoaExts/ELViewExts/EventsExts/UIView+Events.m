//
//  UIView+Events.m
//  ELCocoaExts
//
//  Created by Evan on 13/9/24.
//  Copyright (c) 2013年 WewaySoft. All rights reserved.
//

#import "UIView+Events.h"
#import <objc/runtime.h>

static char kViewTapGestureKey;
static char kViewTapGestureActionKey;

static char kViewLongPressGestureKey;
static char kViewLongPressGestureActionKey;

@implementation UIView (Events)

#pragma mark - Public Methods
- (void)setTapActionWithBlock:(void (^)(UIView *view))block
{
    if (!block) {
        [self removeGestureForKey:&kViewTapGestureKey];
        [self removeAssociatedObjectForKey:&kViewTapGestureActionKey];
        return;
    }
    
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *)objc_getAssociatedObject(self, &kViewTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc]
                      initWithTarget:self
                      action:@selector(handleActionForTapGesture:)];
        
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kViewTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, &kViewTapGestureActionKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)setLongPressActionWithBlock:(void (^)(UIView * view))block
{
    if (!block) {
        [self removeGestureForKey:&kViewLongPressGestureKey];
        [self removeAssociatedObjectForKey:&kViewLongPressGestureActionKey];
        return;
    }
    
    UILongPressGestureRecognizer *gesture = (UILongPressGestureRecognizer *)objc_getAssociatedObject(self, &kViewLongPressGestureKey);
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc]
                   initWithTarget:self
                   action:@selector(handleActionForLongGesture:)];
        
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kViewLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, &kViewLongPressGestureActionKey, block, OBJC_ASSOCIATION_COPY);

}


#pragma mark - Private Methods
- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void (^action)(UIView *) = objc_getAssociatedObject(self, &kViewTapGestureActionKey);
        if (action) {
            action(self);
        }
    }
}

- (void)handleActionForLongGesture:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void (^action)(UIView *) = objc_getAssociatedObject(self, &kViewLongPressGestureActionKey);
        if (action) {
            action(self);
        }
    }
}

- (void)removeAssociatedObjectForKey:(char *)key
{
    NSObject *associatedObj = objc_getAssociatedObject(self, key);
    if (associatedObj) {
        objc_removeAssociatedObjects(associatedObj);
    }
}

- (void)removeGestureForKey:(char *)key
{
    UIGestureRecognizer *gesture = (UIGestureRecognizer *)objc_getAssociatedObject(self, key);
    if (gesture) {
        [self removeGestureRecognizer:gesture];
        objc_removeAssociatedObjects(gesture);
    }
}

@end
