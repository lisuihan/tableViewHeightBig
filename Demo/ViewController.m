//
//  ViewController.m
//  Demo
//
//  Created by admin on 2018/5/28.
//  Copyright © 2018年 cn.com.lichong. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tabbleview;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,assign) CGRect imgRect;
@property (nonatomic,assign) CGFloat imgHeight;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.hidden = YES;
    
    self.imgHeight = 200 / ([UIScreen mainScreen].bounds.size.height/[UIScreen mainScreen].bounds.size.width);
    
    _tabbleview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,  [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _tabbleview.delegate = self;
    _tabbleview.dataSource = self;
    _tabbleview.rowHeight = 50;
    _tabbleview.tableHeaderView =   [[UIView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _imgHeight)];
    [self.view addSubview:_tabbleview];
    
    
     UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
    img.frame =CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, _imgHeight);
    self.imgView = img;
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [img addGestureRecognizer:tapGesture];

    self.imgRect = img.frame;
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"nihao";
    cell.detailTextLabel.text = @"你好";
    return cell;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollY = scrollView.contentOffset.y;
    NSLog(@"%f",scrollY);
    if (scrollY < 0) {
        CGFloat height = self.imgRect.size.height - scrollY ;
        CGFloat width =  (height/200) * [UIScreen mainScreen].bounds.size.height;
        CGFloat x = self.imgRect.origin.x - (width - self.imgRect.size.width)/2;
        _imgView.frame = CGRectMake(x, 64, width, height);
    }else{
//
        CGRect frame = self.imgRect;
        frame.origin.y = _imgRect.origin.y - scrollY;
        _imgView.frame  = frame;
    }
}

-(void)tapClick:(UITapGestureRecognizer *)gesture
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
