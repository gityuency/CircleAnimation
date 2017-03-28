//
//  LoadingViewStop.m
//  AnimatinsNew
//
//  Created by yuency on 17/3/26.
//  Copyright © 2017年 yuency. All rights reserved.
//

#import "LoadingViewStop.h"

@interface LoadingViewStop ()

///圆环Layer
@property (nonatomic, strong) CAShapeLayer *circleLayer;
///停止点
@property (nonatomic, strong) CALayer *stopLayer;

@end


@implementation LoadingViewStop

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView {
    
    //设置颜色
    self.viewColor = [UIColor blackColor];
    
    //圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:self.circleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.path = path.CGPath;
    _circleLayer.frame = self.bounds;
    _circleLayer.strokeColor = self.viewColor.CGColor;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeStart = 0.f;
    _circleLayer.strokeEnd = 0.f;
    _circleLayer.lineWidth = lineWidth;
    [self.layer addSublayer:_circleLayer];
    
    //方块
    _stopLayer = [CALayer layer];
    _stopLayer.frame = CGRectMake(0, 0, self.circleRadius * 2, self.circleRadius * 2);
    _stopLayer.cornerRadius = self.circleRadius;
    _stopLayer.position = _circleLayer.position;
    _stopLayer.borderWidth = lineWidth;
    [self.layer addSublayer:_stopLayer];
}


- (void)showAnimationDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration {
    
    //复位
    _circleLayer.strokeStart = 0.f;
    _circleLayer.strokeEnd = 0.f;
    _stopLayer.frame = CGRectMake(0, 0, self.circleRadius * 2, self.circleRadius * 2);
    _stopLayer.cornerRadius = self.circleRadius;
    _stopLayer.borderWidth = lineWidth / 2;
    _stopLayer.position = _circleLayer.position;
    _stopLayer.borderColor = [UIColor clearColor].CGColor;
    
    //圆环动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat:1.f];
        animation.duration = duration;
        _circleLayer.strokeStart = 0.f;
        _circleLayer.strokeEnd = 1.f;
        [_circleLayer addAnimation:animation forKey:nil];
    });
    
    
    //停止方块
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((delay + duration) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _stopLayer.frame = CGRectMake(0, 0, 40, 40);
        _stopLayer.cornerRadius = 0;
        _stopLayer.speed = .3f;     //这个参数可以让动画慢一点
        _stopLayer.borderWidth = 40;
        _stopLayer.position = _circleLayer.position;
        _stopLayer.borderColor = self.viewColor.CGColor;
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
