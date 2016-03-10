//
//  AppDelegate.m
//  看看天气
//
//  Created by mac on 15/10/2.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "MMDrawerController.h"
#import "ViewController.h"
#import "BaseTabBarController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "StartViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //-----MMDrawerController---
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BaseTabBarController *baseTabBar = [storyboard instantiateInitialViewController];
    
    
    
//    BaseTabBarController *baseTab = [[BaseTabBarController alloc] init];
    LeftViewController *leftC = [[LeftViewController alloc] init];
    MMDrawerController *mmDraw = [[MMDrawerController alloc] initWithCenterViewController:baseTabBar leftDrawerViewController:leftC];
    
    [mmDraw setMaximumLeftDrawerWidth:150];
    
    [mmDraw setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmDraw setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    //动画效果
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    [mmDraw setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController,drawerSide,percentVisible);
        }
    }];
    
    //
    self.window.rootViewController = mmDraw;
    
    
    //------------定位
//    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//    BOOL first=[user boolForKey:@"first"];
//    if (!first) {
//        StartViewController *start = [[StartViewController alloc] init];
//        self.window.rootViewController = start;
//    }
    // 第一次运行完成后 执行以下代码
    //[user setBool:@YES forKey:@"first"];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
