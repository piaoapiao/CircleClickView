//
//  ViewController.m
//  CircleClickView
//
//  Created by guodong on 15/4/18.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import "ViewController.h"
#import "CircleClickView.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    NSLog(@"wangguodong commit");
    [super viewDidLoad];
    
    NSLog(@"Hello!");
    NSLog(@"Hello1!");
    
    self.testView.backgroundColor  = [UIColor clearColor];
    self.circleView.edgeBlock = ^(int which)
    {
        NSLog(@"which:%d",which);
    };
    self.circleView.centerBlock = ^()
    {
        NSLog(@"click center");
    };
    self.circleView.status = SecondFinishd |FivthFinishd;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
