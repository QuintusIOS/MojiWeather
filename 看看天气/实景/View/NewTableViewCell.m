//
//  NewTableViewCell.m
//  看看天气
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "NewTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation NewTableViewCell

- (void)setModel:(NewModel *)model{
    if (_model != model){
        _model = model;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    NSMutableArray *urlArray = [[NSMutableArray alloc] init];
    _text.text = _model.title;
    _timer.text = _model.pubDate;
    _add.text = _model.source;
    _link = _model.link;
    NSArray *array = _model.imageurls;
    for(NSDictionary *dic in array){
//        NSLog(@"dic:%@",dic);
        if(dic != nil){
            NSString *str = dic[@"url"];
            NSURL *url = [NSURL URLWithString:str];
            [_image sd_setImageWithURL:url];
            [urlArray addObject:str];
        }
        else{
            _image.image = nil;
        }
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
