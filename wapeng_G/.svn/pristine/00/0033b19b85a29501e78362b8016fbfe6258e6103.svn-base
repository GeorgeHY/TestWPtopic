//
//  CommonVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define APIKey(i) i //1今日十大
#import "CommonVC.h"
#import "Cell_SellerAciti2.h"
#import "InterfaceLibrary.h"
#import "UIViewController+MMDrawerController.h"
#import "ActivityDetailVC.h"
#import "SellerAcitvityVC.h"
#import "UIView+WhenTappedBlocks.h"
#import "Item_Common02.h"
#import "UIViewController+General.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "PushAcitivityController.h"
#import "HotWordTool.h"
#import "SearchResultVC.h"
#import "UIColor+AddColor.h"
@interface CommonVC ()
{
    UISearchBar * _searchBar;
    int pageIndex;
}
@property (nonatomic, strong) UISearchBar * searchBar;

@property (nonatomic, assign)  BOOL opertaion;//是否是下拉刷新

@property (nonatomic, assign) int isButtom;//是否有下一页
@end

@implementation CommonVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
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
    

    _arr_data = [[NSMutableArray alloc]init];
    
    [self createUI];
    [self createLeftItem];
    [self createRightItem];
    
    __weak UISearchBar * weakSearch = _searchBar;
    
    [self.mm_drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        
        [weakSearch resignFirstResponder];
        return 0;
        
    }];

    
    pageIndex = 1;
    
    [self httpRequestWithPageIndex:pageIndex];
    //注册下拉刷新
    [self setupRefresh:self.tableView];

}

#pragma mark - 下拉刷新
//必须被重载
-(void)headerRereshing
{
    self.opertaion = YES;
    
    pageIndex = 1;
    
    [self httpRequestWithPageIndex:pageIndex];
}
#pragma mark - 上拉加载
//必须被重载
-(void)footerRereshing
{
    
    self.opertaion = NO;
    
    if (self.isButtom == 1) {
        
        [SVProgressHUD showErrorWithStatus:dTips_noMoreData];
        //停止刷新
        [self.tableView footerEndRefreshing];
        
        return;
    }
    
    pageIndex++;
    
    [self httpRequestWithPageIndex:pageIndex];
    
    return;

}
-(void)httpRequestWithPageIndex:(int)newPageIndex
{
    switch (self.pageType) {
        case APIKey(1):
        {
            NSMutableDictionary * postDict = [[NSMutableDictionary alloc]init];
            [self startHttpRequestWithUrl:dUrl_ACT_1_2_1_1 postDict:postDict  page:newPageIndex];
        }
            break;
        default:
            break;
    }
}
-(void)startHttpRequestWithUrl:(NSString *)url  postDict:(NSMutableDictionary *)postDict page:(int)page
{
    NSString * curPage = [NSString stringWithFormat:@"%d", page];
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    //因为当前页码和ddid是必须传的
    NSDictionary * commonDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", curPage, @"activityQuery.pageNum", nil];
    [postDict addEntriesFromDictionary:commonDict];
    
    NSLog(@"postDict:%@", postDict);
    
    AFN_HttpBase * http = [[AFN_HttpBase alloc]init];
    
    __weak CommonVC * weakSelf = self;
    
    [SVProgressHUD showWithStatus:dTip_loading];
    
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
            
            item.petName = @"";
            if (isNotNull([[dict objectForKey:@"author"] objectForKey:@"petName"])) {
                 item.petName = [[dict objectForKey:@"author"] objectForKey:@"petName"];
            }
           
            item.viewFriendPartInCount = [NSString stringWithFormat:@"%@位熟人参与", [dict objectForKey:@"viewFriendPartInCount"]];
            
            item.relativePath = @"";
            
            if (![[dict objectForKey:@"author"] isKindOfClass:[NSNull class]]) {
                
                if (![[[dict objectForKey:@"author"] objectForKey:@"photo"] isKindOfClass:[NSNull class]]) {
                    
                    if (![[[[dict objectForKey:@"author"] objectForKey:@"photo"] objectForKey:@"relativePath"] isKindOfClass:[NSNull class]]) {
                        
                        item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, [[[dict objectForKey:@"author"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
                    }
                    
                }
            }

            item.actId = [dict objectForKey:@"id"];
            [weakSelf.arr_data addObject:item];
        }
        
        [SVProgressHUD dismiss];
        [weakSelf.tableView reloadData];
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:dTips_requestError];
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

#pragma mark - 创建热词控件

-(void)createButtons
{
    //打折 滑雪  放风筝  轮滑
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSArray * name = [d objectForKey:UD_hotWord];
    
    HotWordVIew * aView = [[HotWordVIew alloc]initWithFrame:CGRectMake(0, _searchBar.frame.size.height + _searchBar.frame.origin.y, kMainScreenWidth, 30) andHotWordArray:name fontSize:14];
    
    aView.delegate = self;
    
    [self.view addSubview:aView];
}

#pragma mark - 热词控件的代理

-(void)hotWordName:(NSString *)hotWordName
{
    SearchResultVC * vc = [[SearchResultVC alloc]init];
    vc.pageType = 4;
    vc.searchText = hotWordName;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)createUI
{
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.placeholder = @"Search";
    _searchBar.frame = CGRectMake(0, 0, kMainScreenWidth, 30);
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    [self createButtons];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kMainScreenWidth, kMainScreenHeight - 49 -44- 60) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark -- tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arr_data count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID0";
    
    Cell_SellerAciti2 * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        cell = [[Cell_SellerAciti2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    Item_Common02 * item = _arr_data[indexPath.row];
    
    cell.mainLabel.text = item.content;
    cell.userLabel.text = item.petName;
    cell.replayLabel.text = item.replies;
    cell.firlabel.text = item.viewFriendPartInCount;
    [cell.headerImage setImageWithURL:[NSURL URLWithString:item.relativePath] placeholderImage:kDefaultPic];
    
    switch (indexPath.row) {
        case 0:
        {
            cell.topLabel.textColor = [UIColor colorWithHexString:@"FF0000"];
        }
            break;
        case 1:
        {
            cell.topLabel.textColor = [UIColor colorWithHexString:@"FF7C00"];
        }
            break;
        case 2:
        {
            cell.topLabel.textColor = [UIColor colorWithHexString:@"DBA54C"];
        }
            break;
        default:
            break;
    }
    
    if (!(indexPath.row < 3)) {
        cell.topLabel.hidden = YES;
    }else{
        cell.topLabel.text = [NSString stringWithFormat:@"TOP%d", indexPath.row + 1];
        
    }
    return cell;
}
#pragma mark -- tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item_Common02 * item = [_arr_data objectAtIndex:indexPath.row];
    
    ActivityDetailVC * detailVC = [[ActivityDetailVC alloc]init];
    detailVC.activityID = item.actId;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark -- scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}
#pragma mark -- searchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    SearchResultVC * vc = [[SearchResultVC alloc]init];
    vc.pageType = 4;
    vc.searchText = searchBar.text;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
