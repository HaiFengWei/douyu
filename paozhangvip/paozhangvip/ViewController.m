//
//  ViewController.m
//  paozhangvip
//
//  Created by 韦海峰 on 2018/11/15.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *tempStr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *nums = @[@"967",@"1360",@"1197",@"803",@"1123",@"926",@"1164",@"992",@"684",@"825",@"6085",@"2162",@"2245",@"3167",@"1485",@"3120",@"3061",@"3030",@"3044",@"3224",@"2214",@"1467",@"1086",@"826",@"668",@"596",@"434",@"765",@"1042",@"1035",@"1339",@"1192",@"1054",@"710",@"920",@"911",@"1100",@"635",@"537",@"530",@"1017",@"546",@"532"];
    
    
    for (NSString *numString in nums) {
        int item = [numString intValue];
        [self SigncardHouseholdsNumberByAllHouseholds:item];
    }
    
    BOOL isSuccess = NO;
    NSString *filePath = @"/Users/weihaifeng/Desktop/paozhang.txt";
    isSuccess = [_tempStr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"写入成功否：%d",isSuccess);
}

- (void)SigncardHouseholdsNumberByAllHouseholds:(int)allHouseholds
{
    int molecule = 90 + arc4random()%10;
    
    int signcardHouseholds = (allHouseholds * molecule) / 100;
    
    float percent  = (float)signcardHouseholds/(float)allHouseholds;
    
    NSLog(@"百分比--->%.1f",percent*100.0);
    if (percent < 0.90000) {
        [self SigncardHouseholdsNumberByAllHouseholds:allHouseholds];
        return;
    }
    
    
    NSString *str = [NSString stringWithFormat:@"户数：%d  签卡户数：%d  签到户数百分比：%.1f%%\n\n",allHouseholds,signcardHouseholds,percent*100.0];
    
    if (!_tempStr) {
        _tempStr = str;
    }
    else {
        _tempStr = [_tempStr stringByAppendingString:str];
    }
    
    
   
    NSLog(@"户数：%d  签卡户数：%d  签到户数百分比：%.2f",allHouseholds,signcardHouseholds,percent);

    
}



@end
