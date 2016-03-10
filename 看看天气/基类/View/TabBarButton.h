//
//  TabBarButton.h
//  看看天气
//
//  Created by mac on 15/10/2.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarButton : UIButton

-(id)initWithTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame;
-(id)initWithCity:(NSString *)city time:(NSString *)time;
@end
