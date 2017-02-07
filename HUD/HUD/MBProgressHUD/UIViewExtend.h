//
//  UIViewExtend.h
//  YuJingWan
//
//  Created by 陈双龙 on 12-11-17.
//  Copyright (c) 2012年 Donson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define ACTIVITYWIDTH       20
#define ACTIVITYHRIGHT      20
#define ACTIVITYTAG         666666
#define HUDTAG              (ACTIVITYTAG + 1)
#define HUDLABELTAG         (HUDTAG + 1)

@interface UIView (Extend)
/**
 @brief:view截图方法
 */

- (UIImage *)captureView:(UIView *)view;

/**
 @功能:在视图上添加菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addActivityIndicatorView:(UIActivityIndicatorViewStyle) style;

/**
 @功能:删除视图上的菊花
 @返回值:空
 */
- (void) removeActivityIndicatorView;//无用 {胡鹏}


/**
 @功能:在视图上添加HUD菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addHUDActivityView:(NSString*) labelText;

/**
 @功能:删除视图上的HUD菊花
 @返回值:空
 */
- (void) removeHUDActivityView;

/**
 @功能:在视图上添加HUD提示
 @参数1:UIImage  使用的图片
 @参数2:NSTimeInterval 多少秒后自动消失
 @返回值:更改后的图片对象
 */
- (void) addHUDLabelView:(NSString*) labelText Image:(UIImage*) image afterDelay:(NSTimeInterval)delay;

- (void) addHUDLabelView:(NSString*) labelText Image:(UIImage*) image afterDelay:(NSTimeInterval)delay andAdd:(BOOL)up;

- (void) addHUDLabelWindow:(NSString*) labelText Image:(UIImage*) image afterDelay:(NSTimeInterval)delay;

- (void) addMaskImage:(UIImage*) maskImage;

- (void) addImageToWindow:(UIImage*) image;

- (void) addImageUrlToWindow:(NSMutableDictionary*) json;

@end
