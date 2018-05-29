//
//  ThreeViewController.m
//  Demo
//
//  Created by admin on 2018/5/29.
//  Copyright © 2018年 cn.com.lichong. All rights reserved.
//

#import "ThreeViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define  kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ThreeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIWebView *webView;
@property(nonatomic,strong) UIView          *transformView;//用来做第一面偏移的view，是 detailTableView
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //用来做偏移的view
    _transformView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 2)];
    _transformView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_transformView];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 50;
    [_transformView addSubview:_tableView];
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [_webView loadRequest:request];
    [_transformView addSubview:_webView];
    

    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self transfromToWebView];
    }];
    
    _webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self transformToTableView];
    }];
}

-(void)transfromToWebView
{
    [_tableView.mj_footer endRefreshing];
    [UIView animateWithDuration:0.3 animations:^{
        self.transformView.transform = CGAffineTransformTranslate(self.transformView.transform, 0, -kScreenHeight);
    }];
}

-(void)transformToTableView
{
    [_webView.scrollView.mj_header endRefreshing];
    [UIView animateWithDuration:0.3 animations:^{
       self.transformView.transform = CGAffineTransformIdentity;
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text = @"我好";
    return cell;
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
