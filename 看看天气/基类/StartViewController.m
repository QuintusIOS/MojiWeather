//
//  StartViewController.m
//  看看天气
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "StartViewController.h"
#import "WeatherViewController.h"
#define kVersion   [[UIDevice currentDevice].systemVersion doubleValue]
#define kScreenWidth self.view.bounds.size.width
#define kScreenHeight self.view.bounds.size.height
@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _create];
    [self createData];
}
- (void)_create{
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.7];
    [self.view addSubview:view];
}
- (void)createData{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        
        if (kVersion > 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
        
    }
    //设置定位精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];

}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"已经更新位置");
    [_locationManager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"经度 %lf 纬度 %lf",coordinate.longitude,coordinate.latitude);
    
    
    //二 iOS内置
    
    CLGeocoder  *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *place = [placemarks lastObject];
        NSString *string = place.name;
        NSArray *array = [string componentsSeparatedByString:@"省"];
        NSArray *array1 = [array[1] componentsSeparatedByString:@"市"];
        _city = array1[0];
        NSLog(@"%@",array1[0]);
        
        [self go];
    }];
    //----

    
    
    
}

- (void)go{
    //---跳转到主界面
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [story instantiateInitialViewController];
    self.view.window.rootViewController = vc;
    vc.view.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    [UIView animateWithDuration:0.3 animations:^{
        vc.view.transform = CGAffineTransformIdentity;
    }];
    WeatherViewController *weather = [[WeatherViewController alloc] init];
//    weather.str = _city;

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
