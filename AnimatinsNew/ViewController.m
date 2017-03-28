//
//  ViewController.m
//  AnimatinsNew
//
//  Created by yuency on 17/3/20.
//  Copyright © 2017年 yuency. All rights reserved.
//

#import "ViewController.h"

static NSString * const idtntifire = @"idtntifire";

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

///表格
@property (nonatomic, strong) UITableView *tableView;

///数组
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动画合集";
    
    
    self.array = [NSMutableArray array];
    [self.array addObject:@"Loading动画"];

    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:idtntifire];
    
    [self.view addSubview:self.tableView];


}

#pragma mark - 代理部分
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:idtntifire];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld %@",indexPath.row + 1,self.array[indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.row == 0) {
        [self pushViewController:@"ViewControllerDemo01"];
    }
    

}


- (void)pushViewController:(NSString *)viewController {
    
    Class class = NSClassFromString(viewController);
    
    UIViewController *vc = [[class alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
