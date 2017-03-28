//
//  LoadingViewWarning.m
//  AnimatinsNew
//
//  Created by yuency on 17/3/24.
//  Copyright © 2017年 yuency. All rights reserved.
//

#import "LoadingViewWarning.h"


@interface LoadingViewWarning ()

///圆环Layer
@property (nonatomic, strong) CAShapeLayer *circleLayer;
///警告的背景条
@property (nonatomic, strong) CALayer *backLayer;
///警告的上半部分
@property (nonatomic, strong) CALayer *warnToplayer;
///警告的下半部分
@property (nonatomic, strong) CALayer *warnBottomLayer;

@end

@implementation LoadingViewWarning

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}


- (void)configView {
    
    //设置颜色
    self.viewColor = [UIColor orangeColor];
    
    //圆形path
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:self.circleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //创建圆形
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.frame = self.bounds;
    _circleLayer.path = path.CGPath;
    _circleLayer.strokeColor = self.viewColor.CGColor;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeStart = 0.f;
    _circleLayer.strokeEnd = 0.f;
    _circleLayer.lineWidth = lineWidth;
    [self.layer addSublayer:_circleLayer];
    
    //创建背景条
    _backLayer = [CALayer layer];
    _backLayer.frame = CGRectMake(0, 0, lineWidth, self.circleRadius * 2);
    _backLayer.position = _circleLayer.position;
    _backLayer.masksToBounds = YES;
    [_circleLayer addSublayer:_backLayer];
    
    //上半部分
    _warnToplayer = [CALayer layer];
    _warnToplayer.frame = CGRectZero;
    _warnToplayer.backgroundColor = self.viewColor.CGColor;
    [_backLayer addSublayer:_warnToplayer];
    
    //下半部分
    _warnBottomLayer = [CALayer layer];
    _warnBottomLayer.frame = CGRectZero;
    _warnBottomLayer.backgroundColor =  self.viewColor.CGColor;
    [_backLayer addSublayer:_warnBottomLayer];
    
}


- (void)showAnimationDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration {
    
    //重置
    _circleLayer.strokeStart = 0.f;
    _circleLayer.strokeEnd = 0.f;
    _warnToplayer.position = CGPointMake(0, -self.circleRadius / 2);
    _warnBottomLayer.position = CGPointMake(0, self.circleRadius * 2 + lineWidth);
    
    //圆环动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        circleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        circleAnimation.fromValue = [NSNumber numberWithFloat:0.f];
        circleAnimation.toValue = [NSNumber numberWithFloat:1.f];
        circleAnimation.duration = duration;
        _circleLayer.strokeStart = 0.f;
        _circleLayer.strokeEnd = 1.f;
        [_circleLayer addAnimation:circleAnimation forKey:nil];
    });
    
    //感叹号
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((delay + duration) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGFloat distance = self.circleRadius * 0.5f;
        _warnToplayer.frame = CGRectMake(0, distance *.7f, lineWidth, self.circleRadius);
        _warnBottomLayer.frame = CGRectMake(0, self.circleRadius * 2 - distance * .7f, lineWidth, lineWidth);
    });
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
