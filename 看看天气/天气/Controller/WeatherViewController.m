//
//  WeatherViewController.m
//  看看天气
//
//  Created by mac on 15/10/2.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "WeatherViewController.h"
#import "TabBarButton.h"
//#import "LeftViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "NewButton.h"
#import "WeatherModel.h"

#define kScreenWidth self.view.bounds.size.width
#define kScreenHeight self.view.bounds.size.height
#define kVersion [[UIDevice currentDevice].systemVersion doubleValue]

@interface WeatherViewController ()
{
    TabBarButton *_titleButton;
    BOOL isTwoTemp;
    NSMutableArray *_data;
    NSMutableArray *_modelArray;
    NewButton *_button;
    WeatherModel *_model;
    UIScrollView *_smallScrollView;
    NSString *_bbbbb;
    NSString *_cityName;
    NSString *_timerDate;
}
@end

@implementation WeatherViewController


- (void)dealloc{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createaaa];
    _data = [[NSMutableArray alloc] init];
//    [self notTification];
    //加载数据
//    [self loadData];
    //背景图片
    [self backImages];
    [self createNavBtn];
//    [self createScrollView];
    [self temperature];
    [self stuffData];
//    [self createScrollView];

    
//    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
//    window.windowLevel = UIWindowLevelStatusBar;
//    window.backgroundColor = [UIColor blackColor];
//    window.hidden = NO;
}



- (void)createaaa{

//    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
   // ------------定位
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        BOOL first = [user boolForKey:@"first"];

        if (first) {
//            [self.navigationController.navigationBar setHidden:YES];
            _LoadView.hidden = NO;
            
            [self createData];
        }
     //第一次运行完成后 执行以下代码
    [user setBool:@YES forKey:@"first"];

//    [self loadData];

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
        _bbbbb = array1[0];
        NSLog(@"%@",_bbbbb);

        [self loadData];
        _LoadView.hidden = YES;
//----
//        [self.navigationController.navigationBar setHidden:NO];

    }];


    
    
}

-(void)setStr:(NSString *)str{
    if(_str != str){
        _str = str;
        [self loadData];
    
    }
}

- (void)notTification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationCenter" object:self];
}

-(void)createTitle{
    //    self.title = @"天气";
//    NSString *timer = @"10月3日 周六";
    [self timer];
    _titleButton = [[TabBarButton alloc]initWithCity:_cityName time:_timerDate];
    self.navigationItem.titleView = _titleButton;
    [_titleButton addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)timer{
    NSDate * senddate=[NSDate date];
    
    NSCalendar * cal=[NSCalendar currentCalendar];
    
    NSUInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    
    NSInteger year=[conponent year];
    
    NSInteger month=[conponent month];
    
    NSInteger day=[conponent day];
    
    NSString * nsDateString= [NSString stringWithFormat:@"%4ld-%2ld-%2ld",(long)year,(long)month,(long)day];
    NSLog(@"%@",nsDateString);
    [self loaddara:nsDateString];
}

- (void)loaddara:(NSString *)timer{
    NSString *classDate = timer;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:
                    classDate];
    NSString *a = [self weekdayStringFromDate:date];
    NSArray *array = [timer componentsSeparatedByString:@"-"];
    NSString *a1 = array[1];
    NSString *a2 = array[2];
    _timerDate = [NSString stringWithFormat:@"%@月%@日 %@",a1,a2,a];
    NSLog(@"%@",_timerDate);
}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}



#pragma mark - 背景图片
-(void)backImages{
    
    _backImage.image = [UIImage imageNamed:@"bg_night_snow.jpg"];
   // [self.view addSubview:_backImage];
}
#pragma mark - 导航 按钮
-(void)createNavBtn{
    UIButton *but1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 33, 33)];
    [but1 setImage:[UIImage imageNamed:@"homepage_share_button_pressed"] forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(btn1Action:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:but1];
    self.navigationItem.rightBarButtonItem = right;
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 33, 33)];
    [btn2 setImage:[UIImage imageNamed:@"profile_homepage_icon@2x"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Action:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    self.navigationItem.leftBarButtonItem = left;

}
-(void)createScrollView{

    //是否分页
    _scrollView.pagingEnabled = YES;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_black addGestureRecognizer:tap];
//    _scrollView.delegate = self;
    //[_backImage addSubview:_scrollView];
    
    [self _cteateSmallScrollView];
    
}
-(void)_cteateSmallScrollView{
    _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 604-70, kScreenWidth, 404+70-49)];
    _smallScrollView.contentSize = CGSizeMake(60*7, 404+70-49);
    _smallScrollView.delegate = self;
    _smallScrollView.showsHorizontalScrollIndicator = NO;
    _smallScrollView.showsVerticalScrollIndicator = NO;
    _smallScrollView.bounces = NO;
    [_scrollView addSubview:_smallScrollView];
    [self _createSmallScrollUIView:_smallScrollView];
    
}

-(void)_createSmallScrollUIView:(UIScrollView *)scroll{
//    NSArray *array = @[ [UIColor redColor],
//                        [UIColor yellowColor],
//                        [UIColor orangeColor],
//                        [UIColor blackColor],
//                        [UIColor blueColor],
//                        [UIColor greenColor],
//                        [UIColor purpleColor]];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60*70, kScreenHeight)];
    view.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.5];
    [scroll addSubview:view];
    
    for (int i = 0; i<7; i++) {
        _button = [[[NSBundle mainBundle] loadNibNamed:@"NewButton" owner:self options:nil]firstObject];
        
        _button.frame = CGRectMake(i*60, 0, 60, kScreenHeight);
//        _button.center = CGPointMake(60*i, kScreenHeight/2);
        _button.tag = i;
        _button.backgroundColor = [UIColor clearColor];
        if (_modelArray.count != 0) {
            _button.model = _modelArray[i];
        }
        _button.layer.borderColor = [UIColor whiteColor].CGColor;
        _button.layer.borderWidth = 0.5;
        [scroll addSubview:_button];
    }
}
-(void)temperature{
    UITapGestureRecognizer *top = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topTemperature:)];
    top.numberOfTapsRequired = 1;
    top.numberOfTouchesRequired = 1;
    isTwoTemp = NO;
    [_temperatureView addGestureRecognizer:top];
    
    UITapGestureRecognizer *twoTop = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoTopTemperature:)];
    twoTop.numberOfTapsRequired = 1;
    twoTop.numberOfTouchesRequired = 1;

    [_twoTemper addGestureRecognizer:twoTop];

    
}

-(void)tap:(UITapGestureRecognizer *)tap{
    _share.hidden = YES;
    _black.hidden = YES;
}
-(void)topTemperature:(UITapGestureRecognizer *)top{
        _twoTemper.hidden = NO;
}
-(void)twoTopTemperature:(UITapGestureRecognizer *)top{
    _twoTemper.hidden = YES;
}

#pragma mark - 加载数据
-(void)loadData{
    NSString *httpUrl = @"http://apis.baidu.com/heweather/weather/free";
    NSString *aa;
    if(_str == nil){
        aa = _bbbbb;
    }else{
        aa = _str;
    }
    NSString *url = [NSString stringWithFormat:@"city=%@",aa];
    NSLog(@"url:%@",url);
    NSString *encodedValue = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self request: httpUrl withHttpArg:encodedValue];

//    [self request: httpUrl withHttpArg: httpArg];
}
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"6da05c73d68ae47bad8dd61b08da5589" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                   NSArray *array = dic[@"HeWeather data service 3.0"];
//                                   dispatch_sync(dispatch_get_main_queue(), ^{
                                       [self _data:array];

//                                   }) ;
                                   
                                   
                                   
                               }
                           }];
}

- (void)_data:(NSArray *)array{
    
    NSDictionary *dic1 = array[0];
#pragma mark - mainView
    //hourly_forecast   每三小时天气预报
    NSDictionary *now = dic1[@"now"];
    //温度
    NSString *tmp = now[@"tmp"];
    self.mainTemperature.text = [NSString stringWithFormat:@"%@℃",tmp];
    //天气
    NSDictionary *cond = now[@"cond"];
    NSString *txt = cond[@"txt"];
    self.mainWeather.text = txt;
    //--------basic------基本信息
    NSDictionary *basic = dic1[@"basic"];
    NSString *city = basic[@"city"];
   // _mainCity.text = city;
    _cityName = city;

    self.mainCity.text = city;
    
#pragma mark - 发布时间
    NSDictionary *update = basic[@"update"];
    NSArray *locArray = [update[@"loc"] componentsSeparatedByString:@" "];
    NSString *loc = locArray[1];
    _insueTimer.text = [NSString stringWithFormat:@"今天%@发布",loc];
#pragma mark - leftView
    NSArray *daily_forecast = dic1[@"daily_forecast"];
    NSDictionary *firstDay = daily_forecast[0];
    NSDictionary *lefCond = firstDay[@"cond"];
    NSString *leftTxt_d = lefCond[@"txt_d"];
    NSString *leftTxt_n = lefCond[@"txt_n"];
    if([leftTxt_d isEqualToString:leftTxt_n]){
        _leftWeather.text = leftTxt_d;
    }else{
        _leftWeather.text = [NSString stringWithFormat:@"%@转%@",leftTxt_d,leftTxt_n];
    }
    NSDictionary *leftTmp = firstDay[@"tmp"];
    NSString *leftMax = leftTmp[@"max"];
    NSString *leftMin = leftTmp[@"min"];
    _leftTemperatures.text = [NSString stringWithFormat:@"%@/%@℃",leftMax,leftMin];
    
#pragma mark - rightView
    NSDictionary *secondDay = daily_forecast[1];
    NSDictionary *rightCond = secondDay[@"cond"];
    NSString *rightTxt_d = rightCond[@"txt_d"];
    NSString *rightTxt_n = rightCond[@"txt_n"];
    if([rightTxt_d isEqualToString:rightTxt_n]){
        _rightWeather.text = rightTxt_d;
    }else{
        _rightWeather.text = [NSString stringWithFormat:@"%@转%@",rightTxt_d,rightTxt_n];
    }
    NSDictionary *rightTmp = secondDay[@"tmp"];
    NSString *rightMax = rightTmp[@"max"];
    NSString *rightMin = rightTmp[@"min"];
    _leftTemperatures.text = [NSString stringWithFormat:@"%@/%@℃",rightMax,rightMin];
#pragma mark - 空气质量
    NSDictionary *aqi = dic1[@"aqi"];
    NSDictionary *cityAqi = aqi[@"city"];
    _airMass.text = cityAqi[@"aqi"];
    
#pragma mark - 隐藏控件数据
    _hiddenTemperatures.text = [NSString stringWithFormat:@"%@℃",tmp];
    _hiddenWeather.text = cond[@"txt"];
    NSDictionary *suggestion = dic1[@"suggestion"];
    NSDictionary *sport = suggestion[@"sport"];
    _hiddenSport.text = sport[@"txt"];
    NSString *fl = now[@"fl"];
    _hiddenTemperaturess.text = [NSString stringWithFormat:@"%@℃",fl];
    _hiddenHum.text = now[@"hum"];
    NSDictionary *wind = now[@"wind"];
    NSString *dir = wind[@"dir"];
    NSString *sc = wind[@"sc"];
    _hiddenWind.text = [NSString stringWithFormat:@"%@%@级",dir,sc];
    NSDictionary *uv = suggestion[@"uv"];
    _hiddenUv.text = uv[@"brf"];
    _hiddenPres.text =[NSString stringWithFormat:@"%@hPa",now[@"pres"]];
    
#pragma mark - 七天数据
    _modelArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in daily_forecast) {
        _model = [[WeatherModel alloc] initWithDataDic:dic];
        [_modelArray addObject:_model];
    };
    [_smallScrollView removeFromSuperview];
    [self createScrollView];
    [_titleButton removeFromSuperview];
    [self.navigationItem.titleView removeFromSuperview];
    [self createTitle];

//    _button.model = _model;
//    NSLog(@"%@",leftTmp);
}

#pragma mark - 填充数据
- (void)stuffData{
    _leftView.layer.borderColor = [UIColor whiteColor].CGColor;
    _leftView.layer.borderWidth = 1;
    _right.layer.borderColor = [UIColor whiteColor].CGColor;
    _right.layer.borderWidth = 1;

}

#pragma mark - ButtonAction
-(void)titleButtonAction:(TabBarButton *)tabButton{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    
}

-(void)btn1Action:(UIButton *)btn1{
    
    btn1.selected = !btn1.selected;
    if (btn1.selected) {
        _share.hidden = NO;
        _black.hidden = NO;
    }else{
        _share.hidden = YES;
        _black.hidden = YES;
    }
}
-(void)btn2Action:(UIButton *)btn2{
    [self titleButtonAction:nil];
    
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
