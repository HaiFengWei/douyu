//
//  SPDatePickerView.m
//  SPPickerView
//
//  Created by 韦海峰 on 2018/11/13.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import "SPDatePickerView.h"
#import "SPDatePicker.h"
#import "SPPickerViewCommon.h"


@interface SPDatePickerView ()

@property (nonatomic, strong) SPDatePicker *datePicker;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation SPDatePickerView

#pragma mark -
#pragma mark - LazyLoad

- (UIButton *)sp_creatButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:14.f];
    return button;
}

- (SPDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[SPDatePicker alloc] initWithFrame:CGRectMake(0, 0, SP_ScreenW, 159.95f)];
    }
    return _datePicker;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [self sp_creatButtonWithTitle:@"取消" titleColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1/1.0] action:@selector(cancelButtonClick)];
    }
    return _cancelButton;
}

- (UIButton *)sureButton
{
    if (!_sureButton) {
        _sureButton = [self sp_creatButtonWithTitle:@"确定" titleColor: [UIColor colorWithRed:42/255.0 green:168/255.0 blue:255/255.0 alpha:1/1.0] action:@selector(sureButtonClick)];
    }
    return _sureButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(145.5, 427, 84, 20);
        _titleLabel.text = @"选择开始时间";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1/1.0];
    }
    return _titleLabel;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self creatItemLabels];
    [self addSubview:self.datePicker];
    
    self.datePicker.frame = CGRectMake(0, 90.f, SP_ScreenW, 159.95);
    
    UIView *topLine = [self sp_creatLineView];
    topLine.frame = CGRectMake(0, 40.f, SP_ScreenW, 1.f);
    
    UIView *bottomLine = [self sp_creatLineView];
    bottomLine.frame = CGRectMake(0, 90.f, SP_ScreenW, 1.f);
    
    [self addSubview:self.cancelButton];
    [self.cancelButton sizeToFit];
    self.cancelButton.frame = CGRectMake(0, 0, 30.f+self.cancelButton.frame.size.width, 40.f);
    
    [self addSubview:self.sureButton];
    [self.sureButton sizeToFit];
    self.sureButton.frame = CGRectMake(SP_ScreenW - (30.f+self.cancelButton.frame.size.width), 0, 30.f+self.cancelButton.frame.size.width, 40.f);
    
    [self addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(30.f+self.cancelButton.frame.size.width, 0, SP_ScreenW - (30.f+self.cancelButton.frame.size.width)*2.f, 40.f);
}

- (void)creatItemLabels
{
    NSArray *itemTexts = @[@"年",@"月",@"日",@"时",@"分"];
    
    CGFloat itemY = 40.f;
    CGFloat itemW = SP_ScreenW/5.f;
    CGFloat itemH = 48.5f;

    SPPickerView_WeakSelf
    [itemTexts enumerateObjectsUsingBlock:^(NSString *itemText, NSUInteger index, BOOL * _Nonnull stop) {
        UILabel *label = [weak_self sp_creatLabel];
        label.frame    = CGRectMake(itemW*index, itemY, itemW, itemH);
        label.text     = itemText;
    }];
}

- (UILabel *)sp_creatLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(42.5, 472, 14, 20);
    label.font = [UIFont systemFontOfSize:14.f];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1/1.0];
    [self addSubview:label];
    return label;
}

- (UIView *)sp_creatLineView
{
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    return lineView;
}


- (void)cancelButtonClick
{
    
}

- (void)sureButtonClick
{
    
}

@end
