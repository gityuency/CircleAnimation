//
//  ViewControllerDemo01.m
//  AnimatinsNew
//
//  Created by yuency on 17/3/24.
//  Copyright © 2017年 yuency. All rights reserved.
//

#import "ViewControllerDemo01.h"

#import "LoadingViewError.h"
#import "LoadingViewRight.h"
#import "LoadingViewWarning.h"
#import "LoadingViewStop.h"
#import "LoadingViewWaiting.h"
#import "LoadingViewSixSwnStar.h"

#pragma mark - 动画参数
///动画延时
const CGFloat delay = .5f;
///动画持续
const CGFloat duration = 1.f;

@interface ViewControllerDemo01 ()


@property (nonatomic, strong) LoadingView *loadingViewError;
@property (nonatomic, strong) LoadingView *loadingViewRight;
@property (nonatomic, strong) LoadingView *loadingViewWaining;
@property (nonatomic, strong) LoadingView *loadingStop;
@property (nonatomic, strong) LoadingView *loadingWaiting;
@property (nonatomic, strong) LoadingView *loadingViewSixSwnStar;



@end

@implementation ViewControllerDemo01

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    //计算距离值
    CGFloat naviHeight = 20 + 44;
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width / 2;
    CGFloat cellHeight = ([UIScreen mainScreen].bounds.size.height - naviHeight) / 3;

    //错误
    self.loadingViewError = [[LoadingViewError alloc] initWithFrame:CGRectMake(0, naviHeight, cellWidth, cellHeight)];
    [self.view addSubview:self.loadingViewError];
    [self.loadingViewError showAnimationDelay:delay duration:duration];
    
    //正确
    self.loadingViewRight = [[LoadingViewRight alloc] initWithFrame:CGRectMake(cellWidth, naviHeight, cellWidth, cellHeight)];
    [self.view addSubview:self.loadingViewRight];
    [self.loadingViewRight showAnimationDelay:delay duration:duration];
    
    //警告
    self.loadingViewWaining = [[LoadingViewWarning alloc] initWithFrame:CGRectMake(0, naviHeight + cellHeight, cellWidth, cellHeight)];
    [self.view addSubview:self.loadingViewWaining];
    [self.loadingViewWaining showAnimationDelay:delay duration:duration];
    
    //停止
    self.loadingStop = [[LoadingViewStop alloc] initWithFrame:CGRectMake(cellWidth, naviHeight + cellHeight, cellWidth, cellHeight)];
    [self.view addSubview:self.loadingStop];
    [self.loadingStop showAnimationDelay:delay duration:duration];
    
    //等待
    self.loadingWaiting = [[LoadingViewWaiting alloc] initWithFrame:CGRectMake(0, naviHeight + cellHeight * 2, cellWidth, cellHeight)];
    [self.view addSubview:self.loadingWaiting];
    [self.loadingWaiting showAnimationDelay:delay duration:duration];
    
    //六芒星
    self.loadingViewSixSwnStar = [[LoadingViewSixSwnStar alloc] initWithFrame:CGRectMake(cellWidth, naviHeight + cellHeight * 2, cellWidth, cellHeight)];
    [self.view addSubview:self.loadingViewSixSwnStar];
    [self.loadingViewSixSwnStar showAnimationDelay:delay duration:duration];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //你的情况是系统默认的行为.当你离开了应用后(比如进入了后台),所有的动画都从他们的layer上移除了:因为系统调用了removeAllAnimations,针对所有的layer.
    // 添加通知(处理从后台进来后的情况)
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addAnimation:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)addAnimation:(NSNotification *)notificaiton {
    [self.loadingWaiting restartAnimation];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.loadingViewError showAnimationDelay:delay duration:duration];
    [self.loadingViewRight showAnimationDelay:delay duration:duration];
    [self.loadingViewWaining showAnimationDelay:delay duration:duration];
    [self.loadingStop showAnimationDelay:delay duration:duration];
    [self.loadingWaiting showAnimationDelay:delay duration:duration];
    [self.loadingViewSixSwnStar showAnimationDelay:delay duration:duration];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
