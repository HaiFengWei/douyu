//
//  SPDatePicker.m
//  SPPickerView
//
//  Created by 韦海峰 on 2018/11/12.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import "SPDatePicker.h"
#import "NSDate+SPPickerView.h"
#import "NSDateFormatter+SPPickerView.h"
#import "SPPickerViewCommon.h"


#define SP_Current_Date     [NSDate date]

#define SPPickerView_lineMargin 15.f
#define SPPickerView_lineHeight 1.f

#define SPPickerView_CellTextFont  [UIFont systemFontOfSize:15.f]
#define SPPickerView_CellSelectdeTextFont  [UIFont systemFontOfSize:14.f]


#define cellHeight (self.bounds.size.height/5.f)
#define cellLines  2

static NSString *SPCustomTabelViewCellId = @"SPCustomTabelViewCellId";

@interface SPCustomTabelViewCell : UITableViewCell
@property(strong, nonatomic)NSIndexPath *indexPath;
@end

@implementation SPCustomTabelViewCell
@synthesize indexPath;
@end

@interface SPDatePicker ()<UITableViewDelegate,UITableViewDataSource>
@property(strong, nonatomic) UITableView *yearTableView;
@property(strong, nonatomic) UITableView *monthTableView;
@property(strong, nonatomic) UITableView *dayTableView;
@property(strong, nonatomic) UITableView *hourTableView;
@property(strong, nonatomic) UITableView *minuteTableView;

@property(strong, nonatomic) UIView *topLine;
@property(strong, nonatomic) UIView *bottomLine;

@property(strong, nonatomic) NSMutableArray *yearArray;
@property(strong, nonatomic) NSMutableArray *monthArray;
@property(strong, nonatomic) NSMutableArray *dayArray;
@property(strong, nonatomic) NSMutableArray *hourArray;
@property(strong, nonatomic) NSMutableArray *minuteArray;

@property(strong, nonatomic) NSMutableDictionary *resoultDictionary;

@property(strong, nonatomic) NSDate * maxDate;
@property(strong, nonatomic) NSDate * minDate;
@property(strong, nonatomic) NSDate * defautDate;
@end

@implementation SPDatePicker

#pragma mark - 创建列表控件
- (UITableView *)sp_creatTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorInset = UIEdgeInsetsMake(tableView.separatorInset.top, 0, tableView.separatorInset.bottom, 0);
    
    return tableView;
}

- (UIView *)creatLineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:0.82 green:0.91 blue:0.99 alpha:1.00];
    return lineView;
}

// 创建分割线
- (UIView *)topLine
{
    if (!_topLine) {
        _topLine = [self creatLineView];
    }
    return _topLine;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [self creatLineView];
    }
    return _bottomLine;
}

// 创建每个分区日期选择器
- (UITableView *)yearTableView
{
    if (!_yearTableView)
    {
        _yearTableView = [self sp_creatTableView];
        _yearTableView.tag = 0;
        [self addSubview:_yearTableView];
    }
    return _yearTableView;
}

- (UITableView *)monthTableView
{
    if (!_monthTableView)
    {
        _monthTableView = [self sp_creatTableView];
        _monthTableView.tag = 1;
        
        [self addSubview:_monthTableView];
    }
    return _monthTableView;
}

- (UITableView *)dayTableView
{
    if (!_dayTableView) {
        _dayTableView = [self sp_creatTableView];
        _dayTableView.tag = 2;
        
        [self addSubview:_dayTableView];
    }
    return _dayTableView;
}

- (UITableView *)hourTableView{
    if (!_hourTableView) {
        _hourTableView = [self sp_creatTableView];
        _hourTableView.tag = 3;
        
        [self addSubview:_hourTableView];
    }
    return _hourTableView;
}

- (UITableView *)minuteTableView{
    if (!_minuteTableView) {
        _minuteTableView = [self sp_creatTableView];
        _minuteTableView.tag = 4;
        
        [self addSubview:_minuteTableView];
    }
    return _minuteTableView;
}

- (void)registCell
{
    [self.yearTableView registerClass:[SPCustomTabelViewCell class] forCellReuseIdentifier:SPCustomTabelViewCellId];
    [self.monthTableView registerClass:[SPCustomTabelViewCell class] forCellReuseIdentifier:SPCustomTabelViewCellId];
    [self.dayTableView registerClass:[SPCustomTabelViewCell class] forCellReuseIdentifier:SPCustomTabelViewCellId];
    [self.hourTableView registerClass:[SPCustomTabelViewCell class] forCellReuseIdentifier:SPCustomTabelViewCellId];
    [self.minuteTableView registerClass:[SPCustomTabelViewCell class] forCellReuseIdentifier:SPCustomTabelViewCellId];
}

#pragma mark - 数据源
- (NSMutableArray *)yearArray
{
    if (!_yearArray)
    {
        _yearArray = [NSMutableArray array];
        
        [self refreshYear];
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray
{
    if (!_monthArray) {
        _monthArray = [NSMutableArray array];
        [self refreshMonthIsMaxYearState:YES MinYear:NO];
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray{
    if (!_dayArray) {
        _dayArray = [NSMutableArray array];
        [self refreshDayIsMaxMonthState:YES MinMonth:NO];
    }
    return _dayArray;
}

- (NSMutableArray *)hourArray{
    if (!_hourArray) {
        _hourArray = [NSMutableArray array];
        [self refreshHourIsMaxDayState:YES MinDay:NO];
    }
    return _hourArray;
}

- (NSMutableArray *)minuteArray{
    if (!_minuteArray) {
        _minuteArray = [NSMutableArray array];
        [self refreshMinuteIsMaxHourState:YES MinHour:NO];
    }
    return _minuteArray;
}

- (void)refreshYear
{
    [self.yearArray removeAllObjects];
    for (NSInteger i = self.minDate.year; i < self.maxDate.year+1; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%ld",(long)i];
        [_yearArray addObject:str];
    }
    [self setSelectDate:@"year"];
}

#pragma mark 计算出当月有多少天
- (void)refreshMinuteIsMaxHourState:(BOOL)maxState MinHour:(BOOL)minState
{
    NSInteger min = 0;
    NSInteger max = 59;
    if (maxState == YES)
    {
        max = self.maxDate.minute;
    }
    if (minState == YES)
    {
        min = self.minDate.minute;
    }
    [self.minuteArray removeAllObjects];
    for (NSInteger i = min; i < max+1; i++)
    {
        //        NSString *str = [NSString stringWithFormat:@"%02li分",(long)i];
        NSString *str = [NSString stringWithFormat:@"%02li",(long)i];
        [self.minuteArray addObject:str];
    }
    [self setSelectDate:@"minute"];
    [self.minuteTableView reloadData];
}

- (void)refreshHourIsMaxDayState:(BOOL)maxState MinDay:(BOOL)minState
{
    NSInteger min = 0;
    NSInteger max = 23;
    if (maxState == YES)
    {
        max = self.maxDate.hour;
    }
    if (minState == YES)
    {
        min = self.minDate.hour;
    }
    [self.hourArray removeAllObjects];
    for (NSInteger i = min; i < max+1; i++)
    {
        //        NSString *str = [NSString stringWithFormat:@"%02li时",(long)i];
        NSString *str = [NSString stringWithFormat:@"%02li",(long)i];
        [self.hourArray addObject:str];
    }
    [self setSelectDate:@"hour"];
    [self.hourTableView reloadData];
}
- (void)refreshDayIsMaxMonthState:(BOOL)maxState MinMonth:(BOOL)minState
{
    NSString *year = self.resoultDictionary[@"year"];
    //    if ([year containsString:@"年"])
    //    {
    //        year = [year substringToIndex:year.length - 1];
    //    }
    NSString *mounth = self.resoultDictionary[@"mounth"];
    //    if ([mounth containsString:@"月"])
    //    {
    //        mounth = [mounth substringToIndex:mounth.length - 1];
    //    }
    
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@",year,mounth];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSDate * date = [formatter dateFromString:dateStr];
    
    NSInteger min = 1;
    NSInteger max =  [self totaldaysInMonth:date];
    
    if (maxState == YES)
    {
        max = self.maxDate.day;
    }
    if (minState == YES)
    {
        min = self.minDate.day;
    }
    
    [self.dayArray removeAllObjects];
    for (NSInteger i = min; i < max+1; i++)
    {
        //        NSString *str = [NSString stringWithFormat:@"%02li日",(long)i];
        NSString *str = [NSString stringWithFormat:@"%02li",(long)i];
        [self.dayArray addObject:str];
    }
    [self setSelectDate:@"day"];
    [self.dayTableView reloadData];
    
}

- (void)refreshMonthIsMaxYearState:(BOOL)maxState MinYear:(BOOL)minState
{
    NSInteger min = 1;
    NSInteger max = 12;
    if (maxState == YES)
    {
        max = self.maxDate.month;
    }
    if (minState == YES)
    {
        min = self.minDate.month;
    }
    [self.monthArray removeAllObjects];
    for (NSInteger i = min; i < max+1; i++)
    {
        //        NSString *str = [NSString stringWithFormat:@"%02li月",(long)i];
        NSString *str = [NSString stringWithFormat:@"%02li",(long)i];
        [self.monthArray addObject:str];
    }
    [self setSelectDate:@"mounth"];
    [self.monthTableView reloadData];
}


- (NSInteger)totaldaysInMonth:(NSDate *)date
{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

// 初始化日期数据
- (NSDate *)defautDate {
    if (!_defautDate) {
        _defautDate = SP_Current_Date;
    }
    return _defautDate;
}

// 存放滑动中选择的当前选中日期
- (NSMutableDictionary *)resoultDictionary
{
    if (!_resoultDictionary)
    {
        _resoultDictionary = [NSMutableDictionary dictionary];
        [self refreshDayDefautDate];
    }
    return _resoultDictionary;
}

- (void)setSelectDate:(NSString *)typeKey
{
    SPPickerView_WeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        SPPickerView_StrongSelf
        NSString *defaultDateStr = [self.resoultDictionary objectForKey:typeKey];
        NSArray *dataArray;
        UITableView *tableView;
        if ([typeKey isEqualToString:@"year"]) {
            dataArray = self.yearArray;
            tableView = self.yearTableView;
        }else if ([typeKey isEqualToString:@"mounth"]){
            dataArray = self.monthArray;
            tableView = self.monthTableView;
        }else if ([typeKey isEqualToString:@"day"]){
            dataArray = self.dayArray;
            tableView = self.dayTableView;
        }else if ([typeKey isEqualToString:@"hour"]){
            dataArray = self.hourArray;
            tableView = self.hourTableView;
        }else if ([typeKey isEqualToString:@"minute"]){
            dataArray = self.minuteArray;
            tableView = self.minuteTableView;
        }
        
        NSInteger index = [dataArray indexOfObject:defaultDateStr];
        
        if (index < dataArray.count && index > 0)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index + cellLines inSection:0];
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        }
    });
}

- (void)refreshDayDefautDate
{
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%ld",(long)self.defautDate.year] forKey:@"year"];
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%02li",(long)self.defautDate.month] forKey:@"mounth"];
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%02li",(long)self.defautDate.day] forKey:@"day"];
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%02li",(long)self.defautDate.hour] forKey:@"hour"];
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%02li",(long)self.defautDate.minute] forKey:@"minute"];
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%02li",(long)self.defautDate.second] forKey:@"seconds"];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag)
    {
        case 0:
            return self.yearArray.count  + cellLines*2;
            break;
        case 1:
            return self.monthArray.count  + cellLines*2;
            break;
        case 2:
            return self.dayArray.count  + cellLines*2;
            break;
        case 3:
            return self.hourArray.count  + cellLines*2;
            break;
        case 4:
            return self.minuteArray.count  + cellLines*2;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPCustomTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPCustomTabelViewCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [cell.contentView viewWithTag:100];
    if (!titleLabel)
    {
        titleLabel = [[UILabel alloc] initWithFrame:cell.bounds];
        titleLabel.tag = 100;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = SPPickerView_CellTextFont;
        [cell.contentView addSubview:titleLabel];
    }
    
    titleLabel.frame = cell.contentView.bounds;
    titleLabel.textColor = self.sp_datePickerTextColor;
    
    NSArray * dataArray;
    NSString *defaultDateStr;
    switch (tableView.tag)
    {
        case 0:
        {
            dataArray = self.yearArray;
            defaultDateStr = [self.resoultDictionary objectForKey:@"year"];
        }
            break;
        case 1:
        {
            dataArray = self.monthArray;
            defaultDateStr = [self.resoultDictionary objectForKey:@"month"];
        }
            break;
        case 2:
        {
            dataArray = self.dayArray;
            defaultDateStr = [self.resoultDictionary objectForKey:@"day"];
        }
            break;
        case 3:
        {
            dataArray = self.hourArray;
            defaultDateStr = [self.resoultDictionary objectForKey:@"hour"];
        }
            break;
        case 4:
        {
            dataArray = self.minuteArray;
            defaultDateStr = [self.resoultDictionary objectForKey:@"minute"];
        }
            break;
        default:
        {
            defaultDateStr = @"";
            dataArray = [NSMutableArray array];
        }
            break;
    }
    
    if (indexPath.row < cellLines || indexPath.row > dataArray.count + cellLines - 1)
    {
        titleLabel.text = @"";
    }
    else
    {
        titleLabel.text = dataArray[indexPath.row - cellLines];
    }
    
    cell.indexPath = indexPath;
    [self changeLabelWithTabelView:tableView cell:cell];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UITableView *table = (UITableView *)scrollView;
    NSArray *cells = table.visibleCells;
    [cells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SPCustomTabelViewCell *cell = (SPCustomTabelViewCell *)obj;
        [self changeLabelWithTabelView:table cell:cell];
    }];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refreshSelectDateWith:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self refreshSelectDateWith:scrollView];
}

- (void)refreshSelectDateWith:(UIScrollView *)scrollView
{
    UITableView *table = (UITableView *)scrollView;
    NSArray * cells =   table.visibleCells;
    for (SPCustomTabelViewCell *cell in cells) {
        UILabel *titleLabel = [cell.contentView viewWithTag:100];
        if (titleLabel.alpha == 1.0)
        {
            [table scrollToRowAtIndexPath:cell.indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            
            NSString *key = @"";
            switch (scrollView.tag) {
                case 0:
                    key = @"year";
                    break;
                case 1:
                    key = @"mounth";
                    break;
                case 2:
                    key = @"day";
                    break;
                case 3:
                    key = @"hour";
                    break;
                case 4:
                    key = @"minute";
                    break;
                case 5:
                    key = @"seconds";
                    break;
                default:
                    break;
            }
            
            if (!SPPickerView_stringIsBlank_pod(titleLabel.text))
            {
                [self.resoultDictionary setObject:titleLabel.text forKey:key];
                
                NSString *year = self.resoultDictionary[@"year"];
                NSString *mounth = self.resoultDictionary[@"mounth"];
                NSString *day = self.resoultDictionary[@"day"];
                NSString *hour = self.resoultDictionary[@"hour"];
                
                if ([key isEqualToString:@"year"])
                {
                    [self refreshMonthIsMaxYearState:[year isEqualToString:[self.yearArray lastObject]] MinYear:[year isEqualToString:self.yearArray[0]]];
                    [self refreshSelectDateWithTableViewTag:1];
                }
                if ([key isEqualToString:@"year"] || [key isEqualToString:@"mounth"])
                {
                    [self refreshDayIsMaxMonthState:([year isEqualToString:[self.yearArray lastObject]] && [mounth isEqualToString:[self.monthArray lastObject]]) MinMonth:([year isEqualToString:self.yearArray[0]] && [mounth isEqualToString:self.monthArray[0]])];
                    [self refreshSelectDateWithTableViewTag:2];
                }
                if ([key isEqualToString:@"year"] || [key isEqualToString:@"mounth"] || [key isEqualToString:@"day"])
                {
                    [self refreshHourIsMaxDayState:([year isEqualToString:[self.yearArray lastObject]] && [mounth isEqualToString:[self.monthArray lastObject]] && [day isEqualToString:[self.dayArray lastObject]]) MinDay:([year isEqualToString:self.yearArray[0]] && [mounth isEqualToString:self.monthArray[0]] && [day isEqualToString:self.dayArray[0]])];
                    [self refreshSelectDateWithTableViewTag:3];
                }
                if ([key isEqualToString:@"year"] || [key isEqualToString:@"mounth"] || [key isEqualToString:@"day"] || [key isEqualToString:@"hour"])
                {
                    [self refreshMinuteIsMaxHourState:([year isEqualToString:[self.yearArray lastObject]] && [mounth isEqualToString:[self.monthArray lastObject]] && [day isEqualToString:[self.dayArray lastObject]]&& [hour isEqualToString:[self.hourArray lastObject]]) MinHour:([year isEqualToString:self.yearArray[0]] && [mounth isEqualToString:self.monthArray[0]] && [day isEqualToString:self.dayArray[0]]&& [hour isEqualToString:self.hourArray[0]])];
                    [self refreshSelectDateWithTableViewTag:4];
                }
            }
        }
    }
    NSString *currentStr = [self selectedTitmeResults];
    NSLog(@"SPDatePicker-->Selected：%@",currentStr);
}

- (void)refreshSelectDateWithTableViewTag:(NSInteger)tag {
    
    UITableView *table = [self viewWithTag:tag];
    NSArray * cells =   table.visibleCells;
    for (SPCustomTabelViewCell *cell in cells) {
        UILabel *titleLabel = [cell.contentView viewWithTag:100];
        if (titleLabel.alpha == 1.0)
        {
            [table scrollToRowAtIndexPath:cell.indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            
            NSString *key = @"";
            switch (table.tag) {
                case 0:
                    key = @"year";
                    break;
                case 1:
                    key = @"mounth";
                    break;
                case 2:
                    key = @"day";
                    break;
                case 3:
                    key = @"hour";
                    break;
                case 4:
                    key = @"minute";
                    break;
                case 5:
                    key = @"seconds";
                    break;
                default:
                    break;
            }
            
            if (!SPPickerView_stringIsBlank_pod(titleLabel.text))
            {
                [self.resoultDictionary setObject:titleLabel.text forKey:key];
            }
        }
    }
}


- (NSString *)selectedTitmeResults
{
    // 确定
    NSString *resoultDateStr = @"";
    
    NSString *year = self.resoultDictionary[@"year"];
    //    if ([year containsString:@"年"])
    //    {
    //        year = [year substringToIndex:year.length - 1];
    //    }
    
    NSString *mouth = self.resoultDictionary[@"mounth"];
    //    if ([mouth containsString:@"月"])
    //    {
    //        mouth = [mouth substringToIndex:mouth.length - 1];
    //    }
    
    NSString *day = self.resoultDictionary[@"day"];
    //    if ([day containsString:@"日"])
    //    {
    //        day = [day substringToIndex:day.length - 1];
    //    }
    
    NSString *hour = self.resoultDictionary[@"hour"];
    //    if ([hour containsString:@"时"])
    //    {
    //        hour = [hour substringToIndex:hour.length - 1];
    //    }
    
    NSString *minute = self.resoultDictionary[@"minute"];
    //    if ([minute containsString:@"分"])
    //    {
    //        minute = [minute substringToIndex:minute.length - 1];
    //    }
    
    //    NSString *seconds = self.resoultDictionary[@"seconds"];
    //    if ([seconds containsString:@"秒"])
    //    {
    //        seconds = [seconds substringToIndex:seconds.length - 1];
    //    }
    
    resoultDateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,mouth,day,hour,minute];
    
    return resoultDateStr;
}

/**
 改变字体选中和非选中是的大小和透明度
 */
- (void)changeLabelWithTabelView:(UITableView *)tableView cell:(SPCustomTabelViewCell *)cell
{
    CGFloat _cellHight = cellHeight;
    
    CGRect rect = [tableView rectForRowAtIndexPath:cell.indexPath];
    CGRect viewRect = [tableView convertRect:rect toView:self];
    
    CGFloat minY = tableView.center.y - _cellHight / 2.0 ;
    CGFloat maxY = tableView.center.y + _cellHight / 2.0 ;
    
    
    CGFloat cellY = viewRect.origin.y + viewRect.size.height / 2.f ;
    UILabel *titleLabel = [cell.contentView viewWithTag:100];
    
    if (maxY >= cellY && minY <= cellY)
    {
        titleLabel.alpha = 1;
        
        UIFont *selectFont = [UIFont fontWithName:SPPickerView_CellTextFont.fontName size:SPPickerView_CellSelectdeTextFont.pointSize];
        titleLabel.font = selectFont;
    }
    else
    {
        titleLabel.font = SPPickerView_CellTextFont;
        titleLabel.alpha = 0.5;
    }
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    NSDateFormatter *format = [NSDateFormatter sp_setupDateFormatterWithYMDHMS];
    self.maxDate = SP_Current_Date;
    self.minDate = [format dateFromString:@"2010-00-00 00:00:00"];
    
    CGFloat tableViewW = self.bounds.size.width/5.0;
    CGFloat tableViewH = self.bounds.size.height;
    
    [self addSubview:self.yearTableView];
    [self addSubview:self.monthTableView];
    [self addSubview:self.dayTableView];
    [self addSubview:self.hourTableView];
    [self addSubview:self.minuteTableView];
    
    [self registCell];
    
    self.yearTableView.frame   = CGRectMake(tableViewW*0.0, 0.0, tableViewW, tableViewH);
    self.monthTableView.frame  = CGRectMake(tableViewW*1.0, 0.0, tableViewW, tableViewH);
    self.dayTableView.frame    = CGRectMake(tableViewW*2.0, 0.0, tableViewW, tableViewH);
    self.hourTableView.frame   = CGRectMake(tableViewW*3.0, 0.0, tableViewW, tableViewH);
    self.minuteTableView.frame = CGRectMake(tableViewW*4.0, 0.0, tableViewW, tableViewH);
    
    
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    
    self.topLine.frame = CGRectMake(SPPickerView_lineMargin,
                                    cellLines * cellHeight,
                                    SP_ScreenW - SPPickerView_lineMargin*2.f,
                                    SPPickerView_lineHeight);
    
    self.bottomLine.frame = CGRectMake(SPPickerView_lineMargin,
                                       (cellLines + 1) * cellHeight,
                                       SP_ScreenW - SPPickerView_lineMargin*2.f,
                                       SPPickerView_lineHeight);
}



@end
