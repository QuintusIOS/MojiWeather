//
//  District.h
//  看看天气
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 zzl. All rights reserved.
//
/*
"城市代码": [
         {
             "省": "北京",
             "市": [
                   {
                       "市名": "北京",
                       "编码": "101010100"
                   },
                   {
                       "市名": "朝阳",
                       "编码": "101010300"
                   },
 */

#import "BaseModel.h"

@interface District : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *shi;
@property (nonatomic, copy) NSMutableArray *mutableArray;

@end
