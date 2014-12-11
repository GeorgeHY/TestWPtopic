//
//  PrivateMessageViewController.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-23.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "PrivateMessageViewController.h"
#import "UIViewController+General.h"
@interface PrivateMessageViewController ()
{
    float nav_Y;
    float nav_H;
    float screenheight;
}
@end

@implementation PrivateMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"私信";
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
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLayout];
    
    [self initLeftItem];
    
    [self initDataSource];
    
    [self initUIView];
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
    [self initLeftItem];
    
    privateMsgTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, nav_Y, 320, screenheight - 64 - 44)];
    
    privateMsgTableView.delegate = self;
    
    privateMsgTableView.dataSource = self;
    
    [self.view addSubview:privateMsgTableView];
}
-(void)initDataSource
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    cell.textLabel.text = @"小武妈妈";
    
    cell.detailTextLabel.text = @"最后一条私信内容";
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.imageView.image = [UIImage imageNamed:@"3"];
    
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
