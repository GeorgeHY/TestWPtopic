//
//  SecretViewController.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-23.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "SecretViewController.h"
#import "SecretCell.h"
#import "UIViewController+General.h"
@interface SecretViewController ()
{
    float nav_Y;
    float nav_H;
    float screenheight;
}
@end

@implementation SecretViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"隐私";
        
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
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initDataSource];
    
    [self initLayout];
    
    [self initUIView];
}

-(void)initDataSource
{
    NSArray * name1 = @[@"橱窗访问权限", @"私信发送权限"];
    
    NSArray * name2 = @[@"通过娃朋友号搜索到我", @"通过昵称搜索到我", @"通过手机号码搜索到我"];
    
    NSArray * name3 = @[@"向我推荐linju", @"向我推荐商家", @"将我推荐给邻居"];
    
    NSArray * name4 = @[@"通讯录黑名单"];
    
    [dataArray addObject:name1];
    [dataArray addObject:name2];
    [dataArray addObject:name3];
    [dataArray addObject:name4];
}
-(void)initUIView
{
    
    self.navigationItem.title = @"隐私";
    
    [self initLeftItem];
    
    secretTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, screenheight - 44 - 49) style:UITableViewStyleGrouped];
    
    secretTableView.dataSource = self;
    
    secretTableView.delegate = self;
    
    [self.view addSubview:secretTableView];
    
}

-(void)navItemClick:(UIButton *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataArray objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    SecretCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SecretCell" owner:self options:nil]lastObject];
    }
    if (indexPath.section == 0) {
        
        cell.mSwitch.hidden = YES;
    }
    
    cell.contentLabel.text = [[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
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
