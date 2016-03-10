//
//  WebViewController.m
//  看看天气
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 zzl. All rights reserved.
//

#import "WebViewController.h"
#import "NewModel.h"
#import "NewTableViewCell.h"
#define kScreenWidth self.view.bounds.size.width
#define kScreenHeight self.view.bounds.size.height
@interface WebViewController ()
{
    UIWebView *_webView;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self createTitle];
    
}

- (void)createBottonmView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
}

- (void)createTitle{
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    label.text = @"网页";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:45];
    [self.navigationItem.titleView addSubview:label];
}
- (void)createView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    view.backgroundColor = [UIColor blackColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125, 25, 80, 30)];
    label.text = @"网页";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:21];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [self.view addSubview:view];
}
- (void)createWeb:(NSString *)link{

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake( 0, 0, kScreenWidth, kScreenHeight)];
    NSURL *url = [NSURL URLWithString:_link];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];

    [self.view addSubview:_webView];
    
    [self createView];
    [self createBottonmView];



}


-(void)setLink:(NSString *)link
{
    if (_link != link){
        _link = link;
        NSLog(@"link:%@",link);
        [self createWeb:link];

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
