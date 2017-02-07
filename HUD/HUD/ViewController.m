//
//  ViewController.m
//  HUD
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "oneViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义的HUD动画";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    oneViewController *oneVC = [[oneViewController alloc]init];
    
    [self.navigationController pushViewController:oneVC animated:YES];
}





@end
