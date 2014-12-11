//
//  ActivityLeftVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ActivityLeftVC.h"
#import "SVProgressHUD.h"
#import "SellerAcitvityVC.h"
#import "UIViewController+MMDrawerController.h"
#import "AllActivityVC.h"
@interface ActivityLeftVC ()
{
    float nav_Y;
    float nav_H;
    float screenheight;
    float screenwidth;
}
@end

@implementation ActivityLeftVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"left";

        self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}
-(void)createLayout
{
    CGFloat iosversion = [[[UIDevice currentDevice]systemVersion]floatValue];
    
    if (iosversion >= 7) {
        
        nav_Y = 64;
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }else{
        nav_Y = 0;
    }
    screenheight = self.view.frame.size.height;
    screenwidth = self.view.frame.size.width;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createLayout];
    
    nameArray = @[@"全部活动", @"个人用户发起的活动",@"机构用户发起的活动", @"我关注的活动", @"我发起参与的活动"];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,108, screenwidth, screenheight - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
//    UILabel * headView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenwidth, 44)];
//    headView.text = @"全部活动";
//    headView.textAlignment = NSTextAlignmentCenter;
//    self.tableView.tableHeaderView = headView;
    
    [self createUI];
}

//创建UI
-(void)createUI
{
    //虚拟的nav
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, screenwidth, 88)];
    navView.backgroundColor = [UIColor orangeColor];
    
    UIButton * headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headButton.frame = CGRectMake(50, 9, 70, 70);
    
    [headButton setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    
    [headButton addTarget:self action:@selector(headerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:headButton];
    
    UILabel * acitiLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 20, 100, 24)];
    acitiLabel.text = @"活动";
    [navView addSubview:acitiLabel];
    
    UILabel * nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 50, 100, 24)];
    nickLabel.text = @"津津爸爸";
    [navView addSubview:nickLabel];
    [self.view addSubview:navView];
    
}

-(void)headerButtonClick
{
    //点击进入我的资料
    [SVProgressHUD showSimpleText:@"点击进入我的资料"];
}

#pragma mark--tableViewDeleagte
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [nameArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    cell.textLabel.text = [nameArray objectAtIndex:indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            AllActivityVC * vc = [[AllActivityVC alloc]init];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
            
            [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
        }
            break;
        case 1:
        {
            //给中菜单
            SellerAcitvityVC * vc = [[SellerAcitvityVC alloc]init];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
            
            [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
            
        }
            break;
        case 2:
        {
        }
            break;
        case 3:
        {
            
        }
            break;

        default:
            break;
    }
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
