//
//  NewButton.m
//  看看天气
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "NewButton.h"

@implementation NewButton

- (void)setModel:(WeatherModel *)model{
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}
        
- (void)layoutSubviews{
//    NSLog(@"model:%@",_model);
    if (_model != nil) {
        NSString *classDate = _model.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:
                        classDate];
        _weekend.text = [self weekdayStringFromDate:date];
        NSDictionary *cond = _model.cond;
        _topWeather.text =  cond[@"txt_d"];
        _bottomWeather.text = cond[@"txt_n"];
        NSDictionary *wind = _model.wind;
        _wind.text = wind[@"dir"];
        _number.text = wind[@"sc"];
        //图片
        [self image:_topImage dic:cond];
        [self image:_bottomImage dic:cond];
        //日期 2015-10-27
        NSString *firstData = _model.date;
        NSArray *array = [firstData componentsSeparatedByString:@"-"];
        NSString *a = array[1];
        NSString *b = array[2];
        
        _date.text = [NSString stringWithFormat:@"%@/%@",a,b];
        
    }
}

- (void)image:(UIImageView *)imageView dic:(NSDictionary *)cond{
    if ([cond[@"txt_d"] isEqualToString:@"晴"]) {
        imageView.image = [UIImage imageNamed:@"w0.png"];
    }else if ([cond[@"txt_d"] isEqualToString:@"多云"]){
        imageView.image = [UIImage imageNamed:@"w1.png"];
    }else if ([cond[@"txt_d"] isEqualToString:@"阴"]){
        imageView.image = [UIImage imageNamed:@"w2.png"];
    }else if ([cond[@"txt_d"] isEqualToString:@"阵雨"]){
        imageView.image = [UIImage imageNamed:@"w3.png"];
    }else if ([cond[@"txt_d"] isEqualToString:@"多云"]){
        imageView.image = [UIImage imageNamed:@"w0.png"];
    }

}


- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
@end
