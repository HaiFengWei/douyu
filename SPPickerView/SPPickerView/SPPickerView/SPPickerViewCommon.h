//
//  SPPickerViewCommon.h
//  SPPickerView
//
//  Created by 韦海峰 on 2018/11/13.
//  Copyright © 2018 sepeak. All rights reserved.
//

/*！
 * 强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 * 调用方式: `@SPPickerView_Weakify`实现弱引用转换，`@SPPickerView_Strongify`实现强引用转换
 *
 * 示例：
 * @SPPickerView_Weakify
 * [obj block:^{
 * @strongify_self
 * self.property = something;
 * }];
 */
#ifndef SPPickerView_Weakify
#if DEBUG
#if __has_feature(objc_arc)
#define SPPickerView_Weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define SPPickerView_Weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define SPPickerView_Weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define SPPickerView_Weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

/*！
 * 强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 * 调用方式: `@BAKit_Weakify(object)`实现弱引用转换，`@SPPickerView_Strongify(object)`实现强引用转换
 *
 * 示例：
 * @BAKit_Weakify(object)
 * [obj block:^{
 * @BAKit_Strongify(object)
 * strong_object = something;
 * }];
 */
#ifndef SPPickerView_Strongify
#if DEBUG
#if __has_feature(objc_arc)
#define SPPickerView_Strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define SPPickerView_Strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define SPPickerView_Strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define SPPickerView_Strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

CG_INLINE BOOL
SPPickerView_stringIsBlank_pod(NSString *string) {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < string.length; ++i) {
        unichar c = [string characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}

#define SPPickerView_WeakSelf        @SPPickerView_Weakify(self);
#define SPPickerView_StrongSelf      @SPPickerView_Strongify(self);

#define SP_ScreenW          [UIScreen mainScreen].bounds.size.width
