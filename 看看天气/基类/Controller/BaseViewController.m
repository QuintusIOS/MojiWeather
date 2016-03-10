//
//  BaseViewController.m
//  看看天气
//
//  Created by mac on 15/10/2.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "BaseViewController.h"
#import "TabBarButton.h"
#import "BaseTabBarController.h"
@interface BaseViewController ()
{
    BOOL _isHidden;
//    UILabel *_title;
//    TabBarButton *_titleButton;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma  mark - 标签栏的隐藏和显示控制
- (void)viewWillAppear:(BOOL)animated{
    if(_isHidden){
        BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
        [tab settabBarHidden:YES];
    }else{
        BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
        [tab settabBarHidden:NO];

    }
}

- (void)viewWillDisappear:(BOOL)animated{
    BaseTabBarController *tab = (BaseTabBarController *)self.tabBarController;
    [tab settabBarHidden:NO];
}


-(void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    _isHidden = hidesBottomBarWhenPushed;
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
