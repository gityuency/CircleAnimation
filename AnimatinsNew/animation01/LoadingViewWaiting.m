//
//  LoadingViewWaiting.m
//  AnimatinsNew
//
//  Created by yuency on 17/3/26.
//  Copyright © 2017年 yuency. All rights reserved.
//

#import "LoadingViewWaiting.h"

@interface LoadingViewWaiting ()

///圆环Layer
@property (nonatomic, strong) CAShapeLayer *circleLayer;
///旋转的背景
@property (nonatomic, strong) UIView *backRoatView;
///旋转的动画
@property (nonatomic, strong) CABasicAnimation *roatAnimation;


@end

@implementation LoadingViewWaiting

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}


- (void)configView {
    
    //设置颜色
    self.viewColor = [UIColor magentaColor];
    
    //设置圆环
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:self.circleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.path = path.CGPath;
    _circleLayer.strokeStart = 0.f;
    _circleLayer.strokeEnd = 0.f;
    _circleLayer.strokeColor = self.viewColor.CGColor;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.lineWidth = lineWidth;
    [self.layer addSublayer:_circleLayer];
    
    //旋转的背景View
    CGFloat wh = self.circleRadius * 2;
    _backRoatView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wh, wh)];
    _backRoatView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _backRoatView.backgroundColor = [UIColor clearColor];
    _backRoatView.layer.cornerRadius = wh / 2;
    _backRoatView.layer.masksToBounds = YES;
    [self addSubview:_backRoatView];
    
    //背景旋转的动画
    _roatAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _roatAnimation.duration = 5.f;
    _roatAnimation.repeatCount = HUGE_VALF;
    _roatAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    _roatAnimation.toValue   = [NSNumber numberWithFloat: 2 * M_PI];
    [_backRoatView.layer addAnimation:_roatAnimation forKey:@"backroat"];
    
    //中心参考点
    //        UIView *ccc = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - 10)  / 2, (self.frame.size.height - 10 ) / 2, 10, 10)];
    //        ccc.backgroundColor = [UIColor blackColor];
    //        [self addSubview:ccc];
    
    
    //绘制椭圆形扇叶
    CGFloat ovalW = self.circleRadius * 0.7f;
    CGFloat ovalH = ovalW * 0.2f;
    UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalW, ovalH)];
    
    for (int i = 0; i < 6; i++) {
        CAShapeLayer *flablelum = [CAShapeLayer layer];
        flablelum.name = [NSString stringWithFormat:@"flablelum%d",i];
        flablelum.anchorPoint = CGPointMake(0.f, 0.5f);
        flablelum.frame = CGRectMake(0,0, ovalW, ovalH);
        flablelum.position = CGPointMake(_backRoatView.frame.size.width / 2, _backRoatView.frame.size.height / 2);
        flablelum.backgroundColor = [UIColor clearColor].CGColor;
        flablelum.fillColor = self.viewColor.CGColor;
        flablelum.path = oval.CGPath;
        flablelum.transform = CATransform3DMakeRotation(i * M_PI / 3, 0, 0, 1);
        [_backRoatView.layer addSublayer:flablelum];
    }
    
}

- (void)showAnimationDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration {
    
    //复位圆环
    _circleLayer.strokeStart = 0.f;
    _circleLayer.strokeEnd = 0.f;
    
    //复位扇叶
    int i = 0;
    for (CAShapeLayer *flablelum in _backRoatView.layer.sublayers) {
        CGFloat xOff = (self.circleRadius + 10) * cos(i * M_PI / 3);
        CGFloat yOff = (self.circleRadius + 10) * sin(i * M_PI / 3);
        flablelum.position = CGPointMake(_backRoatView.frame.size.width / 2 + xOff, _backRoatView.frame.size.height / 2 + yOff);
        flablelum.opacity = 0;
        i ++;
    }
    
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
    
    //扇叶动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((duration + delay) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (CAShapeLayer *flablelum in _backRoatView.layer.sublayers) {
            flablelum.position = CGPointMake(_backRoatView.frame.size.width / 2, _backRoatView.frame.size.height / 2);
            flablelum.speed = 0.2f;
            flablelum.opacity = 1;
        }
    });
    
}


/**
 *  程序进入后台的时候重新开始旋转的动画
 */
- (void)restartAnimation {
    [_backRoatView.layer addAnimation:_roatAnimation forKey:@"backroat"];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
