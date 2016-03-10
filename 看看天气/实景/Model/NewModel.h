//
//  NewModel.h
//  看看天气
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 zzl. All rights reserved.
//
/*
 {
 "channelId": "5572a109b3cdc86cf39001db",
 "channelName": "国内最新",
 "desc": "庾澄庆在微博上贴出和儿子的合影，并配以简短霸气的两个字“爷俩”，与儿子亲密出游的兴奋心情呼之欲...",
 "imageurls": [
 {
 "height": 119,
 "url": "http://img6.cache.netease.com/m/2015/7/6/2015070615554615c92.jpg",
 "width": 169
 },
 {
 "height": 119,
 "url": "http://img3.cache.netease.com/m/2015/7/6/201507061555485d21e.jpg",
 "width": 169
 },
 {
 "height": 119,
 "url": "http://img6.cache.netease.com/m/2015/7/6/201507061555503f2e8.jpg",
 "width": 169
 }
 ],
 "link": "http://help.3g.163.com/15/0706/15/ATRQ75VN00963VRR.html",
 "nid": "15819252514074808917",
 "pubDate": "2015-07-06 16:22:30",
 "source": "网易娱乐",
 "title": "庾澄庆父子亲密出游 哈利长高"
 },
 */

#import "BaseModel.h"

@interface NewModel : BaseModel
@property (nonatomic, copy) NSArray *imageurls; //照片数组
@property (nonatomic, copy) NSString *title;    //标题
@property (nonatomic, copy) NSString *pubDate;  //时间
@property (nonatomic, copy) NSString *source;   //来源
@property (nonatomic, copy) NSString *link;     //网址

@end
