//
//  NSDateFormatter+SPPickerView.m
//  SPPickerView
//
//  Created by 韦海峰 on 2018/11/13.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import "NSDateFormatter+SPPickerView.h"

@implementation NSDateFormatter (SPPickerView)

+ (id)sp_setupDateFormatterWithYMDHMS
{
    return [self sp_dateFormatterWithFormatString:@"yyyy-MM-dd HH:mm:ss"];
}

+ (id)sp_setupDateFormatterWithYMDEHMS
{
    return [self sp_dateFormatterWithFormatString:@"yyyy-MM-dd, EEE, HH:mm:ss"];
}

+ (id)sp_setupDateFormatterWithYMD
{
    return [self sp_dateFormatterWithFormatString:@"yyyy-MM-dd"];
}

+ (id)sp_setupDateFormatterWithYM
{
    return [self sp_dateFormatterWithFormatString:@"yyyy-MM"];
}

+ (id)sp_setupDateFormatterWithYY
{
    return [self sp_dateFormatterWithFormatString:@"yyyy"];
}

+ (id)sp_setupDateFormatterWithHM
{
    return [self sp_dateFormatterWithFormatString:@"HH:mm"];
}

+ (id)sp_setupDateFormatterWithHMS
{
    return [self sp_dateFormatterWithFormatString:@"HH:mm:ss"];
}

+ (id)sp_dateFormatterWithFormatString:(NSString *)dateFormatString
{
    if (dateFormatString == nil || ![dateFormatString isKindOfClass:[NSString class]] || [dateFormatString isEqualToString:@""])
    {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormatString;
    
    return dateFormatter;
}

@end
