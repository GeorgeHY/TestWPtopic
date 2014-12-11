//
//  SellerAcitvityVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define dTag_Search 100
#import "SellerAcitvityVC.h"
#import "Cell_SellerActivity.h"
@interface SellerAcitvityVC ()<UISearchBarDelegate>
{
    float nav_Y;
    float nav_H;
    float screenheight;
    float screenwidth;
}
@end

@implementation SellerAcitvityVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"活动-商家";
        self.view.backgroundColor = [UIColor whiteColor];
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
- (void) keyboardShown:(NSNotification *)note{
    CGRect keyboardFrame;
    keyboardFrame = [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue] ;
    
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height -=keyboardFrame.size.height -20;
    [self.tableView setFrame:tableViewFrame];
    
    [self.tableView reloadData];
}
- (void) keyboardHidden:(NSNotification *)note{
    
    [self.tableView setFrame:CGRectMake(0, nav_Y, screenwidth, screenheight - 64 - 49)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArray = [[NSMutableArray alloc]init];
    resultArray = [[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    [self createLayout];
    [self createUI];
}
-(void)createUI
{
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwidth, 84)];
    
    
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, screenwidth, 44)];
    
    //打折 滑雪  放风筝  轮滑
    
    NSArray * name = @[@"打折", @"滑雪", @"放风筝", @"轮滑"];
    //就选取热门前四个标签
    for (int i = 0; i < 4; i++) {
        
        UILabel * markLabel = [[UILabel alloc]initWithFrame:CGRectMake((screenwidth - 20) / 4 * i + 4 * (i + 1), search.frame.size.height + search.frame.origin.y, (screenwidth - 20)/ 4, 40)];
        markLabel.backgroundColor = [UIColor purpleColor];
        markLabel.textAlignment = NSTextAlignmentCenter;
        
        markLabel.text = [name objectAtIndex:i];
        
        [headerView addSubview:markLabel];
    }
    
    search.placeholder = @"搜索";
    search.delegate = self;
    [headerView addSubview:search];
    
    //初始化假数据
    for (int i = 0; i < 30; i++) {
        
        NSString * str = [NSString stringWithFormat:@"%d", i];
        
        [dataArray addObject:str];
        
    }
    
    [resultArray addObjectsFromArray:dataArray];
    NSLog(@"dataArray:%@",dataArray);
    
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, search.frame.origin.y + search.frame.size.height + 40, screenwidth, screenheight - 64 - 49 - 44 - 40) style:UITableViewStylePlain];
    
     self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, nav_Y, screenwidth, screenheight - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = headerView;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        
        [search resignFirstResponder];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [search resignFirstResponder];
}

#pragma mark--searchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        
        [resultArray removeAllObjects];
        [resultArray addObjectsFromArray:dataArray];
    }else{
        [resultArray removeAllObjects];
        
        for (NSString * str in dataArray) {
            
            NSRange range = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (range.location != NSNotFound) {
                
                [resultArray addObject:str];
            }
            
        }
    }
    [self.tableView reloadData];
}
#pragma mark--tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [resultArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * strID = @"ID";
    
    Cell_SellerActivity * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_SellerActivity" owner:self options:nil]lastObject];
    }
    
    cell.mainLabel.text = [resultArray objectAtIndex:indexPath.row];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 101;
}
@end
