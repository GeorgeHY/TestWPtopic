//
//  MeRightVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Me_RightViewController.h"

@interface Me_RightViewController ()
@property(nonatomic , strong) NSArray * dataSource;
@property(nonatomic , strong) UITableView * tableView;
@end

@implementation Me_RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [[NSArray alloc] initWithObjects:@"未读私信的基本内容",@"未读私信的基本内容", @"未读私信的基本内容",nil];
    
    [self createUIView];
}
-(void)createUIView
{
    UIView *v = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    UIButton * btn = [[UIButton alloc]  initWithFrame:CGRectMake(30, v.frame.size.height/2-25, self.view.frame.size.width-90, 50)];
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [v  addSubview:btn];
    UILabel * lable = [[UILabel alloc]  initWithFrame:CGRectMake(20, v.frame.size.height - 30, 120, 20)];
    lable.text = @"未读信息或私信";
    [v addSubview:lable];
    self.tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = v;
    [self.view  addSubview:self.tableView];
}




#pragma mark tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier] ;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = [self.dataSource  objectAtIndex:indexPath.row];
    
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
