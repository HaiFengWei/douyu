//
//  ViewController.m
//  SPPickerView
//
//  Created by 韦海峰 on 2018/11/12.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import "ViewController.h"
#import "SPPickerView/SPPickerView.h"
#import "SPPickerView/SPDatePickerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    SPPickerView *view = [[SPPickerView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200.f)];
    [self.view addSubview:view];
    
    SPDatePickerView *picker = [[SPDatePickerView alloc] initWithFrame:CGRectMake(0, 350, [UIScreen mainScreen].bounds.size.width, 250.f)];
    [self.view addSubview:picker];
}


@end
