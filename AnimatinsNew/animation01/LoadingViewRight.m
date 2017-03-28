//
//  LoadingViewRight.m
//  AnimatinsNew
//
//  Created by yuency on 17/3/24.
//  Copyright © 2017年 yuency. All rights reserved.
//

#import "LoadingViewRight.h"

@interface LoadingViewRight ()

///圆形layer
@property (nonatomic, strong) CAShapeLayer *circleLayer;
///对号
@property (nonatomic, strong) CAShapeLayer *correctLayer;

@end

@implementation LoadingViewRight

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView {
    
    //颜色
    self.viewColor = [UIColor greenColor];
    
    //创建一个圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:self.circleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //创建圆形
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.backgroundColor = [UIColor clearColor].CGColor;
    _circleLayer.frame = self.bounds;
    _circleLayer.path = path.CGPath;
    _circleLayer.strokeColor = self.viewColor.CGColor;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.lineWidth = lineWidth;
    _circleLayer.strokeStart = 0.f;
    _circleLayer.strokeEnd = 0.f;
    [self.layer addSublayer:_circleLayer];
    
    
    CGFloat distance = self.circleRadius * 0.5f;
    
    //创建对号
    UIBezierPath *corrPath = [UIBezierPath bezierPath];
    [corrPath moveToPoint:CGPointMake(_circleLayer.position.x - distance, _circleLayer.position.y + distance - 20)];
    [corrPath addLineToPoint:CGPointMake(_circleLayer.position.x , _circleLayer.position.y + distance)];
    [corrPath addLineToPoint:CGPointMake(_circleLayer.position.x + distance, _circleLayer.position.y - distance)];
    _correctLayer = [CAShapeLayer layer];
    _correctLayer.strokeStart = 0.f;
    _correctLayer.strokeEnd = 1.f;
    _correctLayer.lineWidth = lineWidth;
    _correctLayer.path = corrPath.CGPath;
    _correctLayer.strokeColor = self.viewColor.CGColor;
    _correctLayer.fillColor = [UIColor clearColor].CGColor;
    [_circleLayer addSublayer:_correctLayer];
}


- (void)showAnimationDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration {

    _circleLayer.strokeStart = 0.f;
    _circleLayer.strokeEnd = 0.f;
    _correctLayer.strokeStart = 0.f;
    _correctLayer.strokeEnd = 0.f;
    
    //圆形动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        circleAnimation.duration = duration;
        circleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        circleAnimation.fromValue = [NSNumber numberWithFloat:0.f];
        circleAnimation.toValue = [NSNumber numberWithFloat:1.f];
        _circleLayer.strokeStart = 0.f;
        _circleLayer.strokeEnd = 1.f;
        [_circleLayer addAnimation:circleAnimation forKey:nil];
    });
    
    //对号动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((delay + duration) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        circleAnimation.duration = .3f;
        circleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        circleAnimation.fromValue = [NSNumber numberWithFloat:0.f];
        circleAnimation.toValue = [NSNumber numberWithFloat:1.f];
        _correctLayer.strokeStart = 0.f;
        _correctLayer.strokeEnd = 1.f;
        [_correctLayer addAnimation:circleAnimation forKey:nil];
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
