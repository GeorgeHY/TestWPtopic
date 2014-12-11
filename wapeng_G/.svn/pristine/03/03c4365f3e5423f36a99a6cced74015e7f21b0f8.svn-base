//
//  SearchResultVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-2.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define dTag_Search 100
#define Activity_SearchResult 2//本页面搜索结果
#define Activity_Outside     4//外面传来的热词搜索结果
#define Activity_InnerHotWord 5 //里面的热词
#import "SearchResultVC.h"
#import "UIView+WhenTappedBlocks.h"
#import "Cell_SellerAciti.h"
#import "SearchResultVC.h"
#import "UIViewController+MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MMDrawerBarButtonItem.h"
#import "UIView+WhenTappedBlocks.h"
#import "SearchResultVC.h"
#import "ActivityDetailVC.h"
#import "UIViewController+General.h"
#import "Item_Activity.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "HotWordTool.h"
#import "PushAcitivityController.h"
@interface SearchResultVC ()
{
    int pageIndex;//当前页码
    
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) int isButtom;//是否有下一页
@property (nonatomic, assign) BOOL opertaion;//yes = 下拉刷新，no = 下拉加载
@property (nonatomic, strong) NSString * test;
@end

@implementation SearchResultVC

@synthesize search;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dataArray = [[NSMutableArray alloc]init];
        _lblTextArr = [[NSMutableArray alloc]init];
        http = [[AFN_HttpBase alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    [self initLeftItem];
    [self createRightItem];
    
    pageIndex = 1;
    
    [self httpRequestWithPageIndex:pageIndex];
    
    //下拉刷新
    [self setupRefresh:self.tableView];
    
    __weak SearchResultVC * weakSelf = self;
    [self.mm_drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        
        [weakSelf.search resignFirstResponder];
        
        return 0;
    }];
    
}

- (void)headerRereshing
{
    self.opertaion = YES;
    
    pageIndex = 1;
    
    [self httpRequestWithPageIndex:pageIndex];
    
}
-(void)footerRereshing
{
    self.opertaion = NO;
    NSLog(@"%d", self.isButtom);
    if (self.isButtom == 1) {
        [self.tableView footerEndRefreshing];
        [SVProgressHUD showErrorWithStatus:@"没有更多数据"];
        return;
    }
    pageIndex++;
    
    [self httpRequestWithPageIndex:pageIndex];
    
}

-(void)httpRequestWithPageIndex:(int)newPageIndex
{
    switch (self.pageType) {

        case Activity_SearchResult:
        {
            NSString * searchWords = self.search.text;
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:searchWords,@"activityQuery.searchWord", nil];
            
            //全局活动搜索
            [self startHttpRequestWithUrl:dUrl_ACT_1_1_2 postDict:dict page:newPageIndex];
        }
            break;

        case Activity_Outside:
        {
            NSString * searchWords = self.searchText;
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:searchWords,@"activityQuery.searchWord", nil];
            
            //全局活动搜索
            [self startHttpRequestWithUrl:dUrl_ACT_1_1_2 postDict:dict page:newPageIndex];
        }
            break;
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
    NSDictionary * commonDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", curPage, @"activityQuery.pageNum", nil];
    [postDict addEntriesFromDictionary:commonDict];
    
    NSLog(@"postDict:%@", postDict);
    
    __weak SearchResultVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        //下拉刷新
        if (weakSelf.opertaion == YES) {
            
            [weakSelf.dataArray removeAllObjects];
        }
        
        NSDictionary * root = (NSDictionary *)obj;
        
        if (![[root objectForKey:@"value"] isKindOfClass:[NSNull class]]) {
            if (![[root objectForKey:@"list"] isKindOfClass:[NSNull class]]) {
                
            }else{
                [self.tableView reloadData];
                [self.tableView footerEndRefreshing];
                [self.tableView headerEndRefreshing];
                [SVProgressHUD showSimpleText:@"没有搜索结果"];
                return;
            }
        }else{
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];
            [self.tableView headerEndRefreshing];
            [SVProgressHUD showSimpleText:@"没有搜索结果"];
            return;
        }
        
        weakSelf.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"]intValue];
        
        NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
        
        for (NSDictionary * dict in list) {
            
            Item_Activity * item = [[Item_Activity alloc]init];
            item.content = [dict objectForKey:@"content"];
            item.petName = [[dict objectForKey:@"author"] objectForKey:@"petName"];
            item.viewFriendPartInCount = [NSString stringWithFormat:@"%@", [dict objectForKey:@"viewFriendPartInCount"]];
            item.ViewActivityDistance = [NSString stringWithFormat:@"%@", [dict objectForKey:@"ViewActivityDistance"]];
            item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, [[[dict objectForKey:@"author"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
            item.actId = [dict objectForKey:@"id"];
            [weakSelf.dataArray addObject:item];
        }
        
        [weakSelf.tableView reloadData];
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
        [SVProgressHUD showSuccessWithStatus:@"搜索成功"];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    }];
}

#pragma mark -hotwordDelegate
-(void)hotWordName:(NSString *)hotWordName
{
    [_dataArray removeAllObjects];
    
    self.searchText = hotWordName;
    NSString * searchWords = self.searchText;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:searchWords,@"activityQuery.searchWord", nil];
    
    pageIndex = 1;
    [self startHttpRequestWithUrl:dUrl_ACT_1_1_2 postDict:dict page:pageIndex];
}
-(void)createUI
{
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 35)];
    [self.view addSubview:search];
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSArray * name = [d objectForKey:UD_hotWord];
    
    NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:name];
    
    HotWordVIew * aView = [[HotWordVIew alloc]initWithFrame:CGRectMake(0,self.search.frame.size.height , kMainScreenWidth, 30) andHotWordArray:arr fontSize:14];
    aView.delegate = self;
    [self.view addSubview:aView];
    
    search.placeholder = @"搜索";
    search.delegate = self;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, kMainScreenWidth, kMainScreenHeight - 44 - 49 - 65) style:UITableViewStylePlain];
    [self initLeftItem];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = kRGB(242, 242, 242);
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = kRGB(242, 242, 242);
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

-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [search resignFirstResponder];
}
#pragma mark--scrollviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        
        [search resignFirstResponder];
    }
}
#pragma mark--searchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    [searchBar resignFirstResponder];
    [self.dataArray removeAllObjects];
    [self httpRequestWithPageIndex:Activity_SearchResult];
    
    
}

#pragma mark--tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * strID = @"ID";
    
    Cell_SellerAciti * cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[Cell_SellerAciti alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
    
}
-(void)configureCell:(Cell_SellerAciti *)cell indexPath:(NSIndexPath *)indexPath
{
    Item_Activity * item = _dataArray[indexPath.row];
    
    [cell.headerImage setImageWithURL:[NSURL URLWithString:item.relativePath] placeholderImage:nil];
    cell.mainLabel.text = item.content;
//    [cell.mainLabel reloadFrame];
    cell.userLabel.text = item.petName;
    
    cell.joinLabel.text = [NSString stringWithFormat:@"%@个人参与", item.viewFriendPartInCount];
    cell.positionIV.hidden = YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item_Activity * item = _dataArray[indexPath.row];
    ActivityDetailVC * detailVC = [[ActivityDetailVC alloc]init];
    detailVC.activityID = item.actId;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
