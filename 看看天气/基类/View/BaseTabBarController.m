//
//  BaseTabBarController.m
//  看看天气
//
//  Created by mac on 15/10/2.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "BaseTabBarController.h"
#import "TabBarButton.h"
#define kScreenWidth self.view.bounds.size.width
#define kScreenHeight self.view.bounds.size.height

@interface BaseTabBarController ()
{
    UIView *_tabbar;
}
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createTabBar];
}
-(void)_createTabBar{
    self.tabBar.hidden = YES;
    _tabbar = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    _tabbar.backgroundColor = [UIColor blackColor];
    _tabbar.alpha = 0.6;
    [self.view addSubview:_tabbar];
    
    CGFloat width = kScreenWidth/3;
    
    NSArray *titleArray = @[@"天气",@"新闻",@"我"];
    NSArray *imageNameArray = @[@"tabbar_weather_normal@2x",@"tabbar_live_normal@2x",@"tabbar_profile_normal@2x"];
    //NSArray *selectedImage = @[@"tabbar_weather_select@2x",@"tabbar_live_select2x",@"tabbar_profile_select@2x"];
    for (int i = 0; i<self.viewControllers.count;i++){
        TabBarButton *tabBarBtn = [[TabBarButton alloc]initWithTitle:titleArray[i] imageName:imageNameArray[i] frame:CGRectMake(width*i, 0, width, 49)];
        
            tabBarBtn.tag = i;
        
        [tabBarBtn addTarget:self action:@selector(tabBarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbar addSubview:tabBarBtn];
    }
    

}
-(void)tabBarBtnAction:(UIButton *)button{
    self.selectedIndex = button.tag;
//    NSLog(@"%ld",(long)button.tag);
}

- (void)settabBarHidden:(BOOL)isHidden{
    _tabbar.hidden = isHidden;
//    self.navigationController.navigationBarHidden = isHidden;
    
}
@end
