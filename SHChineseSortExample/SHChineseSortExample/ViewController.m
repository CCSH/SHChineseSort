//
//  ViewController.m
//  SHChineseSortExample
//
//  Created by CSH on 2018/9/20.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "ViewController.h"
#import "SHChineseSort.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    SHChineseSort *model = [SHChineseSort getSortWithDataArr:@[@{@"key":@"阿克苏结婚的"},@{@"key":@"偶遇"},@{@"key":@"也不应该"},@{@"key":@"阿普回复"},@{@"key":@"1234"},@{@"key":@"把 vi 并非易事"},@{@"key":@"颇具佛片"},@{@"key":@"要不要"},@{@"key":@"098u 家哦去潍坊"}] keyArr:@[@"key"]];
    NSLog(@"%@",model);
}


@end
