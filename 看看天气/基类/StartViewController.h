//
//  StartViewController.h
//  看看天气
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface StartViewController : ViewController<CLLocationManagerDelegate>{
    //------定位---------
    
    CLLocationManager *_locationManager;
    UILabel *_locLabel;
    
}
@property (nonatomic, strong) NSString *city;

@end
