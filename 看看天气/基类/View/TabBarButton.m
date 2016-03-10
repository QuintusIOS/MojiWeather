//
//  TabBarButton.m
//  看看天气
//
//  Created by mac on 15/10/2.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "TabBarButton.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation TabBarButton

-(id)initWithTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.frame = CGRectMake(40, 5, 27, 24);
        [self addSubview:imageView];
        UILabel *label = [[UILabel alloc]init];
        label.text = title;
        label.font = [UIFont boldSystemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(38, 30, 30, 20);
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
    
    }
    return self;

}
//自定义导航栏title
-(id)initWithCity:(NSString *)city time:(NSString *)time{
    self = [super init];
    if(self){
        UILabel *citys = [[UILabel alloc]init];
        citys.text = city;
        citys.font = [UIFont boldSystemFontOfSize:22];
        citys.textAlignment = NSTextAlignmentCenter;
        citys.frame = CGRectMake(-35, 5-28, 100, 30);
        citys.textColor = [UIColor whiteColor];
        [self addSubview:citys];
        UILabel *times = [[UILabel alloc]init];
        times.text = time;
        times.font = [UIFont boldSystemFontOfSize:12];
        times.textAlignment = NSTextAlignmentCenter;
        times.textColor = [UIColor whiteColor];
        times.frame = CGRectMake(-35, 22-28, 100, 30);
        [self addSubview:times];
    }
    
    return self;
    
}
@end
