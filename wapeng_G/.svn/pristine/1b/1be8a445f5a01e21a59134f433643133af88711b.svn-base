//
//  MeMessageViewController.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-24.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MeMessageViewController.h"
#import "HMSegmentedControl.h"
#import "Cell_MeMsg.h"
@interface MeMessageViewController ()
{
    float nav_Y;
    float nav_H;
    float screenheight;
}
@end

@implementation MeMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"消息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLayout];
    
    [self initLeftItem];
    
    [self initUIView];
    
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
-(void)initLeftItem
{
    UIImageView * leftIView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftIView.image = [UIImage imageNamed:@"1"];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftIView];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)initUIView
{
//    NSArray * titleArray = @[@"通知", @"评论", @"赞"];
//    HMSegmentedControl * seg = [[HMSegmentedControl alloc]initWithSectionTitles:titleArray];
//    [self.view addSubview:seg];
    
    messageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, nav_Y + 40, 320, screenheight - 49 - 64 - 40) style:UITableViewStylePlain];
    
    messageTableView.delegate = self;
    
    messageTableView.dataSource = self;
    
    [self.view addSubview:messageTableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    Cell_MeMsg * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_MeMsg" owner:self options:nil]lastObject];
    }
    cell.mainLabel.text = @"小武妈妈";
    
    cell.detailLabel.text = @"最后一条私信息的部分内容";
    
    cell.headIView.image = [UIImage imageNamed:@"3"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
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
