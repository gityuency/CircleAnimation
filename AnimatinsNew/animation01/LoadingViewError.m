//
//  LoadingViewOne.m
//  AnimatinsNew
//
//  Created by yuency on 17/3/24.
//  Copyright © 2017年 yuency. All rights reserved.
//

#import "LoadingViewError.h"

@interface LoadingViewError ()

///圆圈Layer
@property (nonatomic, strong) CAShapeLayer *shapLayer;
///打叉的Layer 左
@property (nonatomic, strong) CAShapeLayer *leftLayer;
///打叉的Layer 右
@property (nonatomic, strong) CAShapeLayer *rightLayer;

@end

@implementation LoadingViewError

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}


///初始化界面
- (void)configView {
    
    self.viewColor = [UIColor redColor];
    
    //创建一个圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:self.circleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //创建形状
    _shapLayer = [CAShapeLayer layer];
    _shapLayer.backgroundColor = [UIColor clearColor].CGColor; //背景色
    _shapLayer.frame         = self.bounds;                    // 与showView的frame一致
    _shapLayer.path          = path.CGPath;                    // 从贝塞尔曲线获取到形状
    _shapLayer.strokeColor   = self.viewColor.CGColor;         // 边缘线的颜色
    _shapLayer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
    _shapLayer.lineCap       = kCALineCapSquare;               // 边缘线的类型
    _shapLayer.lineWidth     = lineWidth;                      // 线条宽度
    _shapLayer.strokeStart   = 0.0f;
    _shapLayer.strokeEnd     = 0.0f;
    [self.layer addSublayer:_shapLayer];
    
    
    CGFloat distance = self.circleRadius * 0.5f;
    
    //创建左边 X
    UIBezierPath *leftXpath = [UIBezierPath bezierPath];
    [leftXpath moveToPoint:CGPointMake(_shapLayer.position.x - distance, _shapLayer.position.y - distance)];
    [leftXpath addLineToPoint:CGPointMake(_shapLayer.position.x + distance, _shapLayer.position.y + distance)];
    _leftLayer = [CAShapeLayer layer];
    _leftLayer.strokeStart = 0.f;
    _leftLayer.strokeEnd = 0.f;
    _leftLayer.lineWidth = lineWidth;
    _leftLayer.path = leftXpath.CGPath;
    _leftLayer.strokeColor = self.viewColor.CGColor;
    _leftLayer.fillColor = [UIColor clearColor].CGColor;
    [_shapLayer addSublayer:_leftLayer];
    
    //创建右边 X
    UIBezierPath *rightXpath = [UIBezierPath bezierPath];
    [rightXpath moveToPoint:CGPointMake(_shapLayer.position.x + distance, _shapLayer.position.y - distance)];
    [rightXpath addLineToPoint:CGPointMake(_shapLayer.position.x - distance, _shapLayer.position.y   + distance)];
    _rightLayer = [CAShapeLayer layer];
    _rightLayer.strokeStart = 0.f;
    _rightLayer.strokeEnd = 0.f;
    _rightLayer.lineWidth = lineWidth;
    _rightLayer.path = rightXpath.CGPath;
    _rightLayer.strokeColor = self.viewColor.CGColor;
    _rightLayer.fillColor = [UIColor clearColor].CGColor;
    [_shapLayer addSublayer:_rightLayer];
    
}

#pragma mark - 重写父类方法
- (void)showAnimationDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration {
    
    _shapLayer.strokeStart = 0.f;
    _shapLayer.strokeEnd   = 0.f;
    _leftLayer.strokeStart = 0.f;
    _leftLayer.strokeEnd   = 0.f;
    _rightLayer.strokeStart = 0.f;
    _rightLayer.strokeEnd   = 0.f;
    
    //圆圈动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = duration;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
        _shapLayer.strokeStart = 0.f; //开始
        _shapLayer.strokeEnd   = 1.f; //结束
        [_shapLayer addAnimation:pathAnimation forKey:nil];
        
    });
    
    //打叉
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((duration + delay) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = .2f;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
        _leftLayer.strokeStart = 0.f; //开始
        _leftLayer.strokeEnd   = 1.f; //结束
        [_leftLayer addAnimation:pathAnimation forKey:nil];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((duration + delay + 0.2f) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = .2f;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
        _rightLayer.strokeStart = 0.f; //开始
        _rightLayer.strokeEnd   = 1.f; //结束
        [_rightLayer addAnimation:pathAnimation forKey:nil];
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
