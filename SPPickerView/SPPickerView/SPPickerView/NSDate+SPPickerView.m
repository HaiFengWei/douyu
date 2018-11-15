//
//  NSDate+SPPickerView.m
//  SPPickerView
//
//  Created by 韦海峰 on 2018/11/13.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import "NSDate+SPPickerView.h"
#define k_MINUTE    60
#define SPPickerView_Current_Calendar [NSCalendar currentCalendar]

@implementation NSDate (SPPickerView)
- (NSInteger)year
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + k_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [SPPickerView_Current_Calendar components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger)hour
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}


@end
