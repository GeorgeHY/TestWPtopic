//
//  AllShowWindowVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
#define dRefresh 1
#define dMore    2
#import "AllShowWindowVC.h"
#import "Cell_AllMyShowWindow.h"
//#import "InterfaceLibrary.h"
#import "Item_AllWinwow.h"
#import "UIViewController+MMDrawerController.h"
#import "UIView+WhenTappedBlocks.h"
#import "AppDelegate.h"
#import "Item_AllWinwow.h"
#import "Item_MyWindow.h"
#import "Item_userInfo.h"
#import "Item_AllShowWindow.h"
#import "UIImageView+WebCache.h"
#import "SVPullToRefresh.h"
@interface AllShowWindowVC ()
{
}
@property (nonatomic, assign) int currentPage;//当前页码
@property (nonatomic, strong) NSString * isButtom;
@property (nonatomic, strong) Item_userInfo * item_userInfo;
@property (nonatomic, assign) int current;//当前页码
@property (nonatomic, assign) int refreshType;
@property (nonatomic, assign) int totalCount;//总页数
@end

@implementation AllShowWindowVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
        _dataArray = [[NSMutableArray alloc]init];
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
    self.currentPage = 1;
//    _dataArray = [[InterfaceLibrary shareInterfaceLibrary] interfaceAllWinwow];
    
    [self createNavItem];
    
    [self createUIView];
    
}
//橱窗标题的接口
-(void)startWindowTitleRequest
{
    NSLog(@"%@", self.userInfoID);
//    _item_userInfo.item_userInfo = [[Item_userInfo alloc]init];
    
    AFN_HttpBase * afn = [[AFN_HttpBase alloc]init];
    
    
    [afn thirdRequestWithUrl:dUrl_DIA_1_6_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * dict = (NSDictionary *)obj;
        
        NSDictionary * tempDict = [dict objectForKey:@"value"];
        
        _item_userInfo.name =  [tempDict objectForKey:@"name"];
        
        NSDictionary * userInfoDict = [tempDict objectForKey:@"userInfo"];
        
        _item_userInfo.petName = [NSString stringWithFormat:@"%@", [userInfoDict objectForKey:@"petName"]];
        
        _item_userInfo.photoUrl = [NSString stringWithFormat:@"http://115.100.250.35:8080/wpa/wb/wpub/imgAction_img.action?A_ID=%@", [userInfoDict objectForKey:@"photoURL"]];
        
        _item_userInfo.loacted = [[userInfoDict objectForKey:@"userInfoExtension"] objectForKey:@"located"];
        _item_userInfo.wpCode = [NSString stringWithFormat:@"%@", [userInfoDict objectForKey:@"wpCode"]];
        
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID", self.ddID, @"windowQuery.userInfoID", self.userInfoID, nil];
    
}

//橱窗全部
-(void)startHttpRequest2WithPageNum:(int)pageNum;
{
//    [_tableView beginUpdates];
    NSString * newPageNum = [NSString stringWithFormat:@"%d", pageNum];
    NSLog(@"ddid is :%@", self.ddID);
    
    AFN_HttpBase * afn = [[AFN_HttpBase alloc]init];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:self.ddID, @"D_ID",newPageNum , @"momentQuery.pageNum", nil];
    __weak AllShowWindowVC * weakSelf = self;
    [afn fiveReuqestUrl:dUrl_DIA_1_1_1 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        //为了防止内存警告，这里不做优化了
//        if (self.refreshType == dRefresh) {
//            [weakSelf.dataArray removeAllObjects];
// 
//        }
        [weakSelf.dataArray removeAllObjects];
        NSDictionary * dict = (NSDictionary *)obj;
        NSDictionary * value = [dict objectForKey:@"value"];
#warning 注释了出错代码
//        self.totalCount = [[value objectForKey:@"end"] integerValue];
//        NSArray * list = [value objectForKey:@"list"];
//        
//        for (NSDictionary * dict in list) {
//            
//            Item_AllShowWindow * item = [[Item_AllShowWindow alloc]init];
//            item.isOpen = NO;
//            item.age = [NSString stringWithFormat:@"%@", [dict objectForKey:@"age"]];
//            item.createTime= [NSString stringWithFormat:@"%@", [dict objectForKey:@"createTime"]];
//            item.petName = [NSString stringWithFormat:@"%@", [[dict objectForKey:@"author"] objectForKey:@"petName"]];
//            item.photoURL = [NSString stringWithFormat:@"http://115.100.250.35:8080/wpa/wb/wpub/imgAction_img.action?A_ID=%@", [[dict objectForKey:@"author"] objectForKey:@"photoURL"]];
//            item.content = [NSString stringWithFormat:@"%@", [dict objectForKey:@"content"]];
//            item.gender = [NSString stringWithFormat:@"%@", [[dict objectForKey:@"childInfo"] objectForKey:@"gender"]];
//            
//            
//            NSArray * diaArr = [dict objectForKey:@"diaBodyAttachmentList"];
//            
//            NSLog(@"%@", diaArr);
//
//            if ([diaArr isKindOfClass:[NSNull class]] || diaArr.count== 0) {
//                continue;
//            }
//            for (NSDictionary * dic in diaArr) {
//                
//                NSString * url   = [NSString stringWithFormat:@"http://115.100.250.35:8080/wpa/wb/wpub/imgAction_img.action?A_ID=%@", [[dic objectForKey:@"attachment"] objectForKey:@"relativePath"]];
//                
//                [item.urlArray addObject:url];
//            }
//            
//            [weakSelf.dataArray addObject:item];
//        }
        
        [weakSelf.tableView reloadData];
        
        if (self.refreshType == dRefresh) {
            
           [weakSelf.tableView.pullToRefreshView stopAnimating];
            
        }
        if (self.refreshType == dMore) {
            
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            
        }

//        6         //结束更新
//        67         [_tableView endUpdates];
//        68
//        69         //停止菊花
//        70         [_tableView.pullToRefreshView stopAnimating];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    }];
}

//发表
-(void)rightItemClick
{
}
-(void)leftItemClick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
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

-(void)createUIView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 49 - 44)
                      style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = nil;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    /*如果不是橱窗全部页面，那么应该有headerView*/
    
// //   [self createShowWindowHeaderWithType:1];
//    if (self.type != VCTYpe_total) {
//        switch (self.type) {
//            case VCType_agent_mine:
//            {
//                [self createPublicNumViewWithType:0];
//            }
//                break;
//            case VCType_agent_other:
//            {
//                [self createPublicNumViewWithType:1];
//            }
//                break;
//            case VCType_mine:
//            {
//                [self createShowWindowHeaderWithType:0];
//            }
//                break;
//            case VCType_onter:
//            {
//                [self createShowWindowHeaderWithType:1];
//            }
//                break;
//            default:
//                break;
//        }
//    }

}
//暂时不动 
/*我的橱窗公号和别人的橱窗公号的View*/
-(void)createPublicNumViewWithType:(int)type
{
    //我的橱窗公号
    UIView * publicNumView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 285)];
    UIImageView * headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20, 60, 60)];
    headImageView.image = [UIImage imageNamed:@"saga2.jpg"];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.borderWidth = 1;
    headImageView.layer.cornerRadius = 3;
    [publicNumView addSubview:headImageView];
    
    UILabel * agentLabel = [[UILabel alloc]initWithFrame:CGRectMake(headImageView.frame.origin.x + headImageView.frame.size.height + 5, headImageView.frame.origin.y, 200, 30)];
    agentLabel.backgroundColor = [UIColor yellowColor];
    agentLabel.text = @"海景幼儿园";
    [publicNumView addSubview:agentLabel];
    
    UILabel *detailLbl = [[UILabel alloc]initWithFrame:CGRectMake(agentLabel.frame.origin.x, agentLabel.frame.origin.y + agentLabel.frame.size.height + 5 , 200, 30)];
    //    detailLbl.backgroundColor = [UIColor greenColor];
    detailLbl.text = @"娃朋 423u23ur";
    [publicNumView addSubview:detailLbl];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(detailLbl.frame.origin.x, detailLbl.frame.origin.y + detailLbl.frame.size.height + 5, 25, 20)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:@"saga2.jpg"];
    [publicNumView addSubview:imageView];
    
    UILabel * locationLbl = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + 30, detailLbl.frame.origin.y + detailLbl.frame.size.height + 5, 200, 30)];
    locationLbl.font = [UIFont systemFontOfSize:12];
    locationLbl.textColor = [UIColor blueColor];
    locationLbl.text = @"西青区赛达大道华科九路132";
    
    [publicNumView addSubview:locationLbl];
    
    UILabel * agentNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, locationLbl.frame.size.height + locationLbl.frame.origin.y, 310, 40)];
    agentNameLbl.text = @"认证机构全称";
    agentNameLbl.font = [UIFont systemFontOfSize:15];
    
    [publicNumView addSubview:agentNameLbl];
    
    UILabel * introLbl = [[UILabel alloc]init];
    introLbl.text = @"简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介";
    introLbl.numberOfLines = 2;
    introLbl.lineBreakMode = NSLineBreakByCharWrapping;
    introLbl.frame = CGRectMake(5, agentNameLbl.frame.origin.y + agentNameLbl.frame.size.height + 5, 300, 44);
    introLbl.font = [UIFont systemFontOfSize:13.5];
    introLbl.textColor = [UIColor grayColor];
    [publicNumView addSubview:introLbl];
    
    UIView * bView = [[UIView alloc]initWithFrame:CGRectMake(0, introLbl.frame.origin.y + introLbl.frame.size.height, kMainScreenWidth, 0)];
    if (type == 1) {
        NSLog(@"有bView");
        bView.frame = CGRectMake(0, introLbl.frame.origin.y + introLbl.frame.size.height, kMainScreenWidth, 50);
        
        NSArray * name = @[@"发私信", @"已关注", @"更多"];
        for (int i = 0; i < 3; i++) {
            
            UIView * containerView = [[UIView alloc]initWithFrame:CGRectMake(20 + 100 * i, 10, 80, 40)];
            containerView.backgroundColor = [UIColor redColor];
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
            imgView.image = [UIImage imageNamed:@"saga2.jpg"];
            [containerView addSubview:imgView];
            
            UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 50, 30)];
            lbl.font = [UIFont systemFontOfSize:13.5];
            lbl.text = name[i];
            [containerView addSubview:lbl];
            
            [bView addSubview:containerView];
        }
        //增加view1的高度
        CGRect frame = publicNumView.frame;
        frame.size.height += 50;
        publicNumView.frame = frame;
    }
    [publicNumView addSubview:bView];
    
    UIView * line = [[UIView alloc]init];
    line.frame = CGRectMake(0, bView.frame.size.height + bView.frame.origin.y + 5, kMainScreenWidth, 1);
    line.backgroundColor = [UIColor grayColor];
    
    [publicNumView addSubview:line];
    //瞬间，关注，粉丝
    UIView * view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(0, line.frame.origin.y + line.frame.size.height, kMainScreenWidth, 60);
    view1.backgroundColor = [UIColor purpleColor];
    [publicNumView addSubview:view1];
    
    NSArray * name = @[@"瞬间", @"关注", @"粉丝"];
    NSArray * count =@[@"25", @"123", @"23", @"23"];
    for (int i = 0; i < 3; i++) {
        
        UILabel * countLbl = [[UILabel alloc]init];
        countLbl.frame = CGRectMake(kMainScreenWidth / 3.0 * i, 5, kMainScreenWidth / 3.0, 25);
        countLbl.textAlignment = NSTextAlignmentCenter;
        countLbl.text = count[i];
        [view1 addSubview:countLbl];
        
        UILabel * nameLbl = [[UILabel alloc]init];
        nameLbl.frame = CGRectMake(kMainScreenWidth / 3.0 * i, 30, kMainScreenWidth/ 3.0, 30);
        nameLbl.text = name[i];
        nameLbl.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:nameLbl];
        
    }
    self.tableView.tableHeaderView = publicNumView;
}
/*
 我的橱窗和别人的橱窗
 */
-(void)createShowWindowHeaderWithType:(int)type
{
    
    UIView * view1 = [[UIView alloc]init];
    view1.frame = CGRectMake(0, 0, kMainScreenWidth, 160);
    
    UIImageView * headImageView = [[UIImageView alloc]init];
    headImageView.frame = CGRectMake(5, 20, 60, 60);
    headImageView.image = [UIImage imageNamed:@"saga.jpg"];
    [headImageView setImageWithURL:[NSURL URLWithString:self.item_userInfo.photoUrl]];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 3;
    headImageView.layer.borderWidth = 1;
    [view1 addSubview:headImageView];
    
    UILabel * nameLbl = [[UILabel alloc]init];
    nameLbl.frame = CGRectMake(headImageView.frame.origin.x + headImageView.frame.size.width + 5, 20, 200, 30);
    nameLbl.text = @"小武妈妈";
    nameLbl.text = self.item_userInfo.petName;
    [view1 addSubview:nameLbl];
    
    UIImageView * gengerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(nameLbl.frame.origin.x, nameLbl.frame.size.height + nameLbl.frame.origin.y + 5 , 20, 20)];
    gengerImgView.image = [UIImage imageNamed:@"saga2.jpg"];
    [view1 addSubview:gengerImgView];
    
    UILabel * ageLbl = [[UILabel alloc]initWithFrame:CGRectMake(headImageView.frame.origin.x + headImageView.frame.size.width + 5 + 20,nameLbl.frame.size.height + nameLbl.frame.origin.y + 5 , 30, 20)];
    ageLbl.text = @"2岁";
    ageLbl.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:ageLbl];
    
    UILabel * locatonLbl = [[UILabel alloc]initWithFrame:CGRectMake(ageLbl.frame.origin.x + 40, nameLbl.frame.size.height + nameLbl.frame.origin.y + 5, 100, 20)];
    locatonLbl.text = @"北京昌平";
    locatonLbl.textColor = [UIColor blueColor];
    [view1 addSubview:locatonLbl];
    
    //高度<#CGFloat width#>暂时设置成为0
    UIView * bView = [[UIView alloc]initWithFrame:CGRectMake(0, locatonLbl.frame.origin.y + locatonLbl.frame.size.height+ 20, kMainScreenWidth, 0)];
    if (type == 1) {
        NSLog(@"有bView");
        bView.frame = CGRectMake(0, locatonLbl.frame.origin.y + locatonLbl.frame.size.height + 20, kMainScreenWidth, 50);
        
        NSArray * name = @[@"发私信", @"已关注", @"更多"];
        for (int i = 0; i < 3; i++) {
            
            UIView * containerView = [[UIView alloc]initWithFrame:CGRectMake(20 + 100 * i, 10, 80, 40)];
            containerView.backgroundColor = [UIColor redColor];
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
            imgView.image = [UIImage imageNamed:@"saga2.jpg"];
            [containerView addSubview:imgView];
            
            UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 50, 30)];
            lbl.font = [UIFont systemFontOfSize:13.5];
            lbl.text = name[i];
            [containerView addSubview:lbl];
            
            [bView addSubview:containerView];
        }
        //增加view1的高度
        CGRect frame = view1.frame;
        frame.size.height += 50;
        view1.frame = frame;
    }
    [view1 addSubview:bView];
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, bView.frame.size.height + bView.frame.origin.y + 5, kMainScreenWidth, 1)];
    line.backgroundColor = [UIColor grayColor];
    [view1 addSubview:line];
    
    
    
    /*
     这个view是瞬间，关注，粉丝的组合
     */
    UIView *  aView = [[UIView alloc]initWithFrame:CGRectMake(0, line.frame.origin.y + line.frame.size.height, kMainScreenWidth, 60)];
    aView.backgroundColor = [UIColor greenColor];
    
    [view1 addSubview:aView];
    
    NSArray * name = @[@"瞬间", @"关注", @"粉丝"];
    NSArray * count =@[@"25", @"123", @"23", @"23"];
    for (int i = 0; i < 3; i++) {
        
        UILabel * countLbl = [[UILabel alloc]init];
        countLbl.frame = CGRectMake(kMainScreenWidth / 3.0 * i, 5, kMainScreenWidth / 3.0, 25);
        countLbl.textAlignment = NSTextAlignmentCenter;
        countLbl.text = count[i];
        [aView addSubview:countLbl];
        
        UILabel * nameLbl = [[UILabel alloc]init];
        nameLbl.frame = CGRectMake(kMainScreenWidth / 3.0 * i, 30, kMainScreenWidth/ 3.0, 30);
        nameLbl.text = name[i];
        nameLbl.textAlignment = NSTextAlignmentCenter;
        [aView addSubview:nameLbl];
    }
    
    self.tableView.tableHeaderView = view1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * strID = @"ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    cell.textLabel.text = @"2";
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    Cell_AllMyShowWindow * cell = [[Cell_AllMyShowWindow alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.remarkBtn.tag = 1000 + section;
    
    Item_AllShowWindow * item = [self.dataArray objectAtIndex:section];
    NSLog(@"%@", item.photoURL);
    NSURL * url = [NSURL URLWithString:item.photoURL];
    [cell.headImageView setImageWithURL:url placeholderImage:nil];
    cell.contentLbl.text = item.content;
    cell.nickNameLbl.text = item.petName;
    cell.timeLbl.text = item.createTime;
    cell.genderImageView.image = nil;
    
//    [cell.imageScrollView imageUrlArray:item.urlArray];
    
    CGRect frame = cell.contentLbl.frame;
    frame.size.height = [item heightWithWidth:kMainScreenWidth - 60 Size:14];
    cell.contentLbl.frame = frame;
    cell.imageScrollView.frame = CGRectMake(cell.contentLbl.frame.origin.y, cell.contentLbl.frame.origin.y + cell.contentLbl.frame.size.height,kMainScreenWidth - 100, kMainScreenWidth - 100);

    cell.imageScrollView.backgroundColor = [UIColor purpleColor];
//    [cell.imageScrollView imageUrlArray:item.urlArray];
    cell.remarkImageView.frame = CGRectMake(cell.imageScrollView.frame.origin.x + cell.imageScrollView.frame.size.width - 80, cell.imageScrollView.frame.origin.y + cell.imageScrollView.frame.size.height + 5, 25, 25);
    cell.remarkImageView.image = dPic_zan;
    
    cell.remarkBtn.frame = CGRectMake(cell.imageScrollView.frame.origin.x + cell.imageScrollView.frame.size.width - 50, cell.imageScrollView.frame.origin.y + cell.imageScrollView.frame.size.height + 5, 25, 25);
    
    cell.babyAgeLbl.text = [NSString stringWithFormat:@"%@岁", item.age];
    
    switch (item.gender.integerValue) {
        case 1:
        {
            NSLog(@"男孩");
            cell.genderImageView.image = [UIImage imageNamed:@"gender_1"];
        }
            break;
        case 2:
        {
            NSLog(@"女孩");
            cell.genderImageView.image = [UIImage imageNamed:@"gender_2"];
        }
        default:
            break;
    }
    [cell.remarkBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
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
    Item_AllShowWindow * item  = [self.dataArray objectAtIndex:section];
    
    return 350 + [item  heightWithWidth:kMainScreenWidth - 60 Size:14];
}
-(void)btnClick:(UIButton *)button
{
    Item_AllShowWindow * item = _dataArray[button.tag - 1000];
    item.isOpen = !item.isOpen;
    
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Item_AllShowWindow * item = [_dataArray objectAtIndex:section];
    if (!item.isOpen) {
        return 0;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}
@end
