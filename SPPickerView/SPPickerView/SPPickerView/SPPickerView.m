//
//  SPPickerView.m
//  SPPickViewDemo
//
//  Created by 韦海峰 on 2018/11/12.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import "SPPickerView.h"

@interface SPPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;

@property(nonatomic, strong) NSMutableArray *yearArray;
@property(nonatomic, strong) NSMutableArray *mounthArray;
@property(nonatomic, strong) NSMutableArray *dayArray;
@property(nonatomic, strong) NSMutableArray *hoursArray;
@property(nonatomic, strong) NSMutableArray *minutesArray;
@property(nonatomic, strong) NSMutableArray *secondsArray;


@property(nonatomic, strong) NSString *defaultMounthString;
@property(nonatomic, strong) NSString *defaultYearString;
@property(nonatomic, strong) NSString *defaultDayString;
@property(nonatomic, strong) NSString *defaultHoursString;
@property(nonatomic, strong) NSString *defaultMinutesString;
@property(nonatomic, strong) NSString *defaultSecondsString;


@end

@implementation SPPickerView
#pragma mark -
#pragma mark - LazyLoad UI控件
- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

#pragma mark -
#pragma mark - LazyLoad 数据源
- (NSMutableArray *)yearArray
{
    if (!_yearArray)
    {
        _yearArray = @[].mutableCopy;
        for (int i = 2000; i < 2100; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%04i%@",i,@"年"];
            [self.yearArray addObject:str];
        }
    }
    return _yearArray;
}

- (NSMutableArray *)mounthArray
{
    if (!_mounthArray)
    {
        _mounthArray = @[].mutableCopy;
        for (int i = 1; i < 13; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%02i%@",i,@"月"];
            [self.mounthArray addObject:str];
        }
    }
    return _mounthArray;
}

- (NSMutableArray *)dayArray
{
    if (!_dayArray)
    {
        _dayArray = @[].mutableCopy;
        [self refreshDay];
    }
    
    return _dayArray;
}

- (NSMutableArray *)hoursArray
{
    if (!_hoursArray)
    {
        _hoursArray = @[].mutableCopy;
        
        for (int i = 0; i < 24; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%02i时",i];
            [_hoursArray addObject:str];
        }
    }
    return _hoursArray;
}

- (NSMutableArray *)minutesArray
{
    if (!_minutesArray)
    {
        _minutesArray = @[].mutableCopy;
        
        for (int i = 0; i < 60; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%02i分",i];
            [_minutesArray addObject:str];
        }
    }
    return _minutesArray;
}

- (NSMutableArray *)secondsArray
{
    if (!_secondsArray)
    {
        _secondsArray = @[].mutableCopy;
        
        for (int i = 0; i < 60; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%02i秒",i];
            [_secondsArray addObject:str];
        }
    }
    return _secondsArray;
}

#pragma mark -
#pragma mark - System Method
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark -
#pragma mark - UI创建
- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pickerView];
    self.pickerView.frame = self.bounds;
}


#pragma mark -
#pragma mark - 天数数据更新
// 更新天数
-(void)refreshDay
{
    [self.dayArray removeAllObjects];
    NSString *year = self.defaultYearString;
    if ([self.defaultYearString containsString:@"年"]) {
        year = [self.defaultYearString substringToIndex:self.defaultYearString.length - 1];
    }
    NSString *mounth = self.defaultMounthString;
    if ([self.defaultMounthString containsString:@"月"]) {
        mounth = [self.defaultMounthString substringToIndex:self.defaultMounthString.length - 1];
    }
    
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@",year,mounth];
  
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    
    NSDate * date = [formatter dateFromString:dateStr];
    NSInteger count =  [self totaldaysInMonth:date];
    for (int i = 1; i < count + 1; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%02i日",i];
        [_dayArray addObject:str];
    }
    [self.pickerView reloadComponent:2];
    
}

// 更新天数
- (NSInteger)totaldaysInMonth:(NSDate *)date
{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}


#pragma mark -
#pragma mark - UIPickerView数据源设置
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 5;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            return self.yearArray.count;
            break;
        case 1:
            return self.mounthArray.count;
            break;
        case 2:
            return self.dayArray.count;
            break;
        case 3:
            return self.hoursArray.count;
            break;
        case 4:
            return self.minutesArray.count;
            break;
        case 5:
            return self.secondsArray.count;
            break;
        default:
            return 0;
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return self.yearArray[row];
            break;
        case 1:
            return self.mounthArray[row];
            break;
        case 2:
            return self.dayArray[row];
            break;
        case 3:
            return self.hoursArray[row];
            break;
        case 4:
            return self.minutesArray[row];
            break;
        case 5:
            return self.secondsArray[row];
            break;
        default:
            return @"";
            break;
            
    }
    return @"";
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
       
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14.f]];
        pickerLabel.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1/1.0];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    
    for (UIView *lineView in pickerView.subviews)
    {
        if (lineView.frame.size.height < 1)
        {
            lineView.backgroundColor = [UIColor colorWithRed:0.60 green:0.81 blue:0.98 alpha:1.00];
        }
    }
    
    return pickerLabel;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return [UIScreen mainScreen].bounds.size.width/5.f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 29.f;
}

#pragma mark -
#pragma mark - UIPickerView代理设置
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            self.defaultYearString = self.yearArray[row];
            [self refreshDay];
        }
            break;
        case 1:
        {
            self.defaultMounthString = self.mounthArray[row];
            [self refreshDay];
        }
            break;
        case 2:
        {
            self.defaultDayString = self.dayArray[row];
        }
            break;
        case 3:
        {
            self.defaultHoursString = self.hoursArray[row];
        }
            break;
        case 4:
        {
            self.defaultMinutesString = self.minutesArray[row];
        }
            break;
        case 5:
        {
            self.defaultSecondsString = self.secondsArray[row];
        }
            break;
        default:
            break;
    }
}
@end
