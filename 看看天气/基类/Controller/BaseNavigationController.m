//
//  BaseNavigationController.m
//  看看天气
//
//  Created by mac on 15/10/2.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置导航栏为透明
    UIImage *image = [UIImage imageNamed:@"clear"];
    [self.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:image];

//    self.navigationBar.hidden = YES;
    
    
//    self.navigationBar.hidden = YES;
    //黑色风格
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //透明
//    self.navigationBar.translucent = YES;
    //背景颜色
//    self.navigationController.navigationBar.tintColor = [UIColor redColor];
}



-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
