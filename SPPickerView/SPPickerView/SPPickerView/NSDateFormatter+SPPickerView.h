//
//  NSDateFormatter+SPPickerView.h
//  SPPickerView
//
//  Created by 韦海峰 on 2018/11/13.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (SPPickerView)
/**
 格式化：yyyy-MM-dd HH:mm:ss
 
 @return NSDateFormatter
 */
+ (id)sp_setupDateFormatterWithYMDHMS;

/**
 格式化：yyyy-MM-dd, EEE, HH:mm:ss
 
 @return NSDateFormatter
 */
+ (id)sp_setupDateFormatterWithYMDEHMS;

/**
 格式化：yyyy-MM-dd
 
 @return NSDateFormatter
 */
+ (id)sp_setupDateFormatterWithYMD;

/**
 格式化：yyyy-MM
 
 @return NSDateFormatter
 */
+ (id)sp_setupDateFormatterWithYM;

/**
 格式化：yyyy
 
 @return NSDateFormatter
 */
+ (id)sp_setupDateFormatterWithYY;

/**
 格式化：HM
 
 @return NSDateFormatter
 */
+ (id)sp_setupDateFormatterWithHM;

/**
 格式化：HMS
 
 @return NSDateFormatter
 */
+ (id)sp_setupDateFormatterWithHMS;
@end

NS_ASSUME_NONNULL_END
