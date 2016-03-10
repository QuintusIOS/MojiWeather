//
//  District.m
//  看看天气
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "District.h"

@implementation District

-(id)initWithDataDic:(NSDictionary *)dataDic{
    self = [super initWithDataDic:dataDic];
    if(self){
        self.name = dataDic[@"省"];
        self.shi = dataDic[@"市名"];
        _mutableArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
