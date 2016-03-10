//
//  NewButton.h
//  看看天气
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"
@interface NewButton : UIButton

//- (id)initWithDate1:(UILabel *)date1 weath1:(UILabel *)weath1 imageView1:(UIImageView *)imageView1 max:(UILabel *)max min:(UILabel *)min imageView2:(UIImageView *)imageView2 weath2:(UILabel *)weath2 Date2:(UILabel *)date2 wind:(UILabel *)wind frame:(CGRect)frame;

@property (nonatomic, strong) WeatherModel *model;

@property (strong, nonatomic) IBOutlet UILabel *weekend;
@property (strong, nonatomic) IBOutlet UILabel *topWeather;
@property (strong, nonatomic) IBOutlet UIImageView *topImage;
@property (strong, nonatomic) IBOutlet UIImageView *bottomImage;
@property (strong, nonatomic) IBOutlet UILabel *bottomWeather;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *wind;
@property (strong, nonatomic) IBOutlet UILabel *number;




@end
