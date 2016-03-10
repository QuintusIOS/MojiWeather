//
//  NewTableViewCell.h
//  看看天气
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"
@interface NewTableViewCell : UITableViewCell

@property (nonatomic, strong) NewModel *model;

@property (strong, nonatomic) IBOutlet UILabel *text;

@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) IBOutlet UILabel *timer;

@property (strong, nonatomic) IBOutlet UILabel *add;

@property (nonatomic, strong) NSString *link;
@end
