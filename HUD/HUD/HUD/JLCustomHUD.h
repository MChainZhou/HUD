//
//  JLCustomHUD.h
//  HUD
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLCustomHUD : UIView
- (void)stopAnimation;

+ (instancetype)showLoadingWithView:(UIView *)view;
@end
