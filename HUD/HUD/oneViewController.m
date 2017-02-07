//
//  oneViewController.m
//  HUD
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "oneViewController.h"
#import "MBProgressHUD.h"
#import "JLCustomHUD.h"

@interface oneViewController ()
///
@property(nonatomic, strong) MBProgressHUD *hud;
///
@property(nonatomic, strong) JLCustomHUD *customHUD;
@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    JLCustomHUD *customView = [[JLCustomHUD alloc]init];
    customView.backgroundColor = [UIColor clearColor];
    customView.frame = CGRectMake(0, 0, 80, 80);
    self.customHUD = customView;
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.color = [UIColor clearColor];
    hud.customView = customView;
    hud.mode = MBProgressHUDModeCustomView;
    [self.view addSubview:hud];
    [hud show:YES];
    self.hud = hud;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.customHUD stopAnimation];
    [self.hud hide:YES];
    
}


@end
