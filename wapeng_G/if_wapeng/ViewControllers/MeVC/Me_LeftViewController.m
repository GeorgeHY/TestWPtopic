//
//  Me_LeftViewController.m
//  if_wapeng
//
//  Created by 永不死的圣斗士 on 14-6-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define dTag_HeadPicBtn 100
#define dTag_HeadFoucsBtn 101
#import "Me_LeftViewController.h"
#import "SideBarSelectedDelegate.h"
#import "LeftDetailVC01.h"
#import "Cell_LeftVC01.h"
#import "SettingViewController.h"
#import "PrivateMessageViewController.h"
#import "MeMessageViewController.h"
@interface Me_LeftViewController ()
{
    NSArray * _dataList;//数据源
    NSArray * _diaryList;//日记section数据源

    int _selectIndex;
    
    float nav_Y;
    
    float nav_H;
    
    float status_Y;
    
}
@end

@implementation Me_LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initUIView];
}

-(void)initUIView
{
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    nav_H = [[d objectForKey:UD_navH]floatValue];
    
    nav_Y = [[d objectForKey:UD_navY]floatValue];
    
    
//    if (SystemVersion >= 7.0) {
//        
//        status_Y = 20;
//    }
    UIView * topMainView = [[UIView alloc]initWithFrame:CGRectMake(0, status_Y, 320, 60)];
    
    UIButton * headPicBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 10, 40, 40)];
    
    [headPicBtn setTitle:@"头像" forState:UIControlStateNormal];
    
    headPicBtn.backgroundColor = [UIColor greenColor];
    headPicBtn.tag = dTag_HeadPicBtn;
    
    [headPicBtn addTarget:self action:@selector(topMainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topMainView addSubview:headPicBtn];
    
    
    UIButton * headFoucsBtn = [[UIButton alloc]initWithFrame:CGRectMake(176, 10, 40, 40)];
    
    [headFoucsBtn setTitle:@"添加关注" forState:UIControlStateNormal];
    
    headFoucsBtn.backgroundColor = [UIColor greenColor];
    
    headFoucsBtn.tag = dTag_HeadFoucsBtn;
    
    [headFoucsBtn addTarget:self action:@selector(topMainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topMainView addSubview:headFoucsBtn];
    
    topMainView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:topMainView];
    
    _dataList = @[@"宝宝日记", @"日常杂感", @"+", @"我的橱窗", @"我的私信", @"我的消息", @"我的资料",@"宝宝资料",@"我的设置",@"我的话题",@"我的活动"];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topMainView.frame.origin.y + topMainView.frame.size.height , 256, self.view.frame.size.height - 49 - 80)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    if ([self.delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        
        [self.delegate leftSideBarSelectWithController:[self subConWithIndex:0]];
    }
}
//topMainVC上的两个按钮被点击
-(void)topMainBtnClick:(UIButton *)button
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList count];
}
- (Cell_LeftVC01 *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    Cell_LeftVC01 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[Cell_LeftVC01 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    
    
    cell.mainLabel.text = [_dataList objectAtIndex:indexPath.row];
    
    return cell;
}

- (UIViewController *)subConWithIndex:(int)index
{
//    FirstViewController *con = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
//    con.index = index+1;
    [SVProgressHUD showSimpleText:[NSString stringWithFormat:@"index:%d", index]];
    if (index == 0) {
        
        LeftDetailVC01 * vc01  = [[LeftDetailVC01 alloc]init];
        
        vc01.index = index + 1;
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:vc01];
        
        nav.navigationBar.hidden = NO;
        nav.navigationBar.backgroundColor = [UIColor greenColor];
        
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_title.png"] forBarMetrics:UIBarMetricsDefault];
        return nav;
    }
    
   
    if (index == 4) {
        
        PrivateMessageViewController * privateVC = [[PrivateMessageViewController alloc]init];
//        privateVC.index = index + 1;
        privateVC.index = index + 1;
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:privateVC];
        
        nav.navigationBar.hidden = NO;
        
        nav.navigationBar.backgroundColor = [UIColor greenColor];
        
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_title.png"] forBarMetrics:UIBarMetricsDefault];
        
        return nav;

        
        
    }
    if (index == 5) {
        
        MeMessageViewController * msgVC = [[MeMessageViewController alloc]init];
        
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:msgVC];
        
        nc.navigationBar.hidden = NO;
        
         [nc.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_title.png"] forBarMetrics:UIBarMetricsDefault];
        
        return nc;
    }
    
    if (index == 8) {
        
        SettingViewController * settingVC  = [[SettingViewController alloc]init];
        
        settingVC.index = index + 1;
        
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:settingVC];
        
        nav.navigationBar.hidden = NO;
        nav.navigationBar.backgroundColor = [UIColor greenColor];
        
        nav.title = @"设置";
        
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_title.png"] forBarMetrics:UIBarMetricsDefault];
        
        return nav;

    }
    
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        if (indexPath.row == _selectIndex) {
            [self.delegate leftSideBarSelectWithController:nil];
        }else
        {
            [self.delegate leftSideBarSelectWithController:[self subConWithIndex:indexPath.row]];
        }
        
    }
    _selectIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
