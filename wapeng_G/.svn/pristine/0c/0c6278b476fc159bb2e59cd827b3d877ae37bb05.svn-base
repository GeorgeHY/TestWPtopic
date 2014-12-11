//
//  AnnouncementAllVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

//分类话题
#define dTag_leftBtn 100
#define dTag_rightBtn 101
#define dTag_searchText 102
#import "AnnouncementAllVC.h"
#import "HotTopicEntity.h"
#import "HotTopicTVCell.h"
#import "WaterfallView.h"
#import "Item_AnnAllWaterfall.h"
#import "UIViewController+MMDrawerController.h"
#import "UIViewController+General.h"
#import "AnnAllWaterfalllCell.h"
#import "AgeTalkView.h"
#import "HotTopicViewController.h"
#import "AFN_HttpBase.h"
#import "AppDelegate.h"
#import "TimeTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
@interface AnnouncementAllVC (){
    AFN_HttpBase * http;
    NSString *D_ID;
    MBProgressHUD * loading;
}
@property(nonatomic , retain) UIButton * leftBtn;
@property(nonatomic , retain) UIButton * rightBtn;
@property(nonatomic , retain) NSMutableArray * dataSource;
@property(nonatomic , retain) WaterfallView * waterfallView;
@property(nonatomic , retain) AgeTalkView * talk;
@property(nonatomic , retain) HMSegmentedControl * segmented;

//@property(nonatomic , retain) UIView * mainV;
@end

@implementation AnnouncementAllVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"分类话题";
        http = [[AFN_HttpBase alloc]  init];
        self.dataSource = [[NSMutableArray alloc]  init];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

//返回
-(void)leftButtonOnClick:(UIButton*)btn{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightButtonOnClick:(UIButton*)btn
{
    //    [self.navigationController popViewControllerAnimated:YES];
}

-(void)debugDataLoad{
    for (int i = 0; i<=10; i++) {
        Item_AnnAllWaterfall * annAll = [[Item_AnnAllWaterfall  alloc]  init];
        NSString * s = [NSString stringWithFormat:@"%@%d",@"名字名字打算打打打打四大四大四大啊飒飒大师的哈否",i];
        annAll.content = s;
        if (i%2 == 0) {
            annAll.imageParh = @"baby_w_r.png";
        }else{
            annAll.imageParh = @"1.png";
        }
        annAll.msgCount = @"aa";
        annAll.title  =@"aadd";
        annAll.time = @"dsdff";
        
        annAll.heartCount = @"aasddf";
        [self.dataSource addObject:annAll];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self  debugDataLoad];
    AppDelegate * app = [AppDelegate shareInstace];
    D_ID = [app.loginDict  objectForKey:@"d_ID"];
    [self  createComponent];
    //    [self requsetData];
    [self createNavigation:[UIColor greenColor]];
}

//抽屉
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

//设置自己的所有标签的参数
-(NSMutableDictionary * )setParamLabelsData{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]  init];
    [param  setValue:D_ID forKey:@"D_ID"];
    return param;
}
-(void)requsetData{
    [self showLoading];
    __weak AnnouncementAllVC * weakSelf = self;
    [http  sixReuqestUrl:TOP_1_3_1 postDict:[self setParamLabelsData] succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        NSDictionary *dic = (NSDictionary *)obj;
        NSArray * array = [dic  objectForKey:@"value"];
        if (nil == array || array.count <= 0) {
            return ;
        }
        for (int j = 0; j<array.count; j++) {
            Item_AnnAllWaterfall * item = [[Item_AnnAllWaterfall alloc]  init];
            NSDictionary * d = [array objectAtIndex:j];
            NSString *name = [d objectForKey:@"name"];
            NSString * _id = [d objectForKey:@"id"];
            _id = @"3e913180-8389-417b-84cd-f2dfc2d7c9ec";
            //            NSLog(@"---第一-- %@---%@",name,_id);
            [weakSelf requestLabelDetailsDataWithLableId:_id titleName:name  returnBlack:^(NSDictionary *dicDetails , id titleName) {
                NSDictionary * value = [dicDetails  objectForKey:@"value"];
                NSArray * list = [value  objectForKey:@"list"];
                
                if ((NSNull *)value == [NSNull null] ||(NSNull *)list == [NSNull null]) {
                    if (j == array.count-1) {
                        [weakSelf disMissLoading];
                    }
                    return;
                }
                
                
                NSDictionary * tempDic = [list  objectAtIndex:0];
                NSString * time = [TimeTool  getUTCFormateDate:[tempDic objectForKey:@"createTime"]];
                NSString * content  = [tempDic  objectForKey:@"content"];
                NSString * replies = [tempDic  objectForKey:@"replies"];
                NSString * viewReportFlag = [tempDic  objectForKey:@"viewReportFlag"];
                item.title = (NSString*)titleName;
                item.time = time;
                item.content = content;
                NSLog(@"---- %@",content);
                item.heartCount = [NSString stringWithFormat:@"%@",replies];
                item.imageParh = @"baby_w_r.png";
                item.msgCount = [NSString stringWithFormat:@"%@",viewReportFlag];
                [weakSelf.dataSource  addObject:item];
                if (j == array.count-1) {
                    [weakSelf.waterfallView  reloadTableData:weakSelf.dataSource];
                    [weakSelf disMissLoading];
                }
            }];
        }
    } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        
    }];
}
//添加瀑布流取到数据参数pageNum == -1 为获取第一个
-(NSMutableDictionary *)setParamLabelDetailsWithLabelID:(NSString *) labelID{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]  init];
    [dic  setValue:D_ID forKey:@"D_ID"];
    [dic  setValue:labelID forKey:@"topicQuery.labelID"];
    [dic  setValue:@"-1" forKey:@"topicQuery.pageNum"];
    return dic;
}
//瀑布流取到数据第一个值请求
-(void)requestLabelDetailsDataWithLableId:(NSString *)lableId titleName:(NSString *)name returnBlack:(void (^)(NSDictionary* dicDetails , id titleName))block{
    NSMutableDictionary * d =  [self setParamLabelDetailsWithLabelID:lableId];
    [http  sixReuqestUrl:TOP_1_2_2 postDict:d succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        NSDictionary * dicTemp = (NSDictionary*)obj;
        block(dicTemp , name);
    } failed:
     ^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
         block(nil ,nil);
     }];
}

//初始化控件
-(void)createComponent{
    
    NSArray * array = @[@"分类话题",@"同龄话题"];
    self.segmented = [[HMSegmentedControl alloc]  initWithSectionTitles:array];
    self.segmented.selectionIndicatorColor = [UIColor redColor];
    self.segmented.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    [self.segmented setSelectedTextColor:[UIColor redColor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ]];
    self.segmented.selectionStyle = HMSegmentedControlSelectionStyleBox;
    [self.segmented setFont:[UIFont systemFontOfSize:14]];
    __weak typeof(self) weakSelf = self;
    [self.segmented setIndexChangeBlock:^(NSInteger index) {
        switch (index) {
            case 0:
            {
                [weakSelf changeView:0];
                
            }
                break;
            case 1:
            {
                [weakSelf changeView:1];
            }
                break;
            default:
                break;
        }
    }];
    [self.view addSubview:self.segmented];
    
    
    self.waterfallView = [[WaterfallView alloc]  initWithFrame:CGRectMake(0,40, self.view.frame.size.width, self.view.frame.size.height - (49 + 40 + 64))];
    [self.waterfallView  createComponent:self.dataSource];
    self.waterfallView.hidden = NO;
    self.waterfallView.SelectRow = self;
    [self.view  addSubview:self.waterfallView];
    
    self.talk = [[AgeTalkView alloc]  initWithFrame:CGRectMake(0, 40, self.view.frame.size.width , self.view.frame.size.height)];
    [self.talk  createComponent];
    self.talk.hidden = YES;
    __weak typeof(self) weakSelf2 = self;
    self.talk.block = ^(NSInteger index)
    {
        switch (index) {
            case 1:
            {
                HotTopicViewController * hot = [[HotTopicViewController alloc]  init];
                hot.navLeftType = LeftBack;
                hot.titileS = @"同年龄段话题";
                hot.showTop = NO;
                hot.talkMark = AgeTalk;
                hot.ageGroupID = @"1";
                [weakSelf2.navigationController pushViewController:hot animated:YES];
                
            }
                
                break;
            case 2:
            {
                HotTopicViewController * hot = [[HotTopicViewController alloc]  init];
                hot.navLeftType = LeftBack;
                hot.titileS = @"同年龄段话题";
                hot.showTop = NO;
                hot.talkMark = AgeTalk;
                hot.ageGroupID = @"2";
                [weakSelf2.navigationController pushViewController:hot animated:YES];
                
            }
                break;
            case 3:
            {
                HotTopicViewController * hot = [[HotTopicViewController alloc]  init];
                hot.navLeftType = LeftBack;
                hot.titileS = @"同年龄段话题";
                hot.showTop = NO;
                hot.talkMark = AgeTalk;
                hot.ageGroupID = @"3";
                [weakSelf2.navigationController pushViewController:hot animated:YES];
                
            }
                break;
            case 4:
            {
                HotTopicViewController * hot = [[HotTopicViewController alloc]  init];
                hot.navLeftType = LeftBack;
                hot.titileS = @"同年龄段话题";
                hot.showTop = NO;
                hot.talkMark = AgeTalk;
                hot.ageGroupID = @"4";
                [weakSelf2.navigationController pushViewController:hot animated:YES];
                
            }
                break;
            case 5:
            {
                HotTopicViewController * hot = [[HotTopicViewController alloc]  init];
                hot.navLeftType = LeftBack;
                hot.titileS = @"同年龄段话题";
                hot.showTop = NO;
                hot.talkMark = AgeTalk;
                hot.ageGroupID = @"5";
                [weakSelf2.navigationController pushViewController:hot animated:YES];
                
            }
                break;
            case 6:
            {
                HotTopicViewController * hot = [[HotTopicViewController alloc]  init];
                hot.navLeftType = LeftBack;
                hot.titileS = @"同年龄段话题";
                hot.showTop = NO;
                hot.talkMark = AgeTalk;
                hot.ageGroupID = @"6";
                [weakSelf2.navigationController pushViewController:hot animated:YES];
                
            }
                break;
                
            default:
                break;
        }
    };
    [self.view  addSubview:self.talk];
    
    
}

-(void) changeView:(int ) i
{
    if(i == 0){
        self.title = @"分类话题";
        self.waterfallView.hidden = NO ;
        self.talk.hidden = YES ;
        
    }else{
        self.title = @"同龄话题";
        self.waterfallView.hidden = YES ;
        self.talk.hidden = NO ;
        
    }
}


#pragma waterfallView 页面跳转
- (void)didSelectRowAtIndexPath{
    HotTopicViewController * hot = [[HotTopicViewController alloc]  init];
    hot.navLeftType = LeftBack;
    [self.navigationController  pushViewController:hot animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)showLoading{
	loading = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:loading];
	loading.labelText = @"Loading";
    [loading show:YES];
}
-(void)disMissLoading{
    if (nil != loading) {
        [loading  removeFromSuperview];
    }
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
