//
//  ActivityLeftVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
//nameArray = @[@[@"商家组织的活动", @"个人组织的活动", @""], @[@"今日十大", @"分类活动", @"",@"我的活动", @"text"]];
typedef NS_ENUM(NSInteger, ACT_LIST_1)
{
    ACT_SELLER = 0,//商家活动
    ACT_PERSION = 1//个人活动
};

typedef NS_ENUM(NSInteger, ACT_LIST_2)
{
    ACT_TEN= 0, //今日十大
    ACT_CAREGORY = 1,//分类活动
    ACT_MYACT = 3//我的活动
};
#define SECTION_0            0
#define SECTION_1            1
#define PARENT_USER          1 //家长用户
#define TEACTER_USER         2 //教师用户
#define OGANIZATION_USER     3 //机构用户

#import <QuartzCore/QuartzCore.h>
#import "ActivityLeftVC.h"
#import "SVProgressHUD.h"
#import "SellerAcitvityVC.h"//商家活动， 搜索结果等
#import "CommonVC.h"
#import "CommonVC02.h"
#import "UIViewController+MMDrawerController.h"
#import "AllActivityVC.h"
#import "WaterFlowVC.h"
#import "ChildBrowserVC.h"

#import "UIColor+AddColor.h"
#import "AppDelegate.h"
#import "Cell_ActivityLeft.h"
#import "MyDatumVC.h"
#import "ASIViewController.h"
@interface ActivityLeftVC ()
{
     AppDelegate * app;
}
@end

@implementation ActivityLeftVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"left";
        _hotWordArr = [[NSMutableArray alloc]init];
    }
    return self;
}

//在这里获得热词
-(void)viewWillAppear:(BOOL)animated
{
//    app = [AppDelegate shareInstace];
//    app.mTbc.mainView.hidden = NO;
    [self getHotWord];
}
//获得热词
-(void)getHotWord
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    AFN_HttpBase * afn = [[AFN_HttpBase alloc]init];
    
    __weak ActivityLeftVC * weakSelf = self;
    
    [afn thirdRequestWithUrl:dUrl_ACT_1_1_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * dict = (NSDictionary *)obj;
        
        NSArray * list = [[dict objectForKey:@"value"] objectForKey:@"list"];
        
        for (NSDictionary * dict in list) {
            
            NSString * hotWord = [NSString stringWithFormat:@"%@", [dict objectForKey:@"content"]];
            //添加热词
            [weakSelf.hotWordArr addObject:hotWord];
        }
        
        NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
        
        [d setObject:weakSelf.hotWordArr forKey:UD_hotWord];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID", ddid, @"activitySearchWordQuery.pageNum", @"1", nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    nameArray = @[@[@"商家组织的活动", @"个人组织的活动", @""], @[@"今日十大", @"分类活动", @"",@"我的活动", @"text"]];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,20, kMainScreenWidth, kMainScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#30353b"];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    self.tableView.separatorColor = [UIColor grayColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
     app = [AppDelegate shareInstace];
    
    [self createUI];
}

//创建UI
-(void)createUI
{
    //虚拟的nav
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kMainScreenWidth, 88)];
    navView.backgroundColor = [UIColor whiteColor];
    navView.backgroundColor = kRGB(76, 108, 200);
    UIButton * headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headButton.frame = CGRectMake(30, 19, 60, 60);
    headButton.layer.masksToBounds = YES;
    headButton.layer.cornerRadius = 8;
    headButton.layer.borderWidth = 5;
    headButton.layer.borderColor = [UIColor grayColor].CGColor;
    
    [headButton setImage:[UIImage imageNamed:@"saga2.jpg"] forState:UIControlStateNormal];
    
    [headButton addTarget:self action:@selector(headerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:headButton];
    
    UILabel * acitiLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, headButton.frame.origin.y , 100, 24)];
    acitiLabel.text = @"活动";
    acitiLabel.textColor = [UIColor whiteColor];
    [navView addSubview:acitiLabel];
    
    UILabel * nickNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(120, headButton.frame.origin.y + 30, 100, 24)];
    nickNameLbl.textColor = [UIColor colorWithHexString:@"#949494"];
    nickNameLbl.text = [app.loginDict objectForKey:@"petName"];
    nickNameLbl.font = [UIFont systemFontOfSize:13];
    [navView addSubview:nickNameLbl];
    
    self.tableView.tableHeaderView = navView;
}

#pragma mark --点击头像进入个人资料
-(void)headerButtonClick
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid , @"D_ID", nil];
    
    __weak ActivityLeftVC * weakSelf = self;
    
     DataItem * item = [[DataItem alloc]init];
    
    AFN_HttpBase * http = [[AFN_HttpBase alloc]init];
    
    [http fiveReuqestUrl:dUrl_OSM_1_1_3 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * root = (NSDictionary *)obj;
        
        item.petName = [[root objectForKey:@"value"] objectForKey:@"petName"];
        
        
        //先赋值
        item.relativePath = @"";
        if (![[root objectForKey:@"value"] isKindOfClass:[NSNull class]]) {
            
            if (![[[root objectForKey:@"value"] objectForKey:@"photo"] isKindOfClass:[NSNull class]]) {
                
                if (![[[[root objectForKey:@"value"] objectForKey:@"photo"] objectForKey:@"relativePath"] isKindOfClass:[NSNull class]]) {
                    item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, [[[root objectForKey:@"value"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
                }
            }
        }
        
        item.userType = [[[[root objectForKey:@"value"] objectForKey:@"userType"] objectForKey:@"id"]intValue];
        
        
        if (item.userType == PARENT_USER || item.userType == TEACTER_USER) {
            
            item.located = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"located"];
            item.personnelSignature = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"personnelSignature"];
            item.gender =[[[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"gender"]integerValue];
            item.wpCode = [[root objectForKey:@"value"] objectForKey:@"wpCode"];
            
        }else{
            
            NSDictionary * value = [root objectForKey:@"value"];
            
            item.located = [[value objectForKey:@"organizationExtension"] objectForKey:@"bizAddress"];
            item.wpCode = [[root objectForKey:@"value"] objectForKey:@"wpCode"];
            item.personnelSignature =[[value objectForKey:@"organizationExtension"] objectForKey:@"description"];
            
            NSLog(@"%@", item.personnelSignature);
        }
        
        
        
        
        MyDatumVC * vc = [[MyDatumVC alloc]init];
        vc.type = 1;
        vc.item = item;
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
        nc.navigationBar.translucent = NO;
        [weakSelf presentViewController:nc animated:YES completion:nil];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    }];
}

#pragma mark--tableViewDeleagte

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray * name = @[@"   身边", @"   全网"];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, kMainScreenWidth, 30)];
    label.textColor = [UIColor grayColor];
    label.text = name[section];
    return label;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [nameArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [[nameArray objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    Cell_ActivityLeft * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[Cell_ActivityLeft alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
         cell.backgroundColor = [UIColor colorWithHexString:@"#30353b"];
        
    }
    
    cell.textLabel.text = [[nameArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - 左菜单
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.section) {
        case SECTION_0:
        {
            switch (indexPath.row) {
                case ACT_SELLER:
                {
                    SellerAcitvityVC * vc = [[SellerAcitvityVC alloc]init];
                    vc.pageType = 3;
                    vc.title = @"商家组织的活动";
                    [app.mTbc reloadTBCWithController:vc];
                }
                    break;
                case ACT_PERSION:
                {
                    CommonVC02 * vc = [[CommonVC02 alloc]init];
                    //                    vc.vcType = vc_userActivity;
//                    vc.title = @"个人组织的活动";
                    vc.title = @"用户活动";
                    vc.pageType = 2;
                    [app.mTbc reloadTBCWithController:vc];
                }
                    break;
                case 2:
                {
                    NSLog(@"占位");
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case SECTION_1:
        {
            switch (indexPath.row) {
                case ACT_TEN:
                {
                    CommonVC * vc = [[CommonVC alloc]init];
                    vc.title = @"今日十大";
                    vc.pageType = 1;
                    [app.mTbc reloadTBCWithController:vc];
                    
                }
                    break;
                case ACT_CAREGORY:
                {
                    WaterFlowVC * waterVC = [[WaterFlowVC alloc]init];
                    waterVC.loginDict = app.loginDict;
                    [app.mTbc reloadTBCWithController:waterVC];
                }
                    break;
                case 2:
                {
                    
                }
                    break;
                case ACT_MYACT:
                {
                    CommonVC02 * vc = [[CommonVC02 alloc]init];
//                    vc.vcType = vc_userActivity;
                    vc.pageType = 1;
                    vc.title = @"我的活动";
                    [app.mTbc reloadTBCWithController:vc];
                    
                }
                    break;
                case 4:
                {
                    //测试用的
                    ASIViewController * asi = [[ASIViewController alloc]init];
                    [app.mTbc reloadTBCWithController:asi];
                }
                default:
                    break;
            }

        }
        default:
            break;
    }
     [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

@end
