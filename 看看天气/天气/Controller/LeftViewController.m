//
//  LeftViewController.m
//  看看天气
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "LeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "District.h"
#import "WeatherViewController.h"
#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#define kScreenWidth self.view.bounds.size.width
#define kScreenHeight self.view.bounds.size.height
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_arrayData;
    BOOL isHide[200];
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createView];
    [self _loadCityList];
    [self _createTableView];

}

- (void)_createView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    view.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.8];
    [self.view addSubview:view];
}
-(void)_loadCityList
{
    NSString *cityPath = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:cityPath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //    NSLog(@"%@",dic);
    _arrayData = dic[@"城市代码"];
//    NSLog(@"%@",_arrayData);
    
    
}



-(void)_createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 170, kScreenHeight-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = _arrayData[section];
    NSArray *array = dic[@"市"];
    if (isHide[section]) {
        return array.count;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yyj"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"yyj"];
        
    }
    NSDictionary *dic = _arrayData[indexPath.section];
    NSArray *array = dic[@"市"];
    NSDictionary *cityDic = array[indexPath.row];
    cell.textLabel.text = cityDic[@"市名"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrayData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    btn.tag = section;
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSDictionary *dic = _arrayData[section];
    NSString *name = dic[@"省"];
    
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitle:name forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnWay:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _arrayData[indexPath.section];
    NSArray *array = dic[@"市"];
    NSDictionary *cityDic = array[indexPath.row];
    _city = cityDic[@"市名"];
//
//    WeatherViewController *weather = [[WeatherViewController alloc] init];
    BaseTabBarController *tabBar = (BaseTabBarController *)self.mm_drawerController.centerViewController;
    BaseNavigationController *navi = tabBar.viewControllers[0];
    WeatherViewController *weather = (WeatherViewController *)navi.topViewController;
    
    weather.str = _city;
    NSLog(@"left:%@",_city);
    
}


-(void)btnWay:(UIButton *)btn
{
    isHide[btn.tag] = !isHide[btn.tag];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:btn.tag];
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    
    
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
