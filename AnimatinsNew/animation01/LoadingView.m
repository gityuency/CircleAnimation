//
//  LoadingView.m
//  AnimatinsNew
//
//  Created by yuency on 17/3/24.
//  Copyright © 2017年 yuency. All rights reserved.
//

#import "LoadingView.h"

#pragma mark - 动画参数
///线条宽度
const CGFloat lineWidth = 6.0f;

@interface LoadingView ()

///圆形半径
@property (nonatomic, assign) CGFloat circleRadius;

@end


@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        [self calculateValue];
    }
    return self;
}

- (void)calculateValue {
    //计算圆形半径
    CGFloat minValue = self.frame.size.width / 2 > self.frame.size.height / 2 ? self.frame.size.height / 2 : self.frame.size.width / 2;
    _circleRadius = minValue - lineWidth / 2;
    //设置默认颜色
    _viewColor = [UIColor blackColor];
}

- (void)showAnimationDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration {
    [NSException raise:NSInternalInconsistencyException format:@"不能调用 %@ %d, 方法名:%@, 请实现子类,在子类中重写这个方法",[NSString stringWithUTF8String:__FILE__].lastPathComponent,__LINE__,NSStringFromSelector(_cmd)];;
}


- (void)restartAnimation {
    NSLog(@"由需要重启的子类进行重写");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
