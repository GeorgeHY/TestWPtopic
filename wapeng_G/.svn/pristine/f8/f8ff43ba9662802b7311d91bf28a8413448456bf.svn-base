//
//  CommonVC02.m
//  if_wapeng
//
//  Created by 心 猿 on 14-10-9.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define APIKey(i) i //1我的活动 2.用户活动
#import "CommonVC02.h"
#import "Cell_SellerAciti.h"
#import "Cell_SellerAciti2.h"
#import "Cell_SellerActi3.h"
#import "InterfaceLibrary.h"
#import "UIViewController+MMDrawerController.h"
#import "ActivityDetailVC.h"
#import "SellerAcitvityVC.h"
#import "UIView+WhenTappedBlocks.h"
#import "Item_Common02.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+General.h"
#import "PushAcitivityController.h"
#import "SearchResultVC.h"
@interface CommonVC02 ()
{
    UISearchBar * _searchBar;
    int pageIndex;
}
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, assign) BOOL opertaion;
@property (nonatomic, assign) int isButtom;
@end

@implementation CommonVC02

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _arr_data = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    [self createLeftItem];
    [self createRightItem];
    pageIndex = 1;
    
    [self httpRequestWithPageIndex:pageIndex];
    
    [self setupRefresh:self.tableView];
    
    __weak CommonVC02 * weakSelf = self;
    [self.mm_drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        
        [weakSelf.searchBar resignFirstResponder];
        return 0;
    }];
    
}
-(void)createRightItem
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:dPic_Public_toprelease forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 发布活动

-(void)rightItemClick
{
    PushAcitivityController *push = [[PushAcitivityController alloc]init];
    push.type = 2;
    [self.navigationController pushViewController:push animated:YES];
}
-(void)createLeftItem
{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"top_icon_huodong normal"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)leftItemClick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - 热词搜索的控件

-(void)hotWordName:(NSString *)hotWordName
{
    SearchResultVC * vc = [[SearchResultVC alloc]init];
    vc.pageType = 4;
    vc.title = @"搜索结果";
    NSLog(@"search:%@", hotWordName);
    
    vc.searchText = hotWordName;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)createButtons
{
    //打折 滑雪  放风筝  轮滑
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSArray * name = [d objectForKey:UD_hotWord];
    
    HotWordVIew * aView = [[HotWordVIew alloc]initWithFrame:CGRectMake(0,_searchBar.frame.size.height + _searchBar.frame.origin.y, kMainScreenWidth, 30) andHotWordArray:name fontSize:16];
    aView.delegate = self;
    [self.view addSubview:aView];
}

-(void)createUI
{
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.placeholder = @"Search";
    _searchBar.frame = CGRectMake(0, 0, kMainScreenWidth, 30);
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    [self createButtons];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kMainScreenWidth, kMainScreenHeight - 49 -44-60) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)headerRereshing
{
    self.opertaion = YES;
    
    pageIndex = 1;
    //从第一页开始
    [self httpRequestWithPageIndex:pageIndex];
    
}
-(void)footerRereshing
{
    self.opertaion = NO;
    NSLog(@"%d", self.isButtom);
    if (self.isButtom == 1) {
        [SVProgressHUD showSimpleText:@"亲,木有更多内容啦！"];
        [self.tableView footerEndRefreshing];
        return;
    }
    pageIndex++;
    
    [self httpRequestWithPageIndex:pageIndex];
    
}
-(void)httpRequestWithPageIndex:(int)newPageIndex
{
    
    switch (self.pageType) {
        case APIKey(1):
        {
            NSMutableDictionary * postDict = [[NSMutableDictionary alloc]init];
            [self startHttpRequestWithUrl:dUrl_ACT_1_2_8 postDict:postDict page:newPageIndex];
        }
            break;
        case APIKey(2):
        {
            
            NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
            
            NSDictionary * loginDict = [d objectForKey:UD_loginDict];
            
            NSString * generalTypeID = [loginDict objectForKey:@"generalTypeID"];
            NSString * userTypeID = [loginDict objectForKey:@"userTypeID"];
            
            NSString * latitude = [loginDict objectForKey:@"latitude"];
            NSString * longitude = [loginDict objectForKey:@"longitude"];
            NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:generalTypeID, @"activityQuery.generalTypeID", userTypeID, @"activityQuery.userTypeID",@"3",@"activityQuery.disNo",longitude, @"activityQuery.longitude",latitude,@"activityQuery.latitude" , @"1", @"activityQuery.startIndex", nil];
            
            NSLog(@"postDict:%@",postDict);
            [self startHttpRequestWithUrl:dUrl_ACT_1_2_3 postDict:postDict page:newPageIndex];
        }
        default:
            break;
    }
}
//通用的post请求，以后还会改变
-(void)startHttpRequestWithUrl:(NSString *)url  postDict:(NSMutableDictionary *)postDict page:(int)page
{
    NSString * curPage = [NSString stringWithFormat:@"%d", page];
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    
    //因为当前页码和ddid是必须传的
    NSDictionary * commonDict = nil;
    
    if (self.pageType == APIKey(1)) {
        commonDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", curPage, @"activityQuery.pageNum", nil];
    }
    else{
        commonDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", nil];
    }
    
    [postDict addEntriesFromDictionary:commonDict];
    
    NSLog(@"postDict:%@", postDict);
    
    AFN_HttpBase * http = [[AFN_HttpBase alloc]init];
    
    __weak CommonVC02 * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        //下拉刷新
        if (weakSelf.opertaion == YES) {
            
            [weakSelf.arr_data removeAllObjects];
        }
        
        NSDictionary * root = (NSDictionary *)obj;
        
        weakSelf.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"]intValue];
        
        NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
        
        for (NSDictionary * dict in list) {
            
            Item_Common02 * item = [[Item_Common02 alloc]init];
            
            item.content = [dict objectForKey:@"content"];
            item.replies = [NSString stringWithFormat:@"回复数:%@", [dict objectForKey:@"replies"]];
            item.petName = [[dict objectForKey:@"author"] objectForKey:@"petName"];
            item.viewFriendPartInCount = [NSString stringWithFormat:@"%@位熟人参与", [dict objectForKey:@"viewFriendPartInCount"]];
            //以后再打开
            //            item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, [[[dict objectForKey:@"author"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
            
            [weakSelf.arr_data addObject:item];
        }
        
        [weakSelf.tableView reloadData];
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
        
        [SVProgressHUD showSuccessWithStatus:@"请求成功"];
        
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
}
#pragma mark -- tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arr_data count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID2";
    Cell_SellerActi3 * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (nil == cell) {
        cell = [[Cell_SellerActi3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    Item_Common02 * item = _arr_data[indexPath.row];
    
    [cell.headerImage setImageWithURL:[NSURL URLWithString:item.relativePath] placeholderImage:nil];
    cell.mainLabel.text = item.content;
//    [cell.mainLabel reloadFrame];
    cell.joinLabel.text = item.replies;
    cell.userLabel.text = item.petName;
    cell.locationLabel.text = item.viewFriendPartInCount;
    return cell;
}
#pragma mark -- tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item_Common02 * item = [_arr_data objectAtIndex:indexPath.row];
    ActivityDetailVC * detailVC = [[ActivityDetailVC alloc]init];
    detailVC.activityID = item.actId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
}
#pragma mark scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}
#pragma mark uisearchbardelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    SearchResultVC * vc = [[SearchResultVC alloc]init];
    vc.pageType = 4;
    vc.title = @"搜索结果";
    vc.searchText = searchBar.text;
    [self.navigationController pushViewController:vc animated:YES];

}
@end
