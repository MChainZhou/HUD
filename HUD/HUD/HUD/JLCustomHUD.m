//
//  JLCustomHUD.m
//  HUD
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JLCustomHUD.h"
#import "UIView+Extension.h"

#define kRoundW               10
#define animTime              1.5
#define animRepeateTime       50
#define kScreenW              [UIScreen mainScreen].bounds.size.width
#define kScreenH              [UIScreen mainScreen].bounds.size.height
#define roundOneColor         [UIColor colorWithRed:81/255.0 green:188/255.0 blue:62/255.0 alpha:1.0]
#define roundTwoColor         [UIColor colorWithRed:246/255.0 green:201/255.0 blue:51/255.0 alpha:1.0]
#define roundThreeColor       [UIColor colorWithRed:225/255.0 green:41/255.0 blue:34/255.0 alpha:1.0]

@interface JLCustomHUD ()<CAAnimationDelegate>
///
@property(nonatomic, strong) UIView *roundOneView;
///
@property(nonatomic, strong) UIView *roundTwoView;
///
@property(nonatomic, strong) UIView *roundThreeView;
@end

@implementation JLCustomHUD

- (void)dealloc{
    NSLog(@"销毁了");
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.roundOneView = [[UIView alloc]init];
    self.roundOneView.width = kRoundW;
    self.roundOneView.height = kRoundW;
    self.roundOneView.layer.cornerRadius = kRoundW/2;
    self.roundOneView.backgroundColor = roundOneColor;
    
    self.roundTwoView = [[UIView alloc]init];
    self.roundTwoView.width = kRoundW;
    self.roundTwoView.height = kRoundW;
    self.roundTwoView.layer.cornerRadius = kRoundW/2;
    self.roundTwoView.backgroundColor = roundTwoColor;
    
    self.roundThreeView = [[UIView alloc]init];
    self.roundThreeView.width = kRoundW;
    self.roundThreeView.height = kRoundW;
    self.roundThreeView.layer.cornerRadius = kRoundW/2;
    self.roundThreeView.backgroundColor = roundThreeColor;
    
    [self addSubview:self.roundOneView];
    [self addSubview:self.roundTwoView];
    [self addSubview:self.roundThreeView];
    
}

- (void)layoutSubviews{
    self.roundTwoView.x = (self.width - self.roundTwoView.width)/2;
    self.roundTwoView.y = (self.height - self.roundTwoView.height)/2;
    
    self.roundOneView.centerX = self.roundTwoView.centerX - kRoundW * 2;
    self.roundOneView.centerY = self.roundTwoView.centerY;
    
    self.roundThreeView.centerX = self.roundTwoView.centerX + kRoundW * 2;
    self.roundThreeView.centerY = self.roundTwoView.centerY;

    [self startAnimation];
}


- (void)startAnimation{
    CGPoint roundCenterOne = CGPointMake(self.roundOneView.centerX + kRoundW, self.roundTwoView.centerY);
    CGPoint roundCenterTwo = CGPointMake(self.roundTwoView.centerX + kRoundW, self.roundTwoView.centerY);
    
    UIBezierPath *path1 = [[UIBezierPath alloc]init];
    [path1 addArcWithCenter:roundCenterOne radius:kRoundW startAngle:-M_PI endAngle:0 clockwise:YES];
    UIBezierPath *path1_1 = [[UIBezierPath alloc]init];
    [path1_1 addArcWithCenter:roundCenterTwo radius:kRoundW startAngle:-M_PI endAngle:0 clockwise:NO];
    [path1 appendPath:path1_1];
    
    [self viewMoveAnim:self.roundOneView path:path1 time:animTime];
    [self viewColorAnim:self.roundOneView fromColor:roundOneColor toColor:roundThreeColor time:animTime];
    
    UIBezierPath *path2 = [[UIBezierPath alloc]init];
    [path2 addArcWithCenter:roundCenterOne radius:kRoundW startAngle:0 endAngle:-M_PI clockwise:YES];
    [self viewMoveAnim:self.roundTwoView path:path2 time:animTime];
    [self viewColorAnim:self.roundTwoView fromColor:roundTwoColor toColor:roundOneColor time:animTime];

    UIBezierPath *path3 = [[UIBezierPath alloc]init];
    [path3 addArcWithCenter:roundCenterTwo radius:kRoundW startAngle:0 endAngle:-M_PI clockwise:NO];
    [self viewMoveAnim:self.roundThreeView path:path3 time:animTime];
    [self viewColorAnim:self.roundThreeView fromColor:roundThreeColor toColor:roundTwoColor time:animTime];
}

- (void)stopAnimation{
    [self.roundOneView.layer removeAllAnimations];
    [self.roundTwoView.layer removeAllAnimations];
    [self.roundThreeView.layer removeAllAnimations];
    
    [self removeFromSuperview];
}

+ (instancetype)showLoadingWithView:(UIView *)view{
    JLCustomHUD *custonHUD = [[JLCustomHUD alloc]initWithFrame:view.bounds];
    
    [view addSubview:custonHUD];
    return custonHUD;
}

- (void)viewMoveAnim:(UIView *)view path:(UIBezierPath *)path time:(CGFloat)time{
    CAKeyframeAnimation *anim = [[CAKeyframeAnimation alloc]init];
    anim.keyPath = @"position";
    anim.path = path.CGPath;
    anim.removedOnCompletion = NO;
    anim.duration = time;
    anim.fillMode = kCAFillModeForwards;
    anim.calculationMode = kCAAnimationCubic;
    anim.repeatCount = animRepeateTime;
    anim.delegate = self;
    anim.autoreverses = NO;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:anim forKey:@"animation"];
}

- (void)viewColorAnim:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor time:(CGFloat)time{
    CABasicAnimation *anim = [[CABasicAnimation alloc]init];
    anim.keyPath = @"backgroundColor";
    anim.fromValue = (__bridge id _Nullable)(fromColor.CGColor);
    anim.toValue = (__bridge id _Nullable)(toColor.CGColor);
    anim.duration = time;
    anim.fillMode = kCAFillModeForwards;
    anim.autoreverses = NO;
    anim.removedOnCompletion = NO;
    anim.repeatCount = animRepeateTime;
    [view.layer addAnimation:anim forKey:@"backgroundColor"];
}

#pragma mark --- CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self stopAnimation];
}


@end
