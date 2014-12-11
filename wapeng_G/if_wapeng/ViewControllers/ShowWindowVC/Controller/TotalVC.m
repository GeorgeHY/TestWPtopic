//
//  TotalVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-10.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define ZAN     1
#define CANCLEZAN 2

#define MAN     1
#define WOMAN   2
#define MAX_TAG 1000
#define MAX_TAG_2 10000//imageView的placeHolder的tag
#define MAX_TAG_3 20000//imageView的tag
#define MAX_TAG_4 30000 //rtlabel的max
#define MAX_TAG_5 40000 //ttt的tag
#import "TotalVC.h"
#import "UIViewController+MMDrawerController.h"
#import "UIViewController+General.h"
#import "PublisWindowVC.h"
#import "Cell_MyWindow.h"
#import "Cell_Show.h"
#import "MyParserTool.h"
#import "RichLabelView.h"
#import "UIButton+FlexSpace.h"
#import "Cell_RemarkList.h"
#import "Item_RemarkList.h"
#import "StringTool.h"
#import "Item_MyWindow.h"
#import "TimeTool.h"
#import "UIImageView+WebCache.h"
#import "MyParserTool.h"
#import "RTLabel.h"
#import "NSString+URLEncoding.h"
#import "Item_zanList.h"
#import "Item_RemarkList.h"
#import "TTTAttributedLabel.h"
#import "Cell_ShowRemark.h"
#import "RDRStickyKeyboardView.h"
#import "WUDemoKeyboardBuilder.h"
#import "MyDatumVC.h"
#import "DataItem.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "UIColor+AddColor.h"
#import "UIView+WhenTappedBlocks.h"
#import "OtherVC.h"
#import "AppDelegate.h"
#import "TextKeyBoardVC.h" //暂时使用，等键盘好了之后替换
@interface TotalVC ()<TTTAttributedLabelDelegate,TextKeyBoardDelegate>
{
    AFN_HttpBase * http;
    int pageIndex;
    BOOL isWorking1;//是否正在请求 点赞接口是否正在请求
    BOOL isWorking2;//评论列表接口是否正在请求
    
}
@property (nonatomic, assign) NSInteger isButtom;//是否有下一页
@property (nonatomic, assign) BOOL  isRefresh;//是否是下拉刷新操作
@property (nonatomic, strong) RDRStickyKeyboardView *contentWrapper;
@property (nonatomic, strong) DataItem * item;
@property (nonatomic, strong) MyDatumVC * myDatumVC;
@end

@implementation TotalVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        http = [[AFN_HttpBase alloc]init];
        _dataArray = [[NSMutableArray alloc]init];
        _momentDict = [[NSMutableDictionary alloc]init];
        _zanDict = [[NSMutableDictionary alloc]init];
        self.myDatumVC = [[MyDatumVC alloc]init];
        self.item = [[DataItem alloc]init];
    }
    return self;
}

#pragma mark - 暂时替代键盘用的vc

-(void)sendText:(int)index
{
    TextKeyBoardVC * textVC = [[TextKeyBoardVC alloc]init];
    textVC.index = index;
    textVC.delegate = self;
    [self.navigationController pushViewController:textVC animated:YES];
}
#pragma mark - 暂时替代键盘的代理
-(void)sendText:(NSString *)string type:(int)pageType index:(int)index
{
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    Item_MyWindow * item = [_dataArray objectAtIndex:index];
    
    __weak TotalVC * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_DIA_1_4_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        
        [SVProgressHUD showSuccessWithStatus:@"评论成功"];
        
        //评论成功之后让电话那加1
        Item_MyWindow * item = [weakSelf.dataArray objectAtIndex:index];
        item.replies++;
        
        Item_RemarkList * item_Remark = [weakSelf.momentDict objectForKey:item.momentID];
        
//        int newremarkCount = ((item_Remark.recordCount + 1) / 10) + 1 ;
        
//        item.remakCount = newremarkCount;
        
        [self mReplayRequestWithUrl:dUrl_DIA_1_4_2 momentID:item.momentID PageIndex:1];
        
//        [weakSelf.tableView reloadData];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID", ddid, @"momentReply.content", string, @"momentReply.moment.id", item.momentID,@"momentReplyQuery.pageNum", @"1", nil];
}

/**评论**/
-(void)remarkBtnClick2:(UIButton *)btn
{
    NSString * string = @"评论啊";
    NSInteger index = btn.tag - MAX_TAG;
//    [self sendText:btn.tag - MAX_TAG];
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    
    Item_MyWindow * item = [_dataArray objectAtIndex:index];
    __weak TotalVC * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_DIA_1_4_1 succeed:^(NSObject *obj, BOOL isFinished) {
    
        [SVProgressHUD showSuccessWithStatus:@"评论成功"];
        
        //评论成功之后让电话那加1
        Item_MyWindow * item = [weakSelf.dataArray objectAtIndex:index];
        item.replies++;
        item.remakCount = 1;
        
        [weakSelf.momentDict removeObjectForKey:item.momentID];
        [weakSelf mReplayRequestWithUrl:dUrl_DIA_1_4_2 momentID:item.momentID PageIndex:item.remakCount];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID", ddid, @"momentReply.content", string, @"momentReply.moment.id", item.momentID,@"momentReplyQuery.pageNum", @"1", nil];

}
#pragma mark - 对瞬间举报
/**举报**/
-(void)warnBtnClick:(UIButton *)btn
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    Item_MyWindow * item = [_dataArray objectAtIndex:btn.tag - MAX_TAG];
    
    [http thirdRequestWithUrl:dUrl_DIA_1_2_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"举报成功"];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID", ddid, @"momentReport.content", @"因为键盘原因呢，举报理由先写死", @"momentReport.moment.id", item.momentID, nil];
}

#pragma mark - 瞬间点赞
/**点赞**/

-(void)zanBtnClick:(UIButton *)btn
{
    static int count = 0;
    
    count++;
    
    int type = 0;
    
    if (count % 2 == 0) {
        //取消赞
        type = CANCLEZAN;
    }else{
        //点赞
        type = ZAN;
    }
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    Item_MyWindow * item = [_dataArray objectAtIndex:btn.tag - MAX_TAG];
    
    __weak TotalVC * weakSelf = self;
    
    __weak UIButton * weakBtn = btn;
    
    [http thirdRequestWithUrl:dUrl_DIA_1_3_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        if (type == ZAN) {
            [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
            
            item.supports++;
            [weakBtn setTitle:@"已赞" forState:UIControlStateNormal];
            
        }else{
            [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
            item.supports--;
            [weakBtn setTitle:@"赞" forState:UIControlStateNormal];
        }
          [weakSelf mHttpRequestWithUrl:dUrl_DIA_1_3_2 momentID:item.momentID];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        if (type == ZAN) {
            [SVProgressHUD showErrorWithStatus:@"点赞失败"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"取消赞失败"];
        }
        
    } andKeyValuePairs:@"D_ID", ddid, @"momentSupport.moment.id", item.momentID, @"momentSupport.actType", [NSString stringWithFormat:@"%d", type], nil];
}
#pragma mark - 瞬间回复列表

-(void)mReplayRequestWithUrl:(NSString *)url momentID:(NSString *)momentID PageIndex:(int)mPageIndex
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSString * newPage = [NSString stringWithFormat:@"%d", mPageIndex];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", momentID, @"momentReplyQuery.momentID", newPage, @"momentReplyQuery.pageNum", nil];
    
    isWorking2 = YES;
    
    __weak TotalVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"瞬间回复列表请求成功"];
        
        NSDictionary * root = (NSDictionary *)obj;
        
        NSMutableArray * temp = [[NSMutableArray alloc]init];
        
        if ([[root objectForKey:@"value"] isKindOfClass:[NSNull class]] || [[root objectForKey:[[root objectForKey:@"value"] objectForKey:@"list"]] isKindOfClass:[NSNull class]]) {
            
        }else{
            
            NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
            
            for (NSDictionary * dict in list) {
                
                Item_RemarkList * item = [[Item_RemarkList alloc]init];
                item.petName = [[dict objectForKey:@"author"] objectForKey:@"petName"];
                
                item.mid = [[dict objectForKey:@"author"] objectForKey:@"id"];
                item.content = [dict objectForKey:@"content"];
                //有点不合理 暂用
                item.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"] intValue];
                item.createTime = [dict objectForKey:@"createTime"];
                item.userType = [[[[dict objectForKey:@"author"] objectForKey:@"userType"] objectForKey:@"id"]intValue];
                
                 item.recordCount = [[[root objectForKey:@"value"] objectForKey:@"recordCount"]intValue];
                [temp addObject:item];
            }
            
            
            NSLog(@"temp:%@", temp);
        }
        
        //为了点击加载提供的方法
        NSArray * keys = [weakSelf.momentDict allKeys];
        
        for (NSString * key in keys) {
            
            //判断有没有momentID的Array
            if ([key isEqualToString:momentID]) {
                
                [[weakSelf.momentDict objectForKey:momentID] addObjectsFromArray:temp];
            }
        }
        
        NSLog(@"arr:%@", [weakSelf.momentDict objectForKey:momentID]);
        
        //用momentID当做key
        
        if (![[weakSelf.momentDict objectForKey:momentID] isKindOfClass:[NSNull class]] && [weakSelf.momentDict objectForKey:momentID] != nil) {
            [weakSelf.momentDict setObject:[weakSelf.momentDict objectForKey:momentID] forKey:momentID];
        }else{
            [weakSelf.momentDict setObject:temp forKey:momentID];
        }
        
        isWorking2 = NO;
        
        if (isWorking1 == NO && isWorking2 == NO) {
            
               [weakSelf.tableView reloadData];
        }
     
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        isWorking2 = NO;
        [SVProgressHUD showErrorWithStatus:@"瞬间回复列表请求失败"];
    }];
}

#pragma mark - 获取点赞列表

-(void)mHttpRequestWithUrl:(NSString *)url momentID:(NSString *)momentID
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", @"1" ,@"momentSupportQuery.pageNum", momentID, @"momentSupportQuery.momentID",nil];
    
    isWorking1 = YES;
    
    __weak TotalVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSimpleText:@"请求成功"];
        
        NSDictionary * root = (NSDictionary *)obj;
        
        
        if ([[root objectForKey:@"value"] isKindOfClass:[NSNull class]]) {
            
            
             isWorking1 = NO;
            [weakSelf.tableView reloadData];

            
        }else{
            
            NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
            
            NSMutableArray * temp = [[NSMutableArray alloc]init];
            
            for (NSDictionary * dict in list) {
                
                Item_zanList * item = [[Item_zanList alloc]init];
                item.mid = [[dict objectForKey:@"userInfo"] objectForKey:@"id"];
                item.petName = [[dict objectForKey:@"userInfo"] objectForKey:@"petName"];
                item.userType = [[[[dict objectForKey:@"userInfo"] objectForKey:@"userType"] objectForKey:@"id"]intValue];
                [temp addObject:item];
            }
            
            [weakSelf.zanDict setObject:temp forKey:momentID];
            
            isWorking1 = NO;
            
            if (isWorking1 == NO && isWorking2 == NO) {
                
                [weakSelf.tableView reloadData];
            }
            
        }
       
        
    } failed:^(NSObject *obj, BOOL isFinished) {
       
         isWorking1 = NO;
        [SVProgressHUD showSimpleText:@"请求失败"];
    }];
    
    
}
#pragma mark - 下拉刷新
//必须被重写
-(void)headerRereshing
{
    self.isRefresh = YES;
    
    pageIndex = 1;
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", nil];
    [self mHttpRequestWithUrl:dUrl_DIA_1_1_1 postDict:dict page:pageIndex];
}

#pragma mark - 上拉加载更多

//必须被重写
-(void)footerRereshing
{
    self.isRefresh = NO;
    
    if (self.isButtom == 0) {
        
        pageIndex++;
        
        NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
        
        NSString * ddid = [d objectForKey:UD_ddid];
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", nil];
        [self mHttpRequestWithUrl:dUrl_DIA_1_1_1 postDict:dict page:pageIndex];
        
    }else{
        
        [SVProgressHUD showSuccessWithStatus:@"没有更多数据"];
       [self.tableView footerEndRefreshing];
    }
}

#pragma mark - 获得瞬间

-(void)mHttpRequestWithUrl:(NSString *)url  postDict:(NSMutableDictionary *)postDict page:(int)page
{
    NSString * pa = [NSString stringWithFormat:@"%d", page];
    
    NSDictionary * temp = @{@"momentQuery.pageNum": pa};
    
    [postDict addEntriesFromDictionary:temp];
    
    TotalVC * weakSelf = self;
    
    [SVProgressHUD showWithStatus:dTip_loading];
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"瞬间列表请求成功"];
        
        //如果是下拉刷新 ，清空列表
        if (weakSelf.isRefresh == YES) {
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.momentDict removeAllObjects];
            [weakSelf.zanDict removeAllObjects];
        }
        
        NSDictionary * dict = (NSDictionary *)obj;
        NSMutableDictionary * tempDict = [dict objectForKey:@"value"];
        if([tempDict isKindOfClass:[NSNull class]]){
            [_tableView headerEndRefreshing];
            return ;
        }
        weakSelf.isButtom = [[[dict objectForKey:@"value"] objectForKey:@"isButtom"]integerValue];
        
        NSMutableArray * list = [tempDict objectForKey:@"list"];
        
        //取出数据模型
        for (NSDictionary * dict in list) {
            
            Item_MyWindow * item = [[Item_MyWindow alloc]init];
            
            item.userType = [[[[dict objectForKey:@"author"] objectForKey:@"userType"] objectForKey:@"id"]intValue];
            
            NSLog(@"item.userType:%d",item.userType);
            
            
              item.authorID = [[dict objectForKey:@"author"] objectForKey:@"id"];
            
            switch (item.userType) {
                case PARENT_USER:
                {
                    
                    item.gender = [[[dict objectForKey:@"childInfo"] objectForKey:@"gender"]intValue];
                    
//                    item.authorID = [[dict objectForKey:@"author"] objectForKey:@"id"];
                    //年龄
                    item.age = [NSString stringWithFormat:@"%@", [dict objectForKey:@"age"]];
                    item.birthday = [[dict objectForKey:@"childInfo"] objectForKey:@"birthday"];
                }
                    break;
                case TEACHER_USER:
                {
                    item.gender = 0;
                    if (isNotNull([dict objectForKey:@"childInfo"])) {
                        if (isNotNull([[dict objectForKey:@"childInfo"] objectForKey:@"gender"])) {
                           item.gender = [[[dict objectForKey:@"childInfo"] objectForKey:@"gender"]intValue];
                        }
                    }
                    
//                    item.authorID = [[dict objectForKey:@"author"] objectForKey:@"id"];
                    //年龄
                    item.age = [NSString stringWithFormat:@"%@", [dict objectForKey:@"age"]];
                    
                    item.birthday = @"";
                    if (isNotNull([dict objectForKey:@"childInfo"])) {
                        
                        if (isNotNull([[dict objectForKey:@"childInfo"] objectForKey:@"birthday"])) {
                            item.birthday = [[dict objectForKey:@"childInfo"] objectForKey:@"birthday"];
                        }
                    }
                    
                }
                    break;
                case AGENT_USER:
                {
                    
                }
                    break;
                default:
                    break;
            }
            
            //记录评论列表的页数，初始值为1
            item.remakCount = 1;
            
            //瞬间id
            item.momentID = [NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]];
            //内容
            item.content = [NSString stringWithFormat:@"%@", [dict objectForKey:@"content"]];
            //创建时间
            item.time = [NSString stringWithFormat:@"%@", [dict objectForKey:@"createTime"]];
            
            NSDictionary * dict2 = [dict objectForKey:@"author"];
            item.petName = [NSString stringWithFormat:@"%@", [dict2 objectForKey:@"petName"]];
            
            item.photoUrl = @"";
            if (![[dict2 objectForKey:@"photo"] isKindOfClass:[NSNull class]]) {
                
                item.photoUrl = [NSString stringWithFormat:@"%@%@",dUrl_PhotoPrefixion, [[dict2 objectForKey:@"photo"] objectForKey:@"relativePath"]];
                
            }
            
            NSLog(@"photoUrl:%@", item.photoUrl);
            item.replies = [[dict objectForKey:@"replies"]integerValue];
            item.supports = [[dict objectForKey:@"supports"]integerValue];
            item.viewReportFlag = [[dict objectForKey:@"viewReportFlag"] intValue];//是否举报
            item.viewSupportFlag = [[dict objectForKey:@"viewSupportFlag"] intValue];//是否点赞
            item.isOpen = NO;
            NSArray * urlArray = [dict objectForKey:@"diaBodyAttachmentList"];
            
            if ([urlArray isKindOfClass:[NSNull class]] || urlArray.count == 0) {
                [weakSelf.dataArray addObject:item];
                continue;
            }
            for (NSDictionary * dic in urlArray) {
                
                NSString * url;
                
                if (![[dic objectForKey:@"attachment"] isKindOfClass:[NSNull class]]) {
                    if ([[[dic objectForKey:@"attachment"] objectForKey:@"relativePath"] isKindOfClass:[NSNull class]]) {
                        
                    }else{
                        url = [NSString stringWithFormat:@"%@%@",dUrl_PhotoPrefixion, [[dic objectForKey:@"attachment"] objectForKey:@"relativePath"]];
                        [item.urlArray addObject:url];
                    }
                }
                
            }
            
            [weakSelf.dataArray addObject:item];
        }
        
        [SVProgressHUD dismiss];
        [weakSelf.tableView footerEndRefreshing];
        [weakSelf.tableView headerEndRefreshing];
        [weakSelf.tableView reloadData];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"瞬间列表请求失败"];
        
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = NO;
    [self.tableView headerBeginRefreshing];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS7) {
        
        self.navigationController.navigationBar.translucent = NO;
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self createNavItem];
    
    [self createUIView];
    
//    [self createKeyBoard];
    
    __weak TotalVC * weakSelf = self;
    
    //双击导航条之后下拉刷新
    [self.navigationController.navigationBar whenDoubleTapped:^{
        
        [weakSelf.tableView headerBeginRefreshing];
        
    }];

}

#pragma mark - 点击展开分组

-(void)remarkBtnClick:(UIButton *)button
{
    Item_MyWindow * item = _dataArray[button.tag - MAX_TAG];
    item.isOpen = !item.isOpen;
    
    if (item.isOpen == YES) {
        
        [self mHttpRequestWithUrl:dUrl_DIA_1_3_2 momentID:item.momentID];
        
        [self mReplayRequestWithUrl:dUrl_DIA_1_4_2 momentID:item.momentID PageIndex:1];
    
    }
    //关闭分组
    if (item.isOpen == NO) {
        
        NSMutableArray * temp = [self.momentDict objectForKey:item.momentID];
        [temp removeAllObjects];
        
    [self.tableView reloadData];
        
//        NSIndexSet * set = [NSIndexSet indexSetWithIndex:button.tag - MAX_TAG];
//        
//        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationBottom];
    }
    
    

}

#pragma mark - 发布瞬间

-(void)rightItemClick
{
    PublisWindowVC * publishVC = [[PublisWindowVC alloc]init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

#pragma mark - 返回拉抽屉

-(void)leftItemClick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma  mark - 创建 leftItem RightItem
-(void)createNavItem
{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    
    [leftButton setImage:[UIImage imageNamed:@"top_icon_chuchuang normal"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"top_icon_chuchuang selected"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:dPic_Public_toprelease forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

}

#pragma mark - 创建tableView

-(void)createUIView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 49 - 44)
                                                 style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    //注册下拉刷新
    [self setupRefresh:self.tableView];
    
}

#pragma mark - tableViewDelegate
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView * view = [[UIView alloc]init];
//    view.frame = CGRectMake(0, 0, kMainScreenWidth, 0.01);
//    view.backgroundColor = [UIColor whiteColor];
//    return view;
//}
//#pragma mark - 除去tableViewGroup模式的黑色footer
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.01;
//}

#pragma mark - 每一条瞬间
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    Cell_Show * cell = [[Cell_Show alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    Item_MyWindow * item = _dataArray[section];
    
    cell.nickNameLbl.text = item.petName;
   
    
    NSString * replay = [NSString stringWithFormat:@"%d", item.replies + item.supports];
    [cell.remarkBtn setTitle:replay forState:UIControlStateNormal];
    
    NSURL * u = [NSURL URLWithString:item.photoUrl];
    
    NSLog(@"url == %@", u);
    [cell.headerImageView setImageWithURL:u placeholderImage:[UIImage imageNamed:@"saga2.jpg"]];
    
      __weak TotalVC * weakSelf = self;
    
    [cell.headerImageView whenTapped:^{
        
        Item_MyWindow * item = weakSelf.dataArray[section];
        
        OtherVC * otherVC = [[OtherVC alloc]init];
        
        otherVC.userType = item.userType;
        
        NSLog(@"userTYpe == %d", item.userType);
        
        otherVC.title = [item.petName stringByAppendingString:@"的橱窗"];
        
        otherVC.authorID = item.authorID;
        
        
        [weakSelf.navigationController pushViewController:otherVC animated:YES];
        
    }];
    

//    [cell whenTapped:^{
//        
//        Item_MyWindow * item = weakSelf.dataArray[section];
//        
//        OtherVC * otherVC = [[OtherVC alloc]init];
//        
//        otherVC.userType = item.userType;
//        
//        NSLog(@"userTYpe == %d", item.userType);
//        
//        otherVC.title = [item.petName stringByAppendingString:@"的橱窗"];
//        
//        otherVC.authorID = item.authorID;
//        
//        
//        [weakSelf.navigationController pushViewController:otherVC animated:YES];
//    }];
    
    switch (item.gender) {
        case MAN:
        {
            [cell.babyageBtn setImage:[UIImage imageNamed:@"boy-notselected30"] forState:UIControlStateNormal];
            [cell.babyageBtn setImage:[UIImage imageNamed:@"boy-selected30"] forState:UIControlStateSelected];
            
            NSString * age =  [TimeTool getBabyAgeWithBirthday:item.birthday publicTime:item.time];
            [cell.babyageBtn setTitle:age forState:UIControlStateNormal];
        }
            break;
        case WOMAN:
        {
            [cell.babyageBtn setImage:[UIImage imageNamed:@"girl-notselected30"] forState:UIControlStateNormal];
            [cell.babyageBtn setImage:[UIImage imageNamed:@"girl-selected30"] forState:UIControlStateSelected];
            
            [cell.babyageBtn setTitle:item.age forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
    [cell.babyageBtn whenTapped:^{
        
        Item_MyWindow * item = weakSelf.dataArray[section];
        
        OtherVC * otherVC = [[OtherVC alloc]init];
        
        otherVC.userType = item.userType;
        
        NSLog(@"userTYpe == %d", item.userType);
        
        otherVC.title = [item.petName stringByAppendingString:@"的橱窗"];
        
        otherVC.authorID = item.authorID;
        
        
        [weakSelf.navigationController pushViewController:otherVC animated:YES];
    }];
    
    CGSize size = [[MyParserTool shareInstance] sizeWithRawString:item.content constrainsToWidth:cell.contentLbl.frame.size.width Font:cell.contentLbl.font];
    CGRect frame = cell.contentLbl.frame;
    frame.size = size;
    
    cell.contentLbl.frame = frame;
//    cell.contentLbl.backgroundColor = [UIColor greenColor];
    cell.contentLbl.text = item.content;
    cell.timeLbl.text = [TimeTool getUTCFormateDate:item.time];

      if (item.urlArray.count != 0) {
        
        frame = cell.showImageView.frame;
        
        frame.size.height = frame.size.width;
          frame.origin.y = CGRectGetMaxY(cell.contentLbl.frame);

        cell.showImageView.frame = frame;
        
          //用于集成照片浏览器
        cell.showImageView.tag = MAX_TAG_3 + section;
        
        NSURL * url = [NSURL URLWithString:item.urlArray[0]];
        
        [cell.showImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"saga2.jpg"]];
          
          
          UIButton * placeHoder = [[UIButton alloc]initWithFrame:cell.showImageView.frame];
          
          placeHoder.tag = MAX_TAG_2 + section;
          
          [cell addSubview:placeHoder];
          
          [placeHoder addTarget:self action:@selector(tapImageClick:) forControlEvents:UIControlEventTouchUpInside];
          
          frame = cell.remarkBtn.frame;
          
          frame.origin.y = CGRectGetMaxY(cell.showImageView.frame) + 5;
          cell.remarkBtn.frame = frame;
    }
      else{
          
          frame = cell.remarkBtn.frame;
          
          frame.origin.y = CGRectGetMaxY(cell.contentLbl.frame) + 5;
          cell.remarkBtn.frame = frame;
      }
    
    //添加more的那张图片
    if (item.urlArray.count > 1) {
        
        frame = cell.showImageView.frame;
        
        CGFloat x = CGRectGetWidth(frame);
        CGFloat y = CGRectGetHeight(frame);
        
        NSInteger count = item.urlArray.count;
        
        UIPageControl * pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(x - 18 * count, y - 15, 18 * count, 15)];
        pageCtrl.numberOfPages = item.urlArray.count;
        pageCtrl.backgroundColor = [UIColor grayColor];
        pageCtrl.alpha = 0.8;
        pageCtrl.pageIndicatorTintColor = [UIColor whiteColor];
        [cell.showImageView addSubview:pageCtrl];
    }
    
    cell.remarkBtn.selected = item.isOpen;
    cell.remarkBtn.tag = MAX_TAG + section;
    [cell.remarkBtn addTarget:self action:@selector(remarkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    Item_MyWindow * item = _dataArray[section];
    
    CGSize size = [[MyParserTool shareInstance] sizeWithRawString:item.content constrainsToWidth:kMainScreenWidth - 80 Font:[UIFont systemFontOfSize:14]];
    
    if (item.urlArray && item.urlArray.count!= 0) {
     
        return  (kMainScreenWidth - 80)  + 100 + size.height;
    }
    return 100 + size.height;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item_MyWindow * item = _dataArray[indexPath.section];
    
    NSArray * temp = [self.momentDict objectForKey:item.momentID];
    
    if (indexPath.row == 0) {
        
        Item_MyWindow * item = _dataArray[indexPath.section];
        
        NSArray * temp = [self.zanDict objectForKey:item.momentID];
        
        if (temp!=nil && temp.count!= 0) {
            
            NSString * html = [StringTool assmbleHtmlStringWithArray:temp];
            //用来计算高度
            RTLabel * rtlbl = [[RTLabel alloc]init];
            rtlbl.text = html;
            CGSize  size =  [rtlbl optimumSize];
            
            return size.height + 44;
        }
        
        return 44;
    }
    if (indexPath.row == temp.count + 1) {
        
        return 35;
    }
 
    Item_RemarkList * item2 =temp[indexPath.row - 1];
    
    return [item2 height]  + 20 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Item_MyWindow * item = _dataArray[section];
    if (!item.isOpen) {
        
        return 0;
    }
    
    NSMutableArray * temp = [self.momentDict objectForKey:item.momentID];
    
    return temp.count + 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item_MyWindow * item = _dataArray[indexPath.section];
    
    NSArray * temp = [self.momentDict objectForKey:item.momentID];
    
    if (indexPath.row == temp.count + 1) {
        
        [SVProgressHUD showSimpleText:@"点击加载更多"];
        
        if (temp && temp.count!= 0) {
            
            Item_RemarkList * item2 = [temp lastObject];
            
            if (item2.isButtom == 0) {
                
                item.remakCount++;
                
                NSLog(@"%d", item.remakCount);
                
                [self mReplayRequestWithUrl:dUrl_DIA_1_4_2 momentID:item.momentID PageIndex:item.remakCount];
                
            }else{
                
                [SVProgressHUD showSuccessWithStatus:@"没有更多数据"];
            }
        }else{
            
            return;
        }
        
    }else{
        
        [self.contentWrapper showKeyboard];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Item_MyWindow * item = _dataArray[indexPath.section];
    
    NSArray * temp = [self.momentDict objectForKey:item.momentID];
    
    if (indexPath.row == 0) {
        return  [self createContentCell:indexPath];
    }
    if (indexPath.row == temp.count + 1) {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"点击加载更多";
        return cell;
    }
    NSString * strID = @"ID";
    Cell_ShowRemark * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        cell = [[Cell_ShowRemark alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    Item_RemarkList * item2 =temp[indexPath.row -1];
    
    
    cell.remarkLbl.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    
    [cell.remarkLbl setLinkAttributes:nil];
    NSMutableAttributedString * myStr = [StringTool assmbleTTTAttringStringWithString:item2.petName bString:item2.content];
    cell.remarkLbl.text = myStr;
   
    NSRange range = NSMakeRange(0, item2.petName.length + 1);
    
    NSString * urlStr = [NSString stringWithFormat:@"file:///%@_%ld", item2.mid, indexPath.section];
    NSLog(@"%@", item2.mid);
    NSLog(@"urlStr == %@", urlStr);
    [cell.remarkLbl addLinkToURL:[NSURL URLWithString:urlStr] withRange:range];
    //曲调超链接的下划线
    cell.remarkLbl.tag = MAX_TAG_5 + indexPath.row;
    cell.remarkLbl.delegate = self;
    CGRect frame = cell.remarkLbl.frame;
    frame.size.height = [item2 height] + 5;
    cell.remarkLbl.frame = frame;
    return cell;
}
#pragma mark - tttdleegate 点击进入该朋友的橱窗
- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    
    //获得相对路径
    NSString * str = [url relativeString];
    str = [str stringByReplacingOccurrencesOfString:@"file:///" withString:@""];
    NSLog(@"%@", str);
    
    //拿到section的range
     NSRange range = [str rangeOfString:@"_"];
    
    //拿到section
    NSString * sectionStr = [str substringFromIndex:range.location + 1];
    NSInteger section = sectionStr.integerValue;
    
    Item_MyWindow * item1 = self.dataArray[section];
    
    NSArray * temp = [self.momentDict objectForKey: item1.momentID];

    Item_RemarkList * item2 = temp[(label.tag - MAX_TAG_5) - 1];
    
    OtherVC * otherVC = [[OtherVC alloc]init];
    
    otherVC.userType = item2.userType;
    
    otherVC.title = [item2.petName stringByAppendingString:@"的橱窗"];
    
    otherVC.authorID = item2.mid;
    
    [self.navigationController pushViewController:otherVC animated:YES];

}
-(UITableViewCell *)createContentCell:(NSIndexPath *)index
{
    UIView * mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 80)];
    
    UIButton * infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    infoBtn.frame =  CGRectMake(70, 12, 25, 25);
    [infoBtn setBackgroundImage:[UIImage imageNamed:@"show_info"] forState:UIControlStateNormal];
    [infoBtn setBackgroundImage:[UIImage imageNamed:@"show_info_selected"] forState:UIControlStateHighlighted];
    infoBtn.tag = index.section + MAX_TAG;
    [infoBtn addTarget:self action:@selector(warnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:infoBtn];
    
    UIButton * zan = [UIButton buttonWithType:UIButtonTypeCustom];
    zan.frame = CGRectMake(infoBtn.frame.size.width + infoBtn.frame.origin.x + 30, 12, 50, 25);
    [zan setTitle:@"赞" forState:UIControlStateNormal];
    zan.titleLabel.font = [UIFont systemFontOfSize:13];
    [zan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [zan setImage:[UIImage imageNamed:@"show_item_zan"] forState:UIControlStateNormal];
    [zan setImage:[UIImage imageNamed:@"show_item_zan1"] forState:UIControlStateHighlighted];
    zan.layer.cornerRadius = 3;
//    zan.layer.borderColor = [UIColor grayColor].CGColor;
    zan.layer.borderWidth = 1;
    [zan setLayout:OTSImageLeftTitleRightStyle spacing:10];
    zan.tag = index.section + MAX_TAG;
    [zan addTarget:self action:@selector(zanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:zan];
    
    UIButton * remarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = zan.frame;
    frame.origin.x = zan.frame.origin.x + zan.frame.size.width + 30;
    remarkBtn.frame = frame;
    remarkBtn.layer.masksToBounds = YES;
    remarkBtn.layer.borderWidth = 1;
    remarkBtn.layer.borderColor = [UIColor grayColor].CGColor;
    remarkBtn.layer.cornerRadius = 3;
    [remarkBtn setLayout:OTSImageLeftTitleRightStyle spacing:5];
    [remarkBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    remarkBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [remarkBtn setTitle:@"评论" forState:UIControlStateNormal];
    [remarkBtn setImage:[UIImage imageNamed:@"show_item_comment"] forState:UIControlStateNormal];
    [remarkBtn setImage:[UIImage imageNamed:@"show_item_comment1"] forState:UIControlStateHighlighted];
    remarkBtn.tag = index.section  + MAX_TAG;
    [remarkBtn addTarget:self action:@selector(remarkBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:remarkBtn];
    
    RTLabel * rtLabel = [[RTLabel alloc]initWithFrame:CGRectMake(70, remarkBtn.frame.origin.y + remarkBtn.frame.size.height + 10, kMainScreenWidth - 80, 40)];
    rtLabel.tag = MAX_TAG_4 + index.section;
    rtLabel.font = [UIFont systemFontOfSize:14];
    Item_MyWindow * item = _dataArray[index.section];
    
    NSArray * temp = [self.zanDict objectForKey:item.momentID];
    
    if (temp!=nil && temp.count!= 0) {
        
        NSString * html = [StringTool assmbleHtmlStringWithArray:temp];
    
        rtLabel.text = html;
    }
    
    rtLabel.textColor = [UIColor blueColor];
    rtLabel.delegate = self;
//    rtLabel.font = [UIFont systemFontOfSize:];
    
    //动态计算rtLabel的高度
    CGSize optimumSize = [rtLabel optimumSize];
    
    frame = rtLabel.frame;
    
    frame.size = optimumSize;
    
    rtLabel.frame = frame;
    
    rtLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    
    [mainView addSubview:rtLabel];
    
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:mainView];
    
    return cell;
}
#pragma mark - RTLabelDelegate
/**用于点击评论列表之后进入改朋友的主页**/
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    //    NSString * str = [url host];
    NSString * str = [url absoluteString];
    str = [str URLDecodedString];
    
    //这个str是评论人的id
    str = [str substringFromIndex:5];
    NSLog(@"%@", str);
    
#pragma mark - 先根据 tag值取出瞬间id,再用瞬间id当做key取出_zanlist中的点在列表，在点赞列表中找到 和 传过来的id相同的id对应的用户类型传值
    RTLabel * newRtLabel = (RTLabel *)rtLabel;
    
    Item_MyWindow * item = self.dataArray[newRtLabel.tag - MAX_TAG_4];
    
    NSArray * temp = _zanDict[item.momentID];
    
    //用户类型
    
    Item_zanList * tempItem = nil;
    
    for (Item_zanList * zanItem in temp) {
        
        if ([zanItem.mid isEqualToString:str]) {
            
//            userType = zanItem.userType;
            tempItem = zanItem;
            break;
        }
    }
    
//    [self httpRequestWithUrl:dUrl_OSM_1_1_13 mid:str uerType:userType];
    OtherVC * otherVC = [[OtherVC alloc]init];
    
    otherVC.userType = tempItem.userType;
    
    otherVC.title = [tempItem.petName stringByAppendingString:@"的橱窗"];
    
    otherVC.authorID = tempItem.mid;
    
    [self.navigationController pushViewController:otherVC animated:YES];
    
}
/**暂时不用了**/
#pragma mark - 点击进入改朋友的资料
-(void)httpRequestWithUrl:(NSString *)url mid:(NSString *)mid uerType:(int)userType
{
    
    NSLog(@"usertype = %d", userType);
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", mid, @"userInfoQuery.orId",nil];
    
    __weak TotalVC * weakSelf = self;

    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"请求成功"];
        
        NSDictionary * root = (NSDictionary *)obj;
        
        weakSelf.item.petName = [[root objectForKey:@"value"] objectForKey:@"petName"];
        
        weakSelf.item.relativePath = @"";
        if (isNotNull([root objectForKey:@"value"] )) {
            
            if (isNotNull([[root objectForKey:@"value"] objectForKey:@"photo"])) {
                if (isNotNull([[[root objectForKey:@"value"] objectForKey:@"photo"] objectForKey:@"relativePath"])) {
                    
                    weakSelf.item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, [[[root objectForKey:@"value"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
                }
            }
        }
        
        
        weakSelf.item.located = @"";
        weakSelf.item.personnelSignature = @"";
        weakSelf.item.gender = 0;
        switch (userType) {
            case AGENT_USER:
            {
                weakSelf.item.located = @"";
                weakSelf.item.personnelSignature = @"";
                if (isNotNull([[root objectForKey:@"value"] objectForKey:@"organization"])) {
                    
                    if (isNotNull([[[root objectForKey:@"value"] objectForKey:@"organization"] objectForKey:@"organizationExtension"])) {
                        
                        if ([[[[root objectForKey:@"value"] objectForKey:@"organization"] objectForKey:@"organizationExtension"]objectForKey:@"bizAddress"]) {
                            
                            weakSelf.item.located = [[[[root objectForKey:@"value"] objectForKey:@"organization"] objectForKey:@"organizationExtension"]objectForKey:@"bizAddress"];
                        }
                        
                        if ([[[[root objectForKey:@"value"] objectForKey:@"organization"] objectForKey:@"organizationExtension"] objectForKey:@"description"]) {
                             weakSelf.item.personnelSignature = [[[[root objectForKey:@"value"] objectForKey:@"organization"] objectForKey:@"organizationExtension"] objectForKey:@"description"];
                        }
                    }
                }
                
               
            }
                break;
            case TEACHER_USER:
            {
                if (isNotNull([[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"located"])) {
                    weakSelf.item.located = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"located"];
                }

                weakSelf.item.personnelSignature = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"personnelSignature"];
                weakSelf.item.gender =[[[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"gender"]intValue];
            }
                break;
            case PARENT_USER:
            {
                if (isNotNull([[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"located"])) {
                     weakSelf.item.located = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"located"];
                }
               
                weakSelf.item.personnelSignature = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"personnelSignature"];
                weakSelf.item.gender =[[[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"gender"]intValue];
            }
                break;
            default:
                break;
        }
       
        weakSelf.item.wpCode = [[root objectForKey:@"value"] objectForKey:@"wpCode"];
        weakSelf.myDatumVC.item = weakSelf.item;
        weakSelf.myDatumVC.type = 2;
        [weakSelf.navigationController pushViewController:weakSelf.myDatumVC animated:YES];
        
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
    
   
}

#pragma mark -集成微信键盘

-(void)createKeyBoard
{
    self.contentWrapper = [[RDRStickyKeyboardView alloc]initWithScrollView:self.tableView];
    self.contentWrapper.frame = self.view.bounds;
    self.contentWrapper.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.contentWrapper.placeholder = @"Message";
    [self.contentWrapper.inputView.rightButton addTarget:self action:@selector(didTapSend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.contentWrapper];
    
    [self.contentWrapper.inputView.leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 左边button点击
-(void)leftBtnClick
{
//    if (self.contentWrapper.inputView.textView.isFirstResponder) {
//        
//        if (self.contentWrapper.inputView.textView.emoticonsKeyboard != nil) {
//            [self.contentWrapper.inputView.textView switchToDefaultKeyboard];
//            
//        }else{
//            [self.contentWrapper.inputView.textView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
//        }
//    }else{
//        
//        [self.contentWrapper.inputView.textView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
//        [self.contentWrapper.inputView.textView becomeFirstResponder];
//        
//    }
}
#pragma mark - 右边button点击
- (void)didTapSend:(id)sender
{
    [self.contentWrapper hideKeyboard];
//    //对活动进行回复
//    if (self.index.section == 0) {
//        
//        if (self.newIndex == 0) {
//            [self remarkRemarkListWithString:self.contentWrapper.inputView.textView.text aid:self.activityID];
//        }
//        if (self.newIndex == 3) {
//            ////活动举报
//            [self warningWithString:self.contentWrapper.inputView.textView.text];
//        }
//        
//    }else{
//        
//        if (self.newIndex == 0) {
//            //对活动回复进行回复
//            [self remarkRemarkListWithString:self.contentWrapper.inputView.textView.text aid:self.activityID];
//        }
//        if (self.newIndex == 3) {
//            
//            Item_ACT_RemarkList * item = _dataArray[self.index.row];
//            
//            [self waringWithAString:self.contentWrapper.inputView.textView.text andAid:item.rid];
//        }
//        
//    }
//    
//    self.contentWrapper.inputView.textView.text = @" ";
//    CGRect frame = self.contentWrapper.inputView.textView.frame;
//    frame.size.height = 40;
//    self.contentWrapper.inputView.textView.frame = frame;
//    [self.contentWrapper hideKeyboard];
//    
//    [self.contentWrapper.inputView.textView switchToDefaultKeyboard];
//    NSLog(@"%@", self.contentWrapper.inputView.textView.text);
}




#pragma mark - 相册的方法

-(void)tapImageClick:(UIButton *)button
{
    
    Item_MyWindow * item = _dataArray[button.tag - MAX_TAG_2];
    NSArray * urls = item.urlArray;
    NSInteger count = urls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        if (i == 0) {
            //            photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
            photo.srcImageView = (UIImageView *)[self.view viewWithTag:(button.tag - MAX_TAG_2) + MAX_TAG_3];
            
        }
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}
@end
