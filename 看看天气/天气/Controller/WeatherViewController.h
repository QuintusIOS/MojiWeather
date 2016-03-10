//
//  WeatherViewController.h
//  看看天气
//
//  Created by mac on 15/10/2.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface WeatherViewController : BaseViewController <UIScrollViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;
    UILabel *_locLabel;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scroll;




@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *share;

@property (weak, nonatomic) IBOutlet UIView *black;

@property (weak, nonatomic) IBOutlet UIView *temperatureView;

@property (weak, nonatomic) IBOutlet UIView *twoTemper;
//------主天气－今天
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UILabel *mainTemperature;
@property (strong, nonatomic) IBOutlet UILabel *mainWeather;
@property (weak, nonatomic) IBOutlet UILabel *mainCity;


//------左下角天气－今天
@property (strong, nonatomic) IBOutlet UIView *leftView;
@property (strong, nonatomic) IBOutlet UILabel *leftWeather;
@property (strong, nonatomic) IBOutlet UILabel *leftTemperatures;

//------右下角天气－明天
@property (strong, nonatomic) IBOutlet UIView *right;
@property (strong, nonatomic) IBOutlet UILabel *rightWeather;
@property (strong, nonatomic) IBOutlet UILabel *rightTemperatures;

//------发布时间------
@property (strong, nonatomic) IBOutlet UILabel *insueTimer;
//------空气质量------
@property (strong, nonatomic) IBOutlet UILabel *airMass;

//------隐藏控件------
@property (strong, nonatomic) IBOutlet UILabel *hiddenTemperatures;
@property (strong, nonatomic) IBOutlet UILabel *hiddenWeather;
@property (strong, nonatomic) IBOutlet UILabel *hiddenSport;
@property (strong, nonatomic) IBOutlet UILabel *hiddenTemperaturess;
@property (strong, nonatomic) IBOutlet UILabel *hiddenHum;
@property (strong, nonatomic) IBOutlet UILabel *hiddenWind;
@property (strong, nonatomic) IBOutlet UILabel *hiddenUv;
@property (strong, nonatomic) IBOutlet UILabel *hiddenPres;
//------

@property (nonatomic ,strong) NSString *str;


@property (strong, nonatomic) IBOutlet UIView *LoadView;




@end
