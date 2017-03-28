//
//  LoadingViewSixSwnStar.m
//  AnimatinsNew
//
//  Created by yuency on 17/3/27.
//  Copyright © 2017年 yuency. All rights reserved.
//

#import "LoadingViewSixSwnStar.h"


const NSTimeInterval lineDuration = .2f;


@interface LoadingViewSixSwnStar ()

///外圈圆环Layer
@property (nonatomic, strong) CAShapeLayer *circleLayer;

///内圈圆环Layer
@property (nonatomic, strong) CAShapeLayer *innerCircleLayer;
///内圈圆环半径
@property (nonatomic, assign) CGFloat innerRadius;


///线条 1
@property (nonatomic, strong) CAShapeLayer *line1;
///线条 2
@property (nonatomic, strong) CAShapeLayer *line2;
///线条 3
@property (nonatomic, strong) CAShapeLayer *line3;
///线条 4
@property (nonatomic, strong) CAShapeLayer *line4;
///线条 5
@property (nonatomic, strong) CAShapeLayer *line5;
///线条 6
@property (nonatomic, strong) CAShapeLayer *line6;

///数组装入线条 动画组 1
@property (nonatomic, strong) NSArray *lineArray;

///数组装入线条 动画组 2
@property (nonatomic, strong) NSArray *lineArrayAgain;


@end


@implementation LoadingViewSixSwnStar


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}


- (void)configView {
    
    //设置颜色
    self.viewColor = [UIColor purpleColor];
    
    //设置外圈圆环
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:self.circleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.path = path.CGPath;
    _circleLayer.strokeStart = 0.f;
    _circleLayer.strokeEnd = 0.f;
    _circleLayer.strokeColor = self.viewColor.CGColor;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.lineWidth = lineWidth;
    _circleLayer.frame = self.bounds;
    [self.layer addSublayer:_circleLayer];
    
    //设置内圈圆环 设置内圈半径
    _innerRadius = self.circleRadius * 0.8;
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:_innerRadius  startAngle:M_PI endAngle:M_PI * 3 clockwise:YES];
    _innerCircleLayer = [CAShapeLayer layer];
    _innerCircleLayer.path = path2.CGPath;
    _innerCircleLayer.strokeStart = 0.f;
    _innerCircleLayer.strokeEnd = 0.f;
    _innerCircleLayer.strokeColor = self.viewColor.CGColor;
    _innerCircleLayer.fillColor = [UIColor clearColor].CGColor;
    _innerCircleLayer.lineWidth = lineWidth;
    [self.layer addSublayer:_innerCircleLayer];
    
    
    //划线需要的参数
    CGFloat centerX = _circleLayer.position.x;
    CGFloat centerY = _circleLayer.position.y;
    double angle1 = M_PI / 6;
    double angle4 = M_PI / 3;
    
    //第一个点
    CGPoint point_1 = CGPointMake(_innerRadius * cos(angle1) + centerX, centerY - _innerRadius * sin(angle1));
    //第二个点
    CGPoint point_2 = CGPointMake(centerX, centerY - _innerRadius);
    //第三个点
    CGPoint point_3 = CGPointMake(centerX - _innerRadius * cos(angle1), centerY - _innerRadius * sin(angle1));
    //第四个点
    CGPoint point_4 = CGPointMake(centerX - _innerRadius * sin(angle4), centerY + _innerRadius * cos(angle4));
    //第五个点
    CGPoint point_5 = CGPointMake(centerX , centerY + _innerRadius);
    //第六个点
    CGPoint point_6 = CGPointMake(centerX + _innerRadius * sin(angle4), centerY + _innerRadius * cos(angle4));
    
    
    for (int i = 0; i < 2; i ++) {
        //第一条线
        CALayer *lineAgain1 = [self lineStartPoint:point_1 endPoint:point_3];
        [_circleLayer addSublayer:lineAgain1];
        //第二条线
        CALayer *lineAgain2 = [self lineStartPoint:point_5 endPoint:point_1];
        [_circleLayer addSublayer:lineAgain2];
        //第三条线
        CALayer *lineAgain3 = [self lineStartPoint:point_2 endPoint:point_4];
        [_circleLayer addSublayer:lineAgain3];
        //第四条线
        CALayer *lineAgain4 = [self lineStartPoint:point_6 endPoint:point_2];
        [_circleLayer addSublayer:lineAgain4];
        //第五条线
        CALayer *lineAgain5 = [self lineStartPoint:point_3 endPoint:point_5];
        [_circleLayer addSublayer:lineAgain5];
        //第六条线
        CALayer *lineAgain6 = [self lineStartPoint:point_4 endPoint:point_6];
        [_circleLayer addSublayer:lineAgain6];
        if (i == 0) {
            _lineArray = @[lineAgain1,lineAgain2,lineAgain3,lineAgain4,lineAgain5,lineAgain6];
        } else {
            _lineArrayAgain = @[lineAgain1,lineAgain2,lineAgain3,lineAgain4,lineAgain5,lineAgain6];
        }
    }
    
}


///获得layer
- (CAShapeLayer *)lineStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:startPoint];
    [linePath addLineToPoint:endPoint];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeStart = 0.f;
    layer.strokeEnd = 0.f;
    layer.lineWidth = lineWidth;
    layer.path = linePath.CGPath;
    layer.strokeColor = self.viewColor.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    return layer;
}


- (void)showAnimationDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration {
    
    //复位圆环
    _circleLayer.strokeStart = 0.f;
    _circleLayer.strokeEnd = 0.f;
    _innerCircleLayer.strokeStart = 0.f;
    _innerCircleLayer.strokeEnd = 0.f;
    
    //复位线条
    [self resetLineStartEnd];
    
    
    //圆环动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //外圈
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat:1.f];
        animation.duration = duration;
        _circleLayer.strokeStart = 0.f;
        _circleLayer.strokeEnd = 1.f;
        [_circleLayer addAnimation:animation forKey:nil];
        
        //内圈
        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation2.fromValue = [NSNumber numberWithFloat:0.f];
        animation2.toValue = [NSNumber numberWithFloat:1.f];
        animation2.duration = duration;
        _innerCircleLayer.strokeStart = 0.f;
        _innerCircleLayer.strokeEnd = 1.f;
        [_innerCircleLayer addAnimation:animation forKey:nil];
    });
    
    
    //第一阶段
    double delayOne = delay + duration;
    [self performSelector:@selector(animationStepOne) withObject:nil afterDelay:(delayOne)];
    
    //第二阶段
    double delayTwo = delayOne + lineDuration * 2;
    [self performSelector:@selector(animationStepTwo) withObject:nil afterDelay:(delayTwo)];
    
    //第三阶段
    double delayThr = delayTwo + lineDuration * 5;
    [self performSelector:@selector(animationStepThr) withObject:nil afterDelay:(delayThr)];
    
}

- (void)animationStepOne {
    
    //第一阶段 线条出现
    for (int i = 0; i < 6; i++) {
        
        //线条出现的次序时间
        NSTimeInterval lineShowDelays =  i * lineDuration;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(lineShowDelays * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            animation.fromValue = [NSNumber numberWithFloat:0.f];
            animation.toValue = [NSNumber numberWithFloat:1.f];
            animation.duration = lineDuration;
            CAShapeLayer *line = self.lineArray[i];
            line.strokeStart = 0.f;
            line.strokeEnd = 1.f;
            [line addAnimation:animation forKey:nil];
        });
    }
}


- (void)animationStepTwo {
    
    //第二阶段 线条消失
    for (int i = 0; i < 6; i++) {
        
        //线条消失次序时间
        NSTimeInterval lineHideDelays = i * lineDuration;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(lineHideDelays * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //隐藏线条
            CAShapeLayer *line = self.lineArray[i];
            line.opacity = 0;
        });
    }
}


- (void)animationStepThr {
    
    //第三阶段线条 再次出现
    for (int i = 0; i < 6; i++) {
        
        //线条出现的次序时间
        NSTimeInterval lineShowAgainDelays = i * lineDuration;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(lineShowAgainDelays * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            animation.fromValue = [NSNumber numberWithFloat:0.f];
            animation.toValue = [NSNumber numberWithFloat:1.f];
            animation.duration = lineDuration;
            CAShapeLayer *line = self.lineArrayAgain[i];
            line.strokeStart = 0.f;
            line.strokeEnd = 1.f;
            [line addAnimation:animation forKey:nil];
        });
    }
}

///复位线条
- (void)resetLineStartEnd {
    for (CAShapeLayer *line in self.lineArray) {
        line.strokeStart = 0.f;
        line.strokeEnd = 0.f;
        line.opacity = 1;
    }
    for (CAShapeLayer *line in self.lineArrayAgain) {
        line.strokeStart = 0.f;
        line.strokeEnd = 0.f;
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
