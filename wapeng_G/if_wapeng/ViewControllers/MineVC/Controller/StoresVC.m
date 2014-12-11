//
//  StoresVC.m
//  if_wapeng
//
//  Created by 早上好 on 14-10-20.
//  Copyright (c) 2014年 funeral. All rights reserved.
//我   我的收藏

#import "StoresVC.h"
#import "AFN_HttpBase.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "HotTopicEntity.h"
#import "MyTopicStores.h"
#import "MyActivity.h"
#import "MyMail.h"
#import "Item_Common02.h"
#import "Item_MyMailEntity.h"
#import "UIViewController+General.h"
#import "MyTopicStoresTask.h"
#import "UIViewController+General.h"
@interface StoresVC ()
@property(nonatomic , strong)UIImageView * selectImage;
@property(nonatomic , strong)UIScrollView * scrollView;
@property(nonatomic , strong)NSMutableArray * dataSourceTopic;//话题收藏
@property(nonatomic , strong)NSMutableArray * dataSourceActivity;//活动收藏
@property(nonatomic , strong)NSMutableArray * dataSourceMail;//信件收藏
@property(nonatomic , strong)MyTopicStores * topicStores;
//话题view
@property(nonatomic , strong)MyActivity * activityStores;
//活动view
@property(nonatomic , strong)MyMail * mailStores;
//私信view

@property(nonatomic , strong)    NSString * topicPage;//话题页面数
@property(nonatomic , strong)    NSString * activityPage;//活动页面数
@property(nonatomic , strong)    NSString * mailPage;//私信页面数


@property(nonatomic , strong)UIView * searchView;


@end

@implementation StoresVC
{
    AFN_HttpBase * http;
    AppDelegate *app;
    NSString * D_ID;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"新注册用户搜素";
    }
    return self;
}
-(void)initData{
    self.dataSourceActivity = [[NSMutableArray alloc]  init];
    self.dataSourceTopic = [[NSMutableArray alloc]  init];
    self.dataSourceMail = [[NSMutableArray alloc]  init];
    http = [[AFN_HttpBase alloc]  init];
    app = [AppDelegate shareInstace];
    D_ID = [app.loginDict  objectForKey:@"d_ID"];
    self.topicPage = @"1";
}
- (void)viewWillAppear:(BOOL)animated
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
     self.view.backgroundColor = [UIColor whiteColor];
    
    [self initLeftItem];
   
    [self initData];
    [self createComponet];
}
//系统的Item方法
-(void)navItemClick:(UIButton *)button
{
    //    [self.navigationController removeFromParentViewController  ];
    [self.navigationController  popViewControllerAnimated:YES];
}
-(void)createComponet{
    
    self.searchView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    
    UIButton * btn1 = [[UIButton alloc]  initWithFrame:CGRectMake(0, 0, 320/3-1, 38)];
    btn1.tag = 0;
    //    btn1.backgroundColor = [UIColor greenColor];
    [btn1 setTitle:@"话题" forState:UIControlStateNormal ];
    [btn1  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIButton * btn2 = [[UIButton alloc]  initWithFrame:CGRectMake(320/3+1, 0, 320/3, 38)];
    [btn2 setTitle:@"活动" forState:UIControlStateNormal ];
    [btn2  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    btn2.backgroundColor = [UIColor blueColor];
    btn2.tag = 1;
    
    UIButton * btn3 = [[UIButton alloc]  initWithFrame:CGRectMake((320/3 * 2)+3, 0, 320/3, 38)];
    [btn3 setTitle:@"私信" forState:UIControlStateNormal ];
    [btn3  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    btn3.backgroundColor = [UIColor orangeColor];
    btn3.tag = 2;
    
    UIImageView * line1 = [[UIImageView alloc]  initWithFrame:CGRectMake(320/3-1, 0, 2, 38)];
    line1.backgroundColor = [UIColor grayColor];
    UIImageView * line2 = [[UIImageView alloc]  initWithFrame:CGRectMake(320/3 * 2 + 1, 0, 2, 38)];
    line2.backgroundColor = [UIColor grayColor];
    self.selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 38, 320/3 - 5, 2)];
    self.selectImage.backgroundColor = [UIColor redColor];
    [self.searchView addSubview:btn1];
    [self.searchView addSubview:btn2];
    [self.searchView addSubview:btn3];
    [self.searchView addSubview:line1];
    [self.searchView addSubview:line2];
    [self.searchView addSubview:self.selectImage];
    [self.view addSubview:self.searchView];
    [btn1  addTarget:self action:@selector(onClicklisteners:) forControlEvents:UIControlEventTouchUpInside];
    [btn2  addTarget:self action:@selector(onClicklisteners:) forControlEvents:UIControlEventTouchUpInside];
    [btn3  addTarget:self action:@selector(onClicklisteners:) forControlEvents:UIControlEventTouchUpInside];
    [self createScrollView];
}

-(void)createScrollView{
    self.scrollView = [[UIScrollView alloc]  initWithFrame:CGRectMake(0, self.searchView.frame.size.height,self.view.frame.size.width, self.view.frame.size.height- self.searchView.frame.size.height  - 64)];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height- self.searchView.frame.size.height - 64  -49);
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //    作用：决定了子视图的显示范围。具体的说，就是当取值为YES时，剪裁超出父视图范围的子视图部分；当取值为NO时，不剪裁子视图（超出部分继续显示，例如在scrollview中。。。）。默认值为NO。
    self.scrollView.clipsToBounds = YES;
    self.scrollView.pagingEnabled = YES;//页面翻动
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.directionalLockEnabled = YES;
    
    self.scrollView.scrollEnabled = NO;
    
    //    self.scrollView.showsHorizontalScrollIndicator = NO;
    //    self.scrollView.showsVerticalScrollIndicator = NO;
    
    //   当用户抵达滚动区域边缘时，这个功能允许用户稍微拖动到边界外一点。当用户松开手指后，这个区域会像个橡皮筋一样，弹回到原位，给用户一个可见的提示，表示他已经到达了文档开始或结束位置。如果不想让用户的滚动范围能够超出可见内容，可以将这个属性设置为NO。
    self.scrollView.bounces = NO;
    [self.view  addSubview:self.scrollView];
    [self scrollViewSetContent];
}
-(void)scrollViewSetContent{
    //话题view
    self.topicStores = [[MyTopicStores alloc]  initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , self.view.frame.size.height - self.searchView.frame.size.height - 64 - 49)];
    
    __weak StoresVC * weakSelf = self;
    [self.topicStores.tableView setupRefresh];
    [self.topicStores.tableView addTableRefreshView];
    self.topicStores.tableView.headerBlock = ^{
        weakSelf.topicPage = @"1";
        [weakSelf.dataSourceTopic  removeAllObjects];
        [weakSelf  requestMyTopicStoresData];
        
    };
    self.topicStores.tableView.footBlock = ^{
        int num = [weakSelf.topicPage intValue];
        num++;
        weakSelf.topicPage = [NSString stringWithFormat:@"%d",num];
        [weakSelf  requestMyTopicStoresData];
    };
    
    [self.scrollView  addSubview:self.topicStores];
    
    
    //活动view
    self.activityStores = [[MyActivity alloc]  initWithFrame:CGRectMake(self.view.frame.size.width, 0,self.view.frame.size.width , self.view.frame.size.height - self.searchView.frame.size.height - 64 - 49)];
    
    [self.activityStores.tableView setupRefresh];
    self.activityStores.tableView.headerBlock = ^{
        weakSelf.activityPage = @"1";
        [weakSelf.dataSourceActivity  removeAllObjects];
        [weakSelf  requestMyActivitySourceData];
    };
    self.activityStores.tableView.footBlock = ^{
        int num = [weakSelf.activityPage intValue];
        num++;
        weakSelf.activityPage = [NSString stringWithFormat:@"%d",num];
        [weakSelf  requestMyActivitySourceData];
    };
    
    [self.scrollView  addSubview:self.activityStores];
    
    //私信view
    self.mailStores = [[MyMail alloc]  initWithFrame:CGRectMake(self.view.frame.size.width*2, 0,self.view.frame.size.width , self.view.frame.size.height - self.searchView.frame.size.height - 64 - 49)];
    [self.mailStores.tableView  setupRefresh];
    self.mailStores.tableView.headerBlock = ^{
        weakSelf.mailPage = @"1";
        [weakSelf.dataSourceMail  removeAllObjects];
        [weakSelf  requestMyMailStoresData];
    };
    self.mailStores.tableView.footBlock = ^{
        int num = [weakSelf.mailPage intValue];
        num++;
        weakSelf.mailPage = [NSString stringWithFormat:@"%d",num];
        [weakSelf  requestMyMailStoresData];
    };
    [self.scrollView  addSubview:self.mailStores];
    
}
//我的话题收藏的参数
-(NSMutableDictionary*)setParamMyStoresForTopic
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic  setValue:D_ID forKey:@"D_ID"];
    [dic setValue:self.topicPage forKey:@"topicStoreQuery.pageNum"];
    return dic;
}
//我的活动收藏的参数
-(NSMutableDictionary*)setParamMyStoresForActivity
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]  init];
    [dic  setValue:D_ID forKey:@"D_ID"];
    [dic setValue:self.activityPage forKey:@"activityStoreQuery.pageNum"];
    return dic;
}
//我的私信收藏的参数
-(NSMutableDictionary*)setParamMyStoresForLetter
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]  init];
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    //@"cf4037bf-0c53-4703-ac29-925b58eb8429"
    [dic  setValue:ddid forKey:@"D_ID"];
    [dic setValue:self.mailPage
           forKey:@"letterStoreQuery.pageNum"];
    return dic;
}

//我的话题收藏
-(void)requestMyTopicStoresData{
    NSLog(@"requestMyTopicStoresData");
    StoresVC * weekSelf = self;
    [http  sixReuqestUrl:TOP_1_7_2 postDict:[self setParamMyStoresForTopic] succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        NSDictionary * dic = (NSDictionary *)obj;
        NSMutableArray * array;
        NSDictionary * value = [dic objectForKey:@"value"];
        if ([value isKindOfClass:[NSNull class]]) {
            [SVProgressHUD showSimpleText:@"没有数据"];
            [self.activityStores.tableView headerEndRefreshing];
            [self.topicStores.tableView headerEndRefreshing];
            [self.mailStores.tableView headerEndRefreshing];
            return ;
        }
        array = [value objectForKey:@"list"];
        for (int i = 0; i < 2 ; i++) {
            NSDictionary * d = [array  objectAtIndex:i];
            NSDictionary * topic = [d objectForKey:@"topic"];
            NSString * content = [topic objectForKey:@"content"];
            NSString * replies = [NSString stringWithFormat:@"%@",[topic objectForKey:@"replies"]];
            NSString * friendPartInCount = [NSString stringWithFormat:@"%@",[topic objectForKey:@"viewFriendPartInCount"]];
            NSString * title = [topic objectForKey:@"title"];
            NSString * _id = [topic objectForKey:@"id"];
            NSString * createTime = [topic objectForKey:@"createTime"];
            HotTopicEntity * hotTop = [[HotTopicEntity alloc] init];
            if ([@"<null>" isEqualToString:friendPartInCount]||[@"(null)" isEqualToString:friendPartInCount]) {
                friendPartInCount = @"0";
            }
            hotTop._id = _id;
            hotTop.reply = replies;
            hotTop.person =friendPartInCount;
            hotTop.content = content;
            hotTop.name = title;
            hotTop.createTime = createTime;
            [weekSelf.dataSourceTopic addObject:hotTop];
        }
        [self.topicStores setLoadData:weekSelf.dataSourceTopic];
    } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        [self.activityStores.tableView headerEndRefreshing];
        [self.topicStores.tableView headerEndRefreshing];
        [self.mailStores.tableView headerEndRefreshing];
    }];
}
//我的活动请求请求
-(void)requestMyActivitySourceData{
    NSLog(@"requestMyActivitySourceData");

    StoresVC * weakSelf = self;
    [weakSelf.dataSourceActivity removeAllObjects];
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    [http thirdRequestWithUrl:ACT_1_6_2 succeed:^(NSObject *obj, BOOL isFinished) {
        NSDictionary * resultDic=(NSDictionary *)obj;
        
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSimpleText:@""];
    } andKeyValuePairs:@"D_ID",ddid,@"activityStoreQuery.pageNum",@"1", nil];
    for (int i = 0; i<3; i++) {
        Item_Common02 * item = [[Item_Common02 alloc]init];
        item.content = @"content";
        item.replies = @"replies";
        item.petName = @"petName";
        item.viewFriendPartInCount = @"viewFriendPartInCount";
        item.relativePath = @"photo";
        [weakSelf.dataSourceActivity addObject:item];
    }
    [weakSelf.activityStores setLoadData:weakSelf.dataSourceActivity];
    //    [http  sixReuqestUrl:ACT_1_6_2 postDict:[self setParamMyStoresForActivity] succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
    //        NSDictionary * root = (NSDictionary *)obj;
    //        NSDictionary * value = [root objectForKey:@"value"];
    //        if ((NSNull *)value == [NSNull null]) {
    //            [weakSelf.activityStores  setLoadData:weakSelf.dataSourceActivity];
    //            return ;
    //        }
    //        for (NSDictionary * dict in value) {
    //            Item_Common02 * item = [[Item_Common02 alloc]init];
    //            item.content = [dict objectForKey:@"content"];
    //            item.replies = [NSString stringWithFormat:@"回复数:%@", [dict objectForKey:@"replies"]];
    //            item.petName = [[dict objectForKey:@"author"] objectForKey:@"petName"];
    //            item.viewFriendPartInCount = [NSString stringWithFormat:@"%@位熟人参与", [dict objectForKey:@"viewFriendPartInCount"]];
    //            item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, [[[dict objectForKey:@"author"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
    //            [weakSelf.dataSourceActivity addObject:item];
    //        }
    //        [weakSelf.activityStores setLoadData:weakSelf.dataSourceActivity];
    //    } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
    //
    //    }];
}

//我的私信收藏
-(void)requestMyMailStoresData{
    NSLog(@"requestMyMailStoresData");

    StoresVC * weekSelf = self;
    [weekSelf.dataSourceMail removeAllObjects];
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    [http thirdRequestWithUrl:P2P_1_2_2 succeed:^(NSObject *obj, BOOL isFinished) {
        NSDictionary * resultDic=(NSDictionary *)obj;
        NSDictionary *value = [resultDic  objectForKey:@"value"];
        NSArray * array = [value objectForKey:@"list"];
        for (int i = 0; i < array.count; i++) {
            NSDictionary * d = [array  objectAtIndex:i];
            NSString * content =[d objectForKey:@"content"];
            NSString * name=[[d objectForKey:@"senderID"]objectForKey:@"petName"];
            Item_MyMailEntity * mailEntity = [[Item_MyMailEntity alloc] init];
//            mailEntity._id = _id;
//            mailEntity.content = content;
//            mailEntity.name = name;
//            mailEntity.photoURL=[NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, [[[d objectForKey:@"senderID"] objectForKey:@"photo"] objectForKey:@"relativePath"]];;
            [weekSelf.dataSourceMail addObject:mailEntity];
        }
        [self.activityStores.tableView headerEndRefreshing];
        [self.topicStores.tableView headerEndRefreshing];
        [self.mailStores.tableView headerEndRefreshing];
        [self.mailStores setLoadData:weekSelf.dataSourceMail];
    } failed:^(NSObject *obj, BOOL isFinished) {
       
    } andKeyValuePairs:@"D_ID",ddid,@"letterStoreQuery.pageNum", @"1",nil];
/*
    for (int i = 0; i < 5; i++) {
        NSString * content = @"content";
        NSString * title = @"title";
        NSString * _id = @"id";
        Item_MyMailEntity * mailEntity = [[Item_MyMailEntity alloc] init];
        mailEntity._id = _id;
        mailEntity.content = content;
        mailEntity.name = title;
        [weekSelf.dataSourceMail addObject:mailEntity];
    }
    [self.mailStores setLoadData:weekSelf.dataSourceMail];
*/
    /*
     [http  sixReuqestUrl:P2P_1_2_1 postDict:[self setParamMyStoresForLetter] succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
     NSDictionary * dic = (NSDictionary *)obj;
     NSMutableArray * array;
     NSDictionary * value = [dic objectForKey:@"value"];
     array = [value objectForKey:@"list"];
     for (int i = 0; i < array.count; i++) {
     NSDictionary * d = [array  objectAtIndex:i];
     NSString * content = [d objectForKey:@"content"];
     NSString * title = [d objectForKey:@"title"];
     NSString * _id = [d objectForKey:@"id"];
     Item_MyMailEntity * mailEntity = [[Item_MyMailEntity alloc] init];
     mailEntity._id = _id;
     mailEntity.content = content;
     mailEntity.name = title;
     [weekSelf.dataSourceMail addObject:mailEntity];
     }
     [self.mailStores setLoadData:weekSelf.dataSourceMail];
     } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
     
     }];
     */
}

-(void)onClicklisteners:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.selectImage.transform = CGAffineTransformMakeTranslation(1, 0);
            }];
            [self scrollRectToVisibleWithType:0];
            if (self.dataSourceTopic.count <=0) {
                [self.topicStores.tableView addTableRefreshView];
            }
        }
            break;
        case 1:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.selectImage.transform = CGAffineTransformMakeTranslation(320/3 +1, 0);
            }];
            [self scrollRectToVisibleWithType:1];
            if (self.dataSourceActivity.count <= 0) {
                [self.activityStores.tableView addTableRefreshView];
            }
            break;
        }
            
        case 2:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.selectImage.transform = CGAffineTransformMakeTranslation(320/3 *2+2, 0);
            }];
            [self scrollRectToVisibleWithType:2];
            if (self.dataSourceMail.count <= 0) {
                [self.mailStores.tableView addTableRefreshView];
            }
        }
            break;
            
        default:
            break;
    }
}
/*** srcollview 展示那个item ***/
-(void)scrollRectToVisibleWithType:(int)type{
    switch (type) {
        case 0:
        {
            CGSize viewSize = self.scrollView.frame.size;
            CGRect rect = CGRectMake(0, 0, viewSize.width, viewSize.height);
            [self.scrollView scrollRectToVisible:rect animated:YES];
        }
            break;
        case 1:
        {
            CGSize viewSize = self.scrollView.frame.size;
            CGRect rect = CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
            [self.scrollView scrollRectToVisible:rect animated:YES];
        }
            break;
        case 2:
        {
            CGSize viewSize = self.scrollView.frame.size;
            CGRect rect = CGRectMake(viewSize.width*2, 0, viewSize.width, viewSize.height);
            [self.scrollView scrollRectToVisible:rect animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)showWithStatus {
	[SVProgressHUD showWithStatus:@"正在加载……"];
}

- (void)dismiss {
	[SVProgressHUD dismiss];
}

@end
