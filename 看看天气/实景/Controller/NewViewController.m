//
//  NewViewController.m
//  看看天气
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "NewViewController.h"
#import "NewTableViewCell.h"
#import "NewModel.h"
#import "MJRefresh.h"
#import "WeatherViewController.h"
#import "WebViewController.h"
#import "BaseTabBarController.h"
#define kScreenWidth self.view.bounds.size.width
#define kScreenHeight self.view.bounds.size.height
@interface NewViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_channelArray;
    NSMutableArray *_dataArray;
    UIImageView *_backImage;
    NewModel *_model;
    UITableView *_tableView;
    NSMutableArray *_data;
    UIScrollView *_scrollView;
}

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _channelArray = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    [self backImages];
    [self _loadChannelData];   //加载频道数据
    [self _createTableView];
}

- (void)setChannelId:(NSString *)channelId{
    if(_channelId != channelId){
        _channelId = channelId;
        [self _loadData];
    }
}


#pragma mark - 背景图片
-(void)backImages{
    _backImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _backImage.image = [UIImage imageNamed:@"bg_night_sunny.jpg"];
     [self.view addSubview:_backImage];
}

#pragma mark - 界面
- (void)interface{

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _scrollView.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.3];
    //创建子视图
    for(int i = 0;i<12;i++){
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*70 , 0, 70, 40)];
        NSDictionary *dic = _channelArray[i];
        NSString *str = dic[@"name"];
        [button setTitle:str forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.textColor = [UIColor whiteColor];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
    _scrollView.contentSize = CGSizeMake(70*12, 40);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.navigationController.navigationBar addSubview:_scrollView];
    
}

- (void)_createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-60-49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setBackgroundView:[[UIView alloc] init]];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"NewTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"NewTableViewCell"];
    [self.view addSubview:_tableView];
    
#pragma mark - 下拉刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewTableData)];
    
    
}
//下拉刷新方法
- (void)_loadNewTableData{
    [self performSelector:@selector(_finishLoad) withObject:nil afterDelay:2];
}

- (void)_finishLoad{
    
    [self _loadData];
    [_tableView.header endRefreshing];
}

#pragma UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewTableViewCell" forIndexPath:indexPath];
    cell.model =_data[indexPath.row];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController *webViewC = [[WebViewController alloc] init];
//    NSLog(@"dataArray:%@",_dataArray);
    NSDictionary *dic = _dataArray[indexPath.row];
        webViewC.link = dic[@"link"];
    
    webViewC.hidesBottomBarWhenPushed = YES;
//    _scrollView.hidden = YES;
    [self.navigationController pushViewController:webViewC animated:YES];
    
    
}

#pragma buttonAction
- (void)buttonAction:(UIButton *)button{
    for(int i = 0; i<12;i++){
        if (button.tag == i){
            NSDictionary *dic = _channelArray[i];
            self.channelId = dic[@"channelId"];
        }
    }
}

#pragma mark - 加载数据
- (void)_loadChannelData{
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/channel_news/channel_news";
    NSString *httpArg = @"";
    [self requestes: httpUrl withHttpArg: httpArg];
}

-(void)requestes: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
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
                                   NSDictionary *dic1 = dic[@"showapi_res_body"];
                                   NSArray *array = dic1[@"channelList"];
                                   
                                   [self _channel:array];
                                   
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   NSLog(@"HttpResponseBody %@",responseString);
//                                   NSLog(@"%@",array);
                               }
                           }];
    
}

- (void)_channel:(NSArray *)array{
    for(NSDictionary *dic in array){
        [_channelArray addObject:dic];
        
    }
//    NSLog(@"%@",_channelArray);
    [self interface];

}

- (void)_loadData{
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/channel_news/search_news";
   // NSString *httpArg = @"channelId=5572a109b3cdc86cf39001db";
    
//    NSLog(@"channelID:%@",_channelId);
    NSString *httpArg = [NSString stringWithFormat:@"channelId=%@",_channelId];
    [self request: httpUrl withHttpArg: httpArg];
//    NSLog(@"channelId:%@",httpArg);
    
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
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                   NSDictionary *dic1 = dic[@"showapi_res_body"];
                                   NSDictionary *dic2 = dic1[@"pagebean"];
                                   NSArray *array = dic2[@"contentlist"];
//                                   NSLog(@"%@",_dataArray);
                                   [self _data:array];
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
                               }
                           }];
}

- (void)_data:(NSArray *)array{
        _data = [NSMutableArray array];


    for (NSDictionary *dic in array){
        [_dataArray addObject:dic];
        [_tableView reloadData];

        //NSLog(@"%@",_dataArray);
        _model = [[NewModel alloc] initWithDataDic:dic];
        [_data addObject:_model];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    _scrollView.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    _scrollView.hidden = NO;
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
