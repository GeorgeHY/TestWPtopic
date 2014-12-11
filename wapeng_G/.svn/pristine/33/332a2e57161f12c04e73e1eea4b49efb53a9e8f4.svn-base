//
//  HotTopicViewController.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "HotTopicViewController.h"
#import "HotTopicTVCell.h"
#import "HotTopicEntity.h"
@interface HotTopicViewController ()
{
    float nav_Y;
    float nav_H;
    float screenheight;
    float screenwidth;
}
@end

@implementation HotTopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"话题-热门";
        self.dateSource = [[NSMutableArray alloc]  init];
        for (int i = 0; i <= 10; i++) {
            HotTopicEntity * hotTop = [[HotTopicEntity alloc] init];
            NSString *s = [[NSString alloc] initWithFormat:@"%d",i];
            hotTop.top = s;
            hotTop.reply = s;
            hotTop.person = s;
            hotTop.content = @"水电费水电费水电费收水电费·水电费水电费水电费收水电费·水电费水电费水电费收水电费·水电费水电费水电费收水电费·水电费水电费水电费收水电费·水电费水电费水电费收水电费·水电费水电费水电费收水电费·";
            hotTop.name = @"大射手";
            [self.dateSource addObject:hotTop];
        }

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self  createComponent];
}
//初始化控件
-(void)createComponent{
    [self createLayout];
    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blueColor]];
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    self.leftBtn.backgroundColor = [UIColor redColor];
    self.leftBtn.titleLabel.font=[UIFont systemFontOfSize:20];
//    [self.leftBtn addTarget:self action:@selector(onTouchlistening:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setTitle:@"左面" forState:UIControlStateNormal];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem = left;
    
    self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:20];
//    [self.rightBtn addTarget:self action:@selector(onTouchlistening:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightBtn setTitle:@"笔" forState:UIControlStateNormal];
    self.rightBtn.backgroundColor = [UIColor redColor];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    
 
    self.searchBar  = [[UISearchBar alloc] initWithFrame:CGRectMake(0, nav_Y,self.view.frame.size.width, 44)];
    self.searchBar.backgroundColor = [UIColor redColor];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    
    self.scroll = [[UIScrollView alloc]  initWithFrame:CGRectMake(0, nav_Y + 44, self.view.frame.size.height, 30)];
    self.scroll.contentSize = CGSizeMake(630, 30);
    self.scroll.pagingEnabled = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.backgroundColor = [UIColor greenColor];
    UILabel * lable1 = [[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 100, 20)];
    lable1.text  = @"手足口";
    lable1.textColor = [UIColor blackColor];
    [self.scroll addSubview:lable1];
    UILabel * lable2 = [[UILabel alloc]  initWithFrame:CGRectMake(100, 0, 100, 20)];
    lable2.text  = @"入托";
    [self.scroll addSubview:lable2];
    UILabel * lable3 = [[UILabel alloc]  initWithFrame:CGRectMake(200, 0, 100, 20)];
    lable3.text  = @"舞蹈";
    [self.scroll addSubview:lable3];
    UILabel * lable4 = [[UILabel alloc]  initWithFrame:CGRectMake(300, 0, 100, 20)];
    lable4.text  = @"防御针";
    [self.scroll addSubview:lable4];
    [self.view  addSubview:self.scroll];
    
    UIImageView * im = [[UIImageView alloc]  initWithFrame:CGRectMake(10, nav_Y + 44 + 40, 20, 20)];
    im.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:im];
    UILabel * newlable = [[UILabel alloc]  initWithFrame:CGRectMake(40, nav_Y + 44 + 40, 100, 20)];
    newlable.text = @"今日十大";
    [self.view  addSubview:newlable];
    self.tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, nav_Y + 44 + 40 + 40, self.view.frame.size.width, screenheight - (64 + 44 + 40 + 40 + 49))];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view  addSubview:self.tableView];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dateSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    HotTopicTVCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[HotTopicTVCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    HotTopicEntity * hotTopic = [_dateSource objectAtIndex:indexPath.row];
    cell.topLable.text = hotTopic.top;
    cell.replyLable.text = hotTopic.reply;
    cell.personLable.text = hotTopic.person;
    cell.contentLable.text = hotTopic.content;
    cell.nameLable.text = hotTopic.name;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"---- %ld" , (long)indexPath.row);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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


//搜索框中的内容发生改变时 回调（即要搜索的内容改变）
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"changed");
   
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {

    NSLog(@"shuould begin");
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

    NSLog(@"did begin");
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"did end");
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search clicked");
    [searchBar  resignFirstResponder];
}

//点击搜索框上的 取消按钮时 调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"cancle clicked");
    

}

@end
