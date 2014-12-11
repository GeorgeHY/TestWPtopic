//
//  MineShowWindowVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-10-5.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#define MAX_TAG 1000
#define APIType(i) i //页面类型 1.家长我的橱窗
#import "MineShowWindowVC.h"
#import "Cell_AllMyShowWindow.h"
#import "Item_AllWinwow.h"
#import "UIViewController+MMDrawerController.h"
#import "UIViewController+General.h"
#import "UIView+WhenTappedBlocks.h"
#import "Item_AllWinwow.h"
#import "Item_MyWindow.h"
#import "Item_userInfo.h"
#import "Item_AllShowWindow.h"
#import "Item_RemarkList.h"
#import "Item_zanList.h"
#import "UIImageView+WebCache.h"
#import "UIColor+AddColor.h"
#import "Cell_MyWindow.h"
#import "Cell_RemarkList.h"
#import "TimeTool.h"
#import "StringTool.h"
#import "PublisWindowVC.h"
#import "UIButton+FlexSpace.h"
#import "RichLabelView.h"//封装的微信朋友圈的view,最好用RTLabel代替
#import "AppDelegate.h"
#import "MyParserTool.h"
@interface MineShowWindowVC ()
{
    AFN_HttpBase * http;
    
    int pageIndex;
    
    MyParserTool * tool;
}
@property (nonatomic, assign) int currentPage;//当前页码
@property (nonatomic, assign) int isButtom;//是否有下一页
@property (nonatomic, strong) Item_userInfo * item_userInfo;
@property (nonatomic, assign) int refreshType;
@property (nonatomic, assign) int totalCount;//总页数
@property (nonatomic, assign) BOOL opertaion;//下拉刷新操作，yes表示是下拉刷洗，no表示是上拉
@property (nonatomic, assign) BOOL isWorking;
@end

@implementation MineShowWindowVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _dataArray = [[NSMutableArray alloc]init];//瞬间
        _momentArray = [[NSMutableArray alloc]init];//瞬间回复
        _zanArray = [[NSMutableArray alloc]init];//赞列表
        _item_userInfo = [[Item_userInfo alloc]init];
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
    
    [self createUIView];
    
    [self createNavItem];
    
    //解析富文本的工具
    tool = [MyParserTool shareInstance];
    
    pageIndex = 1;

    [self httpRequestWithPageIndex:pageIndex];
    
    //注册下拉刷新
    [self setupRefresh:self.tableView];
    
}

-(void)headerRereshing
{
    if (self.isWorking == YES) {
        return;
    }
    pageIndex = 1;
    //从第一页开始
    [self httpRequestWithPageIndex:pageIndex];
}
-(void)footerRereshing
{
    
    if (self.isWorking == YES) {
        return;

    }
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
        case APIType(1):
        {
            NSMutableDictionary * postDict = [[NSMutableDictionary alloc]init];
            
            [self startHttpRequestWithUrl:dUrl_DIA_1_1_2 postDict:postDict page:newPageIndex];
        }
            break;
        case APIType(2):
        {
        }
            break;
        default:
            break;
    }
}

-(void)getRemarkListWithList:(NSArray *)list
{
    
    for (Item_MyWindow * item in list) {
        
        NSLog(@"%@", item.momentID);
        
        NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:item.momentID,@"momentReplyQuery.momentID", nil];
    
        //page暂时写1
        [self httpRequestWithUrl:dUrl_DIA_1_4_2 postDict:postDict page:1];
    }
}

/**瞬间点赞分页列表**/
-(void)getZanListWithList:(NSArray *)list
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    
    for (Item_MyWindow * item in list) {
        
        NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:item.momentID,@"momentSupportQuery.momentID", @"1", @"momentSupportQuery.pageNum", ddid, @"D_ID", nil];

    }

}

-(void)getZanListWithUrl:(NSString *)url postDict:(NSMutableDictionary *)postDict
{
    
    NSLog(@"{postDict:%@}", postDict);
    
    __weak MineShowWindowVC * weakSelf = self;
    
    [http fiveReuqestUrl:dUrl_DIA_1_3_2 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
       
        NSDictionary * root = (NSDictionary *)obj;
        
        NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
        
        NSMutableArray * temp = [[NSMutableArray alloc]init];
        
        for (NSDictionary * dict in list) {
            
            Item_zanList * item = [[Item_zanList alloc]init];
            
            item.petName = [[dict objectForKey:@"userInfo"] objectForKey:@"petName"];
            item.mid = [dict objectForKey:@"id"];
            
            [temp addObject:item];
        }
        
        [weakSelf.zanArray addObject:temp];
        
//        if (weakSelf.dataArray.count == weakSelf.momentArray.count == weakSelf.zanArray.count) {
//            
//            [weakSelf.tableView reloadData];
//            [weakSelf.tableView footerEndRefreshing];
//            [weakSelf.tableView headerEndRefreshing];
//            self.isWorking = NO;
//        }
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    }];
}

/**点击加载更多**/
-(void)moreRequestWithUrl:(NSString *)url postDict:(NSMutableDictionary *)postDict page:(int)page
{
    NSString * curPage = [NSString stringWithFormat:@"%d", page];
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    NSDictionary * commonDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", curPage, @"momentReplyQuery.pageNum", nil];
    [postDict addEntriesFromDictionary:commonDict];
    
    
    NSLog(@"{postDict:%@}", postDict);
    
    __weak MineShowWindowVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSuccessWithStatus:@"瞬间恢复请求成功"];
        NSDictionary * root = (NSDictionary *)obj;
        
        self.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"] integerValue];
        
        NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
        
        NSMutableArray * smallArr = [[NSMutableArray alloc]init];
        for (NSDictionary * dic in list) {
            
            Item_RemarkList * item = [[Item_RemarkList alloc]init];
            item.content = [dic objectForKey:@"content"];
            item.petName = [[dic objectForKey:@"author"] objectForKey:@"petName"];
            //不是很合理，暂用
            item.isButtom = [NSString stringWithFormat:@"%@", [[root objectForKey:@"value"] objectForKey:@"isButtom"]];
            [smallArr addObject:item];
        }
        
        [weakSelf.momentArray addObject:smallArr];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView footerEndRefreshing];
        [weakSelf.tableView headerEndRefreshing];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"瞬间回复请求失败"];
    }];
}
/**瞬间评论列表**/
-(void)httpRequestWithUrl:(NSString *)url postDict:(NSMutableDictionary *)postDict page:(int)page
{
    NSString * curPage = [NSString stringWithFormat:@"%d", page];
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    NSDictionary * commonDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", curPage, @"momentReplyQuery.pageNum", nil];
    [postDict addEntriesFromDictionary:commonDict];
    
    __weak MineShowWindowVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
          [SVProgressHUD showSuccessWithStatus:@"瞬间恢复请求成功"];
        NSDictionary * root = (NSDictionary *)obj;
        
        
        if (![[root objectForKey:@"value"] isKindOfClass:[NSNull class]]) {
            
            self.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"] integerValue];
            
            NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
            
            NSMutableArray * smallArr = [[NSMutableArray alloc]init];
            for (NSDictionary * dic in list) {
                
                Item_RemarkList * item = [[Item_RemarkList alloc]init];
                item.content = [dic objectForKey:@"content"];
                item.petName = [[dic objectForKey:@"author"] objectForKey:@"petName"];
                //不是很合理，暂用
                item.isButtom = [NSString stringWithFormat:@"%@", [[root objectForKey:@"value"] objectForKey:@"isButtom"]];
                [smallArr addObject:item];
            }
            
            [weakSelf.momentArray addObject:smallArr];
            
            if (weakSelf.dataArray.count == weakSelf.momentArray.count) {
                
                [weakSelf.tableView reloadData];
                [weakSelf.tableView footerEndRefreshing];
                [weakSelf.tableView headerEndRefreshing];
                self.isWorking = NO;
            }

        }else{
            
            
            NSMutableArray * smallArr = [[NSMutableArray alloc]init];
            
            [weakSelf.momentArray addObject:smallArr];
            
            if (weakSelf.dataArray.count == weakSelf.momentArray.count) {
                
                [weakSelf.tableView reloadData];
                [weakSelf.tableView footerEndRefreshing];
                [weakSelf.tableView headerEndRefreshing];
                self.isWorking = NO;
            }

            
        }
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"瞬间回复请求失败"];
    }];
}
/**瞬间列表**/
-(void)startHttpRequestWithUrl:(NSString *)url  postDict:(NSMutableDictionary *)postDict page:(int)page
{
    self.isWorking = YES;
    NSString * curPage = [NSString stringWithFormat:@"%d", page];
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    //因为当前页码和ddid是必须传的
    NSDictionary * commonDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", curPage, @"momentQuery.pageNum", nil];
    [postDict addEntriesFromDictionary:commonDict];
    
    MineShowWindowVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.momentArray removeAllObjects];
        [weakSelf.zanArray removeAllObjects];
        NSDictionary * dict = (NSDictionary *)obj;
        
        NSMutableDictionary * tempDict = [dict objectForKey:@"value"];
        
        NSMutableArray * list = [tempDict objectForKey:@"list"];

        //取出数据模型
        for (NSDictionary * dict in list) {
            
            Item_MyWindow * item = [[Item_MyWindow alloc]init];
            
            item.remakCount = 1;
            
            //年龄
            item.age = [NSString stringWithFormat:@"%@", [dict objectForKey:@"age"]];
            //瞬间id
            item.momentID = [NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]];
            //内容
            item.content = [NSString stringWithFormat:@"%@", [dict objectForKey:@"content"]];
            //创建时间
            item.time = [NSString stringWithFormat:@"%@", [dict objectForKey:@"createTime"]];
            
            NSDictionary * dict2 = [dict objectForKey:@"author"];
            item.petName = [NSString stringWithFormat:@"%@", [dict2 objectForKey:@"petName"]];
            item.photoUrl = [NSString stringWithFormat:@"%@", [dict2 objectForKey:@"photoUrl"]];
            item.replies = [[dict objectForKey:@"replies"]integerValue];
            item.isOpen = YES;
            NSArray * urlArray = [dict objectForKey:@"diaBodyAttachmentList"];
            
            if ([urlArray isKindOfClass:[NSNull class]] || urlArray.count == 0) {
                [weakSelf.dataArray addObject:item];
                continue;
            }
            for (NSDictionary * dic in urlArray) {
                
                NSString * url;
                if ([[[dic objectForKey:@"attachment"] objectForKey:@"relativePath"] isKindOfClass:[NSNull class]]) {
                    url = @"";
                }else{
                    url = [NSString stringWithFormat:@"%@%@",dUrl_PhotoPrefixion, [[dic objectForKey:@"attachment"] objectForKey:@"relativePath"]];
                }
                
                [item.urlArray addObject:url];
            }
            
            [weakSelf.dataArray addObject:item];
        }
        
        
         [weakSelf getRemarkListWithList:weakSelf.dataArray];
       
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"瞬间列表请求失败"];
        
    }];
}


/**发表瞬间**/
-(void)rightItemClick
{
    PublisWindowVC * publishVC = [[PublisWindowVC alloc]init];
    [self.navigationController pushViewController:publishVC animated:YES];
}
-(void)leftItemClick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
/**点赞**/

-(void)zanBtnClick:(UIButton *)btn
{
    static int count = 0;
    
    count++;
    
    int type = 0;
    
    if (count % 2 == 0) {
        //取消赞
        type = 2;
    }else{
        //点赞
        type = 1;
    }
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];

    NSString * ddid = [d objectForKey:UD_ddid];
    
    Item_MyWindow * item = [_dataArray objectAtIndex:btn.tag - MAX_TAG];
    
    
    [http thirdRequestWithUrl:dUrl_DIA_1_3_1 succeed:^(NSObject *obj, BOOL isFinished) {
       
        
        if (type == 1) {
            [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
        }
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        if (type == 1) {
            [SVProgressHUD showErrorWithStatus:@"点赞失败"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"取消赞失败"];
        }
        
    } andKeyValuePairs:@"D_ID", ddid, @"momentSupport.moment.id", item.momentID, @"momentSupport.actType", [NSString stringWithFormat:@"%d", type], nil];
}
/**评论**/
-(void)remarkBtnClick:(UIButton *)btn
{
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    Item_MyWindow * item = [_dataArray objectAtIndex:btn.tag - MAX_TAG];
    
    __weak MineShowWindowVC * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_DIA_1_4_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"评论成功"];
        
        //评论成功之后让电话那加1
        Item_MyWindow * item = [_dataArray objectAtIndex:btn.tag - MAX_TAG];
        item.replies++;
        [weakSelf.tableView reloadData];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"评论失败"];
        
    } andKeyValuePairs:@"D_ID", ddid, @"momentReply.content", @"很长很长很长很长很长很长很长很长很长很长的评论很长很长很长很长很长很长很长很长很长很长的评论", @"momentReply.moment.id", item.momentID,@"momentReplyQuery.pageNum", @"1", nil];
}
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
/**打开和关闭评论列表**/
-(void)btnClick:(UIButton *)button
{
    Item_AllWinwow * item = _dataArray[button.tag - MAX_TAG];
    item.isOpen = !item.isOpen;
    
    [self.tableView reloadData];
}
/**删除瞬间**/
-(void)deleteAction
{
    [SVProgressHUD showSimpleText:@"删除"];
}
-(void)createNavItem
{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    //    [leftButton setBackgroundImage:dPic_Public_topmenu forState:UIControlStateNormal];
    //    leftButton.backgroundColor = [UIColor redColor];
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
-(void)createUIView
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSDictionary * loginDict = [d objectForKey:UD_loginDict];
    self.petName = [loginDict objectForKey:@"petName"];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44 - 49)
                                                 style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = nil;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
}


#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}
-(UITableViewCell *)createContentCell:(NSIndexPath *)index
{
    UIView * mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 80)];
    
    UIButton * infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    infoBtn.frame =  CGRectMake(50, 15, 30, 30);
    [infoBtn setBackgroundImage:[UIImage imageNamed:@"show_info"] forState:UIControlStateNormal];
    [infoBtn setBackgroundImage:[UIImage imageNamed:@"show_info_selected"] forState:UIControlStateHighlighted];
    infoBtn.tag = index.section + MAX_TAG;
    [infoBtn addTarget:self action:@selector(warnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:infoBtn];
    
    UIButton * zan = [UIButton buttonWithType:UIButtonTypeCustom];
    zan.frame = CGRectMake(infoBtn.frame.size.width + infoBtn.frame.origin.x + 30, 15, 60, 25);
    [zan setTitle:@"赞" forState:UIControlStateNormal];
    zan.titleLabel.font = [UIFont systemFontOfSize:15];
    [zan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [zan setImage:[UIImage imageNamed:@"show_item_zan"] forState:UIControlStateNormal];
    [zan setImage:[UIImage imageNamed:@"show_item_zan1"] forState:UIControlStateHighlighted];
    zan.layer.cornerRadius = 3;
    zan.layer.borderColor = [UIColor grayColor].CGColor;
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
    remarkBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [remarkBtn setTitle:@"评论" forState:UIControlStateNormal];
    [remarkBtn setImage:[UIImage imageNamed:@"show_item_comment"] forState:UIControlStateNormal];
    [remarkBtn setImage:[UIImage imageNamed:@"show_item_comment1"] forState:UIControlStateHighlighted];
    remarkBtn.tag = index.section  + MAX_TAG;
    [remarkBtn addTarget:self action:@selector(remarkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:remarkBtn];
    
//    NSMutableArray * nameArr = [[NSMutableArray alloc]init];
    
//    NSMutableArray * temp = _zanArray[index.section];
//    
//    for (Item_zanList * item in temp) {
//        
//        [nameArr addObject:item.petName];
//    }
    
    NSArray * nameArr = [[NSArray alloc]initWithObjects:@"小武妈妈、", @"小红妈妈、", @"小李妈妈",@"小白妈妈妈妈妈妈妈妈们吗、", @"孙悟空、", nil];
    
    RichLabelView * richView = [[RichLabelView alloc]initWithFrame:CGRectMake(20, remarkBtn.frame.origin.y + remarkBtn.frame.size.height + 10, kMainScreenWidth - 40, 0) nameArr:nameArr];
    [mainView addSubview:richView];
    
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:mainView];
    
    return cell;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
       return  [self createContentCell:indexPath];
    }
    if (indexPath.row == [_momentArray[indexPath.section] count] + 1) {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"点击加载更多";
        return cell;
    }
    NSString * strID = @"ID";
    Cell_RemarkList * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        cell = [[Cell_RemarkList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    Item_RemarkList * item = [[self.momentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row - 1];
    NSString * remarkStr = [StringTool htmlString:item.petName andBString:item.content];
//    RTLabelComponentsStructure * componentDS = [RCLabel extractTextStyle:remarkStr];
//    cell.rcLabel.componentsAndPlainText = componentDS;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Item_AllWinwow * item = [_dataArray objectAtIndex:section];
    if (!item.isOpen ) {
        return 0;
    }
    if ((self.dataArray.count != self.momentArray.count)) {
        return 0;
    }
    return [self.momentArray[section] count] + 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 100;
    }
    if (indexPath.row == [_momentArray[indexPath.section] count] + 1) {
        
        return 50;
    }
    Item_RemarkList * item = _momentArray[indexPath.section][indexPath.row - 1];
    
    return [item height] + 20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*如果是点击加载更多*/
    if (indexPath.row == [_momentArray[indexPath.section] count] + 1) {
        
        Item_RemarkList * item_remark = _momentArray[0][0];
        
        if (item_remark.isButtom == 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"没有更多数据"];
            return;
        }
        
        Item_MyWindow * item = _dataArray[indexPath.section];

        NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:item.momentID,@"momentReplyQuery.momentID", nil];
        
        item.remakCount++;
//        [self httpRequestWithUrl:dUrl_DIA_1_4_2 postDict:postDict page:item.remakCount];
        [self moreRequestWithUrl:dUrl_DIA_1_4_2 postDict:postDict page:item.remakCount];
        return;
    }
    [SVProgressHUD showSimpleText:@"弹出微信键盘"];
}

-(Cell_MyWindow *)configureCellWithSection:(NSInteger)section
{
    Cell_MyWindow * cell = [[Cell_MyWindow alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.remarkBtn.tag = section + MAX_TAG;
    
    Item_MyWindow * item = [self.dataArray objectAtIndex:section];
    cell.nickNameLbl.text = self.petName;
    cell.contentLbl.text = item.content;
    
    cell.contentLbl.backgroundColor = [UIColor redColor];
    
    CGRect frame = cell.contentLbl.frame;
    
    frame.size.height = [tool sizeWithRawString:item.content constrainsToWidth:kMainScreenWidth - 40 Font:[UIFont systemFontOfSize:18]].height;
    
    cell.contentLbl.frame = frame;
    
    cell.timeLbl.text = [TimeTool getUTCFormateDate:item.time];
    
    if (item.urlArray.count!=0 && item.urlArray) {
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, cell.contentLbl.frame.origin.y + cell.contentLbl.frame.size.height, kMainScreenWidth - 40, kMainScreenWidth - 40)];
        imageView.backgroundColor = [UIColor grayColor];
        NSString * url = item.urlArray[0];
        [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        [cell addSubview:imageView];
        
        
        frame = cell.remarkBtn.frame;
        frame.origin.y = imageView.frame.origin.y + 5;
        
        cell.remarkBtn.frame = frame;
    }
    else{
        
        frame = cell.remarkBtn.frame;
        
//        frame.origin.y += cell.contentLbl.frame.origin.y + 5;
        frame.origin.y = cell.contentLbl.frame.origin.y + cell.contentLbl.frame.size.height + 5;
        
        cell.remarkBtn.frame = frame;
    }
   
    [cell.remarkBtn setTitle:[NSString stringWithFormat:@"(%d)", item.replies] forState:UIControlStateNormal];
    cell.remarkBtn.selected = item.isOpen;
    cell.remarkBtn.tag = section + MAX_TAG;
    
    [cell.remarkBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
    
}
/**瞬间列表**/
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return  [self configureCellWithSection:section];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, kMainScreenWidth, 0.01);
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    Item_MyWindow * item  = [self.dataArray objectAtIndex:section];
    if (item.urlArray.count!=0 && item.urlArray) {
        return 100 + [tool sizeWithRawString:item.content constrainsToWidth:kMainScreenWidth - 40 Font:[UIFont systemFontOfSize:18]].height;
    }
    return 100 + [tool sizeWithRawString:item.content constrainsToWidth:kMainScreenWidth - 40 Font:[UIFont systemFontOfSize:18]].height;
}


@end