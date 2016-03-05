//
//  ELScopeExts.h
//  ELCocoaExts
//
//  Created by Evan on 13/10/9.
//  Copyright © 2013年 WewaySoft. All rights reserved.
//

#ifndef LEScopeExts
#define LEScopeExts

#import "ELExtsmetamacros.h"

//////////////////For Color//////////////////////

#define UIColorFromRGBHex(rgbValue) \
[UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.f \
                green:((rgbValue & 0xFF00) >> 8)/255.f \
                blue:(rgbValue & 0xFF)/255.f \
                alpha:1.f]

#define UIColorFromRGBAHex(rgbaValue) \
[UIColor colorWithRed:((rgbValue & 0xFF000000) >> 24)/255.f \
                green:((rgbValue & 0xFF0000) >> 16)/255.f \
                blue:((rgbValue & 0xFF00) >> 8)/255.f \
                alpha:(rgbValue & 0xFF)/255.f]

#ifndef UIColorFromRGBAValues
#define UIColorFromRGBAValues(r, g, b, a) \
[UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#endif

#ifndef UIColorFromRGBValues
#define UIColorFromRGBValues(r, g, b) \
        UIColorFromRGBAValues(r, g, b, 1.0f)
#endif


///////others//////////

#ifndef SystemVersionGreaterOrEqualThan
#define SystemVersionGreaterOrEqualThan(v) \
[[UIDevice currentDevice].systemVersion compare:@"v" options:NSNumericSearch] != NSOrderedDescending
#endif


//////////////////For Memory//////////////////////
//inspire by lib ext objc
//https://github.com/jspahrsummers/libextobjc
//////////////////////////////////////////////////


#define weakifySelf(wSelf) \
elext_keywordify \
typeof(*&self) __weak wSelf = self;

#define strongifySelf(name) \
elext_keywordify \
typeof(wSelf) __strong name = wSelf;


#ifndef dispatch_onMain_sync_safely
#define dispatch_onMain_sync_safely(block) \
if ([NSThread isMainThread]) { \
    block();\
} else { \
    dispatch_sync(dispatch_get_main_queue(), block); \
}
#endif

#ifndef dispatch_onMain_async_safely
#define dispatch_onMain_async_safely(block)\
if ([NSThread isMainThread]) {\
    block();\
} else {\
    dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

#ifndef dispatch_onMain_with_delay
#define dispatch_onMain_with_delay(delay, block) \
dispatch_after(\
            dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), \
            dispatch_get_main_queue(), \
            block \
            );
#endif


#ifndef weakify
#define weakify(...) \
elext_keywordify \
metamacro_foreach_cxt(elext_weakify_,, __weak, __VA_ARGS__)
#endif

#ifndef strongify
#define strongify(...) \
elext_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
metamacro_foreach(elext_strongify_,, __VA_ARGS__) \
_Pragma("clang diagnostic pop")

#endif

#ifndef unsafeify
#define unsafeify(...) \
elext_keywordify \
metamacro_foreach_cxt(elext_weakify_,, __unsafe_unretained, __VA_ARGS__)
#endif


#define elext_weakify_(INDEX, CONTEXT, VAR) \
CONTEXT __typeof__(VAR) metamacro_concat(VAR, _weak_) = (VAR);

#define elext_strongify_(INDEX, VAR) \
__strong __typeof__(VAR) VAR = metamacro_concat(VAR, _weak_);


#if DEBUG
#define elext_keywordify autoreleasepool {}
#else
#define elext_keywordify try {} @catch (...) {}
#endif




#endif