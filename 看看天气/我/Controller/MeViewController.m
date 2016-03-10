//
//  MeViewController.m
//  看看天气
//
//  Created by mac on 15/10/2.
//  Copyright (c) 2015年 zzl. All rights reserved.
//
#define kScreenWidth self.view.bounds.size.width
#define kScreenHeight self.view.bounds.size.height

#import "MeViewController.h"

@interface MeViewController ()
{
        NSArray *_titel;
        NSArray *_imageStr;
        UITableView *_tableV;
        UILabel *_cacheLable;
        UIImageView *_headImageV;
}


@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"个人";
    
    _imageStr = @[@"profile_dresshelper_icon@2x.png",@"profile_recommendation_icon@2x.png",@"profile_mojimall_icon@2x.png",@"profile_personalpage_icon@2x.png",@"profile_share_icon@2x.png",@"profile_settings_icon@2x.png",@"profile_draftbox_icon@2x"];
    _titel = @[@"穿衣助手",@"游戏频道",@"墨迹商城",@"空气果",@"社交账号",@"设置",@"清除缓存"];

    [self _dataWay];
    [self _createHeadView];
}

- (void)createView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    view.backgroundColor = [UIColor blackColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    label.text = @"我";
    label.font = [UIFont systemFontOfSize:28];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
//    [view addSubview:label];
    [self.view addSubview:view];
}

-(void)_createHeadView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    headView.backgroundColor = [UIColor redColor];
    _tableV.tableHeaderView = headView;
    
    _headImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    _headImageV.image = [UIImage imageNamed:@"profile_default_bg@2x.png"];
    [headView addSubview:_headImageV];
    //登录label
//    UILabel *enterLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 110, 100, 15)];
//    enterLabel.text = @"请点击登录";
//    enterLabel.textColor = [UIColor grayColor];
//    enterLabel.font = [UIFont systemFontOfSize:16];
//    [headImageV addSubview:enterLabel];
    //登录图片
    UIImageView *enterImageV = [[UIImageView alloc]initWithFrame:CGRectMake(125, 30, 65, 65)];
    enterImageV.image = [UIImage imageNamed:@"headIcon_placeholder.png"];
    [_headImageV addSubview:enterImageV];
    //版本label
    UILabel *editionLabel = [[UILabel alloc]initWithFrame:CGRectMake(275, 30, 50, 10)];
    editionLabel.text = @"V5.7.0";
    editionLabel.textColor = [UIColor whiteColor];
    editionLabel.font = [UIFont systemFontOfSize:12];
    [_headImageV addSubview:editionLabel];
    //墨迹公告图像
    UIImageView *publicImageV = [[UIImageView alloc]initWithFrame:CGRectMake(200, 50, 30, 30)];
    publicImageV.image = [UIImage imageNamed:@"cm_forum_msg_normal@2x.png"];
    [_headImageV addSubview:publicImageV];
    
}


- (void)_dataWay{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight+16) style:UITableViewStylePlain];
    _tableV.dataSource = self;
    _tableV.delegate = self;
    _tableV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableV];
//    [self createView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"moreCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moreCell"];
        //1.创建图片视图
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        imageView.tag = 1;
        [cell.contentView addSubview:imageView];
        //2.标题视图
        UILabel *titlelable = [[UILabel alloc] initWithFrame:CGRectMake(40 + 30, 10, 200, 30)];
        titlelable.tag = 2;
        titlelable.font = [UIFont boldSystemFontOfSize:18];
        //        titlelable.textColor = [UIColor whiteColor];
        //        titlelable.text = _titel[indexPath.row];
        //        titlelable.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:titlelable];
        //单元格选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            
            _cacheLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 15, 70, 30)];
            _cacheLable.textAlignment = NSTextAlignmentCenter;
            _cacheLable.tag = 3;
            _cacheLable.font = [UIFont boldSystemFontOfSize:18];
            _cacheLable.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:_cacheLable];
            
            //            _cacheLable.text=[NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
        }
        
    }
    
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    
    //2.填充信息
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
    UILabel *lable = (UILabel *)[cell.contentView viewWithTag:2];
    
    imageView.image = [UIImage imageNamed:_imageStr[indexPath.row]];
    lable.text = _titel[indexPath.row];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要清理缓存" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset = _tableV.contentOffset.y;
    //向上偏移量变正  向下偏移量变负
    if (yOffset < -64) {
        CGFloat factor = ABS(yOffset)+200-64;
        CGRect f = CGRectMake(-([[UIScreen mainScreen] bounds].size.width*factor/200-[[UIScreen mainScreen] bounds].size.width)/2,-ABS(yOffset)+64, [[UIScreen mainScreen] bounds].size.width*factor/200, factor);
        _headImageV.frame = f;
    }else {
        CGRect f = _headImageV.frame;
        f.origin.y = 0;
        _headImageV.frame = f;
        _headImageV.frame = CGRectMake(0, f.origin.y, [[UIScreen mainScreen] bounds].size.width, 200);
    }
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
