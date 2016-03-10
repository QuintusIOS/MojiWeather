//
//  WeatherModel.h
//  看看天气
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

/*
{
    "date": "2015-07-02", //预报日期
    "astro": { //天文数值
        "sr": "04:50", //日出时间
        "ss": "19:47" //日落时间
    },
    "cond": { //天气状况
        "code_d": "100", //白天天气状况代码，参考http://www.heweather.com/documents/condition-code
        "code_n": "100", //夜间天气状况代码
        "txt_d": "晴", //白天天气状况描述
        "txt_n": "晴" //夜间天气状况描述
    },
    "hum": "14", //相对湿度（%）
    "pcpn": "0.0", //降水量（mm）
    "pop": "0", //降水概率
    "pres": "1003", //气压
    "tmp": { //温度
        "max": "34℃", //最高温度
        "min": "18℃" //最低温度
    },
    "vis": "10", //能见度（km）
    "wind": { //风力风向
        "deg": "339", //风向（360度）
        "dir": "东南风", //风向
        "sc": "3-4", //风力
        "spd": "15" //风速（kmph）
    }
}
*/
#import "BaseModel.h"

@interface WeatherModel : BaseModel
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSDictionary *cond;
@property (nonatomic, copy) NSDictionary *tmp;
@property (nonatomic, copy) NSDictionary *wind;

@end
