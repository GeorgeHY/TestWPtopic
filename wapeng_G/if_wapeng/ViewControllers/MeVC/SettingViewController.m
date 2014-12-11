//
//  SettingViewController.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-22.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "SettingViewController.h"
#import "UIViewController+General.h"
#import "SecretViewController.h"
@interface SettingViewController ()
{
    float nav_Y;
    float nav_H;
    float screenheight;
}
@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"设置";
        dataArray = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)initLayout
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    nav_Y = [[d objectForKey:UD_navY]floatValue];
    
    nav_H = [[d objectForKey:UD_navH]floatValue];
    
    screenheight = [[d objectForKey:UD_screenHeight]floatValue];
    
    CGFloat iosversion = [[[UIDevice currentDevice]systemVersion]floatValue];
    
    if (iosversion >= 7) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLayout];
    
    NSArray * name = @[@"通用", @"账号与安全", @"提醒和打扰", @"隐私", @"关于娃朋"];
    
    [dataArray addObjectsFromArray:name];
    
//    [self initLeftItem];
//    [self initCustomLeftItemWithTitle:@"text" leftItemTitle:@"button"];
    [self initLeftItem];
    
    [self initRightItem];
    
    [self initUIView];
}
-(void)initRightItem
{
    UIImageView * rightIView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    rightIView.image = [UIImage imageNamed:@"2"];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightIView];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)initLeftItem
{
    UIImageView * leftIView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftIView.image = [UIImage imageNamed:@"1"];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftIView];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
-(void)initUIView
{
    settingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, nav_Y, 320, screenheight)];
    
    settingTableView.delegate = self;
    
    settingTableView.dataSource = self;
    
    [self.view addSubview:settingTableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil ==  cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
     
        SecretViewController * secretVC = [[SecretViewController alloc]init];
        
        [self.navigationController pushViewController:secretVC animated:YES];
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
