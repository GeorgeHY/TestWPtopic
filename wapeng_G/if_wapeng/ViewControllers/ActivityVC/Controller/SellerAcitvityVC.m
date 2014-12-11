//
//  SellerAcitvityVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define dTag_Search 100

#define Activity_TongLing     1//同龄活动
#define Activity_SearchResult 2//本页面搜索结果
#define Activity_Seller      3//商家活动
#define Activity_Outside     4//外面传来的搜索结果
#import "SellerAcitvityVC.h"
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
#import "SearchResultVC.h"
#import "PushAcitivityController.h"
@interface SellerAcitvityVC ()<UISearchBarDelegate>
{
    int pageIndex;//当前页码
    AFN_HttpBase * http;
    
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) int isButtom;//是否有下一页
@property (nonatomic, assign) BOOL opertaion;//yes = 下拉刷新，no = 下拉加载
@property (nonatomic, strong) NSString * test;
@end

@implementation SellerAcitvityVC
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
    
    if (self.pageType == Activity_TongLing) {
        
        [self initLeftItem];
    }else{
        
         [self createLeftItem];
    }
   
    [self createRightItem];
    
    pageIndex = 1;
    
    [self httpRequestWithPageIndex:pageIndex];
    
    //下拉刷新
    [self setupRefresh:self.tableView];
    
    
#pragma mark - 侧滑时取消键盘
    
    __weak SellerAcitvityVC * weakSelf = self;
    [self.mm_drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        
        [weakSelf.search resignFirstResponder];
        
        return 0;
    }];
    
}
#pragma mark - 下拉刷新
- (void)headerRereshing
{
    self.opertaion = YES;
    
    pageIndex = 1;
    
    [self httpRequestWithPageIndex:pageIndex];
    
}
#pragma mark - 上拉加载更多
-(void)footerRereshing
{
    self.opertaion = NO;
    NSLog(@"%d", self.isButtom);
    if (self.isButtom == 1) {
        [self.tableView footerEndRefreshing];
        return;
    }
    pageIndex++;
    
    [self httpRequestWithPageIndex:pageIndex];
    
}

-(void)httpRequestWithPageIndex:(int)newPageIndex
{
    switch (self.pageType) {
        case Activity_TongLing://同龄活动
        {
            NSString * newAge = [NSString stringWithFormat:@"%d", (int)self.age];
            
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:newAge,@"activityQuery.ageGroupID", nil];
            [self startHttpRequestWithUrl:dUrl_ACT_1_2_1 postDict:dict page:newPageIndex];
        }
            break;
        case Activity_SearchResult:
        {
            NSString * searchWords = self.search.text;
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:searchWords,@"activityQuery.searchWord", nil];
            
            //全局活动搜索
            [self startHttpRequestWithUrl:dUrl_ACT_1_1_2 postDict:dict page:newPageIndex];
        }
            break;
        case Activity_Seller:
        {
            NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
            
            NSDictionary * loginDict = [d objectForKey:UD_loginDict];
            //纬度
            NSString * latitude = [loginDict objectForKey:@"latitude"];
            //经度
            NSString * longtitude = [loginDict objectForKey:@"longitude"];
            //断号
            NSString * disNo = @"3";
            
            NSString * startIdnex = [NSString stringWithFormat:@"1"];
            NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:latitude, @"activityQuery.latitude", longtitude , @"activityQuery.longitude", disNo, @"activityQuery.disNo", startIdnex,@"activityQuery.startIndex", nil];
            
            [self startHttpRequestWithUrl:dUrl_ACT_1_2_2 postDict:postDict page:newPageIndex];
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
    
    __weak SellerAcitvityVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        //下拉刷新
        if (weakSelf.opertaion == YES) {
            
            [weakSelf.dataArray removeAllObjects];
        }
        
        NSDictionary * root = (NSDictionary *)obj;
        
        if (![[root objectForKey:@"value"] isKindOfClass:[NSNull class]]) {
            if (![[root objectForKey:@"list"] isKindOfClass:[NSNull class]]) {
                
            }else{
                
                [SVProgressHUD showSimpleText:@"没有搜索结果"];
                return;
            }
        }else{
            
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
            
            item.relativePath = @"";
            
            if (![[dict objectForKey:@"author"] isKindOfClass:[NSNull class]]) {
                
                if (![[[dict objectForKey:@"author"] objectForKey:@"photo"] isKindOfClass:[NSNull class]]) {
                    
                    if (![[[[dict objectForKey:@"author"] objectForKey:@"photo"] objectForKey:@"relativePath"] isKindOfClass:[NSNull class]]) {
                        
                        item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, [[[dict objectForKey:@"author"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
                    }
                    
                }
            }
            
            item.actId = [dict objectForKey:@"id"];
            [weakSelf.dataArray addObject:item];
        }
        
        [weakSelf.tableView reloadData];
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    }];
}
-(void)startHttpRequestWithPage:(int)page age:(NSInteger)age
{
    NSLog(@"%@", self.ddid);
    NSString * curPage = [NSString stringWithFormat:@"%d", page];
    NSString * newAge = [NSString stringWithFormat:@"%d", (int)age];
    
    __weak SellerAcitvityVC * weakSelf = self;

    [http thirdRequestWithUrl:dUrl_ACT_1_2_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        //下拉刷新
        if (weakSelf.opertaion == YES) {
            
            [weakSelf.dataArray removeAllObjects];
        }
        
        NSDictionary * root = (NSDictionary *)obj;
        
        weakSelf.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"]intValue];
        
        NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
        
        for (NSDictionary * dict in list) {
            
            Item_Activity * item = [[Item_Activity alloc]init];
            
            item.content = [dict objectForKey:@"content"];
            item.petName = [[dict objectForKey:@"author"] objectForKey:@"petName"];
            item.viewFriendPartInCount = [NSString stringWithFormat:@"%@", [dict objectForKey:@"viewFriendPartInCount"]];
            item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, [[[dict objectForKey:@"author"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
//            item.actId = 
            [weakSelf.dataArray addObject:item];
        }
        
        [weakSelf.tableView reloadData];
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID", self.ddid, @"activityQuery.pageNum", curPage, @"activityQuery.ageGroupID", newAge, nil];
}
#pragma mark - 热词被选中的代理
-(void)hotWordName:(NSString *)hotWordName
{
    SearchResultVC * vc = [[SearchResultVC alloc]init];
    vc.searchText = hotWordName;
    vc.pageType = Activity_Outside;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)createUI
{
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 35)];
    search.placeholder = @"搜索";
    search.delegate = self;
    [self.view addSubview:search];
    //打折 滑雪  放风筝  轮滑
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSArray * name = [d objectForKey:UD_hotWord];
    
    
    HotWordVIew * hotView = [[HotWordVIew alloc]initWithFrame:CGRectMake(0, self.search.frame.origin.y + self.search.frame.size.height, kMainScreenWidth, 30) andHotWordArray:name fontSize:14];
    hotView.delegate = self;
    [self.view addSubview:hotView];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, kMainScreenWidth, kMainScreenHeight - 44 - 49 - 65) style:UITableViewStylePlain];
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

//创建mmdrawer的leftBarButton
-(void)setupLeftMenuButton
{
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:dPic_Public_topmenu forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0,20, 20);
    [leftBtn addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

#pragma mark - 返回左菜单
-(void)leftDrawerButtonPress:(id)sender{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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

#pragma mark- 搜索条被点击

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    [searchBar resignFirstResponder];

    SearchResultVC * searchVC = [[SearchResultVC alloc]init];
    searchVC.pageType = Activity_SearchResult;
    searchVC.title = @"searchResultVC";
    [self.navigationController pushViewController:searchVC animated:YES];
    
    
}

#pragma mark--tableViewDataSouce
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
    
    [cell.headerImage setImageWithURL:[NSURL URLWithString:item.relativePath] placeholderImage:kDefaultPic];
    
    cell.mainLabel.text = item.content;
//    [cell.mainLabel reloadFrame];
    cell.userLabel.text = item.petName;
    
    cell.joinLabel.text = [NSString stringWithFormat:@"%@个人参与", item.viewFriendPartInCount];
    cell.positionIV.hidden = YES;
    if (self.pageType == Activity_Seller) {
        cell.positionIV.hidden = NO;
        cell.locationLabel.text = item.ViewActivityDistance;
    }
}
#pragma mark - 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Item_Activity * item = _dataArray[indexPath.row];
    ActivityDetailVC * detailVC = [[ActivityDetailVC alloc]init];
    
    NSLog(@"id:%@", item.actId);
    detailVC.activityID = item.actId;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
