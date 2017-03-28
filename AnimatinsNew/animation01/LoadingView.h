//
//  LoadingView.h
//  AnimatinsNew
//
//  Created by yuency on 17/3/24.
//  Copyright © 2017年 yuency. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - 动画参数
///线条宽度
extern CGFloat const lineWidth;

@interface LoadingView : UIView

///圆形半径
@property (nonatomic, assign, readonly) CGFloat circleRadius;
///视图颜色
@property (nonatomic, strong) UIColor *viewColor;

/**
 *  显示动画
 *
 *  @param delay    延时
 *  @param duration 持续
 */
- (void)showAnimationDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration;

/**
 *  程序进入后台的时候重新开始旋转的动画
 */
- (void)restartAnimation;

@end
