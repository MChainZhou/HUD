//
//  UIViewExtend.m
//  YuJingWan
//
//  Created by 陈双龙 on 12-11-17.
//  Copyright (c) 2012年 Donson. All rights reserved.
//

#import "UIViewExtend.h"

//#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
//#import "UIImageView+WebCache.h"

@implementation UIView (Extend)

/**
 @brief:view截图方法
 */
- (UIImage *)captureView:(UIView *)view{
    UIImage *image = nil;
    UIScrollView *scrollView = nil;
    if ([view isKindOfClass:[UIScrollView class]]) {
        scrollView = (UIScrollView *)view;
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, YES, [UIScreen mainScreen].scale);
        CGContextRef contexRef = UIGraphicsGetCurrentContext();
        [scrollView.layer renderInContext: contexRef];
        //清除缓存,解决内存警告
        //        scrollView.layer.contents = nil;
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }else{
        UIGraphicsBeginImageContext(view.bounds.size);
        CGContextRef contexRef = UIGraphicsGetCurrentContext();
        [view.layer renderInContext: contexRef];
        //        view.layer.contents = nil;
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return image;
}


/**
 @功能:在视图上添加菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addActivityIndicatorView:(UIActivityIndicatorViewStyle) style
{
    UIView *view = [self viewWithTag:ACTIVITYTAG];
    
    if ( nil != view ) {
        [self removeActivityIndicatorView];
    }
    
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    aiv.frame = CGRectMake( (self.frame.size.width - ACTIVITYWIDTH) / 2.0, 
                           (self.frame.size.height - ACTIVITYHRIGHT) / 2.0, 
                           ACTIVITYWIDTH, ACTIVITYHRIGHT);
    aiv.tag = ACTIVITYTAG;
    [aiv startAnimating];
    [self addSubview:aiv];
}

/**
 @功能:删除视图上的菊花
 @返回值:空
 */
- (void) removeActivityIndicatorView //Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx不能使用
{
    UIView *subView = [self viewWithTag:ACTIVITYTAG];
    [subView removeFromSuperview];
    
//    UIView *subView = [self viewWithTag:HUDTAG];
//    [subView removeFromSuperview];
}

/**
 @功能:在视图上添加HUD菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addHUDActivityView:(NSString*) labelText
{
    UIView *view = [self viewWithTag:HUDTAG];
    
    if ( nil != view ) {
        [self removeHUDActivityView];
    }
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    HUD.tag = HUDTAG;
    HUD.labelText = labelText;
    [self addSubview:HUD];
    [HUD show:YES];
}

/**
 @功能:删除视图上的HUD菊花
 @返回值:空
 */
- (void) removeHUDActivityView
{
    UIView *subView = [self viewWithTag:HUDTAG];
    [subView removeFromSuperview];
}

/**
 @功能:在视图上添加HUD菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addHUDLabelView:(NSString*) labelText Image:(UIImage*) image afterDelay:(NSTimeInterval)delay 
{
    
    UIView *view = [self viewWithTag:HUDLABELTAG];
    
    if ( nil != view ) {
        [view removeHUDActivityView];
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    HUD.tag = HUDLABELTAG;
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.labelText = labelText;
    [self addSubview:HUD];
    [HUD show:YES];
    [HUD hide:YES afterDelay:delay];
}

- (void) addHUDLabelView:(NSString*) labelText Image:(UIImage*) image afterDelay:(NSTimeInterval)delay andAdd:(BOOL)up
{
    UIView *view = [self viewWithTag:HUDLABELTAG];
    
    if ( nil != view ) {
        [view removeHUDActivityView];
    }
    CGRect frame;
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    frame = HUD.frame;
    frame.origin.y = HUD.frame.origin.y-70;
    HUD.frame = frame;
    HUD.tag = HUDLABELTAG;
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = labelText;
    [self addSubview:HUD];
    [HUD show:YES];
    [HUD hide:YES afterDelay:delay];

}
- (void) addMaskImage:(UIImage*) maskImage
{
    CALayer* roundCornerLayer = [CALayer layer];
    roundCornerLayer.frame = self.bounds;
    roundCornerLayer.contents = (id)[maskImage CGImage];
    [[self layer] setMask:roundCornerLayer];
}

- (void) addHUDLabelWindow:(NSString*) labelText Image:(UIImage*) image afterDelay:(NSTimeInterval)delay
{
    
    UIView *view = [self viewWithTag:HUDLABELTAG];
    
    if ( nil != view ) {
        [view removeHUDActivityView];
    }
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    HUD.tag = HUDLABELTAG;
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = labelText;

    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [tempWindow addSubview:HUD];
    

    [HUD show:YES];
    [HUD hide:YES afterDelay:delay];
}

- (void) addImageToWindow:(UIImage*) image
{
//    [UIApplication sharedApplication].statusBarHidden = YES;
//    
//    WindowImageView *windowImageView = [[WindowImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    windowImageView.imageView.image = image;
//    
//    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
//    [appDelegate.window addSubview:windowImageView];
//    
//    [windowImageView release];
    
}

- (void) addImageUrlToWindow:(NSMutableDictionary*) dicTable
{
//    UIImageView *imageView = [dicTable objectForKey:@"ImageView"];
//    
//    if ( [imageView isKindOfClass:[UIImageView class]] ) {
//        
//        WindowImageView *windowImageView = [[WindowImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        
//        NSString *jsonString = [dicTable objectForKey:@"UserInfo"];
//        
//        NSMutableDictionary *imageTable = [jsonString JSONValue];
//        
//        if ( [imageTable isKindOfClass:[NSMutableDictionary class]] ) {
//            
//            NSString *bigImageURL = [imageTable objectForKey:@"img"];
//
//            if ( [bigImageURL isKindOfClass:[NSString class]] ) {
//                NSURL *imageURL = [NSURL URLWithString:bigImageURL];
//                [windowImageView.imageView setImageWithURL:imageURL placeholderImage:imageView.image];
//            } else {
//                windowImageView.imageView.image = imageView.image;
//            }
//            
//        } else {
//            windowImageView.imageView.image = imageView.image;
//        }
//        
//        [UIApplication sharedApplication].statusBarHidden = YES;
//        
//        id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
//        [appDelegate.window addSubview:windowImageView];
//        
//        [windowImageView release];
//    }
    
    
}


@end
