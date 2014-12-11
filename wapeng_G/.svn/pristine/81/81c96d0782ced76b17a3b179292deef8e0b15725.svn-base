//
//  RigisterVC10.m
//  if_wapeng
//
//  Created by 永不死的圣斗士 on 14-6-26.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RigisterVC10.h"
#import "Cell_RigisterVC10.h"
#import "SVProgressHUD.h"
@interface RigisterVC10 ()
{
    float nav_Y;
    float nav_H;
    float screenHeight;
    float screenWidth;
}
@end

@implementation RigisterVC10

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"推荐邻居";
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    nav_Y = [[d objectForKey:UD_navY]floatValue];
    
    nav_H = [[d objectForKey:UD_navH]floatValue];
    
    screenWidth = [[d objectForKey:UD_screenWidth]floatValue];
    
    screenHeight = [[d objectForKey:UD_screenHeight]floatValue];
    
//    if (SystemVersion >= 7.0) {
//        
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    dataArray = [[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3", @"4", @"5", nil];
    
    
    [self initUIView];
}

-(void)initUIView
{
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, 50, 35);
    
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    leftBtn.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    rightBtn.frame = CGRectMake(0, 0, 100, 35);
    
    rightBtn.backgroundColor = [UIColor redColor];
    
    [rightBtn setTitle:@"推荐邻居" forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, nav_Y, screenWidth, screenHeight - 64) style:UITableViewStylePlain] ;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
}

#pragma -- UITableviewDelegate 

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  [dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    Cell_RigisterVC10 * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_RigisterVC10" owner:self options:nil] lastObject];
    }
    
    cell.headImageView.backgroundColor = [UIColor redColor];
    
    cell.headImageView.image = [UIImage imageNamed:@"1"];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", [dataArray objectAtIndex:indexPath.row]];
    
    cell.confireBtn.backgroundColor = [UIColor greenColor];
    
    return cell;

}
-(void)leftBtnClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnClick:(UIButton *)button
{
    [SVProgressHUD showSimpleText:@"全部关注"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
