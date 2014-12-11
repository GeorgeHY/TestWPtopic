//
//  ShowWindowLeftVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//


#define PARENT_USER          1 //家长用户
#define TEACTER_USER         2 //教师用户
#define OGANIZATION_USER     3 //机构用户

#define ALL_WINDOW           0 //全部橱窗
#define MINE_WINDOW          2 //我的橱窗


#define PARENT_MYWINDOW 2 //家长用户，我的橱窗
#import "ShowWindowLeftVC.h"
#import "UIViewController+MMDrawerController.h"
#import "AllShowWindowVC.h"
#import "AppDelegate.h"
#import "MineShowWindowVC.h"
#import "MyDatumVC.h"
#import "UIColor+AddColor.h"
#import "TotalVC.h"
#import "OwnerVC.h"
@interface ShowWindowLeftVC ()
{
    AFN_HttpBase * http;
    AppDelegate * app;
}
@property (nonatomic, strong) UIView * headerView;//头部视图
@property (nonatomic, assign) NSInteger lastSelected;//记录
@end

@implementation ShowWindowLeftVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"橱窗";
        self.lastSelected = -1;
        self.loginDict = [[NSMutableDictionary alloc]init];
        http = [[AFN_HttpBase alloc]init];
    }
    return self;
}
#pragma mark --点击头像进入个人资料
-(void)headerButtonClick
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid , @"D_ID", nil];
    
    DataItem * item = [[DataItem alloc]init];
    
    __weak ShowWindowLeftVC * weakSelf = self;
    
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
            item.located = @"";
            if (isNotNull([[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"located"])) {
            item.located = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"located"];
            }
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

#pragma mark - 创建tableHeaderView

-(UIView *)createHeaderView
{
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kMainScreenWidth, 88)];
    navView.backgroundColor = [UIColor whiteColor];
    navView.backgroundColor = [UIColor redColor];
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
    acitiLabel.text = @"橱窗";
    acitiLabel.textColor = [UIColor whiteColor];
    [navView addSubview:acitiLabel];
    
    UILabel * nickNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(120, headButton.frame.origin.y + 30, 100, 24)];
    nickNameLbl.textColor = [UIColor colorWithHexString:@"#949494"];
    nickNameLbl.text = [app.loginDict objectForKey:@"petName"];
    nickNameLbl.font = [UIFont systemFontOfSize:13];
    [navView addSubview:nickNameLbl];

    return navView;
}
-(void)viewWillAppear:(BOOL)animated
{
    app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = NO;
}
//  家长1 教师 2 机构 3
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    app = [AppDelegate shareInstace];
    
    self.loginDict = (NSMutableDictionary *)app.loginDict;
    
    self.userTypeID = [self.loginDict objectForKey:@"userTypeID"];
    
    self.petName = [self.loginDict objectForKey:@"petName"];
    
    NSMutableArray * name = [[NSMutableArray alloc]init];
    
    switch (self.userTypeID.intValue) {
            
        case OGANIZATION_USER:
        {
            NSLog(@"机构左菜单");
            [name addObject:@"全部"];
            [name addObject:@""];
            [name addObject:@"我的橱窗"];
        }
            break;
        case TEACTER_USER:
        {
            NSLog(@"教师左菜单");
            [name addObject:@"全部"];
            [name addObject:@""];
            [name addObject:@"我的橱窗"];
        }
            break;
        case PARENT_USER:
        {
            NSLog(@"家长左菜单");
            [name addObject:@"全部"];
            [name addObject:@""];
            [name addObject:@"我的橱窗"];
        }
            break;
        default:
            break;
    }
    
    dataArray = [[NSMutableArray alloc]init];
    
    [dataArray addObjectsFromArray:name];
    
    self.view.backgroundColor = kRGB(36, 40, 45);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight) style:UITableViewStylePlain];
    
    _tableView.backgroundColor = kRGB(36, 40, 45);
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.headerView  = [self createHeaderView];
    
    _tableView.tableHeaderView = self.headerView;
    
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * strID = @"ID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    cell.backgroundColor = kRGB(36, 40, 45);
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSInteger currentSelected = indexPath.row;
//    
//    if (currentSelected != self.lastSelected) {
//        NSLog(@"需要重置");
//        self.lastSelected = indexPath.row;
//    }else{
//        NSLog(@"不需要重置");
//        [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];
//        return;
//    }
//    
    
    switch (self.userTypeID.integerValue) {
            
        case OGANIZATION_USER:
        {
            NSLog(@"机构用户");
            switch (indexPath.row) {
                case ALL_WINDOW:
                {
                    TotalVC * allVC = [[TotalVC alloc]init];
                    allVC.title = @"橱窗全部";
                    [app.mTbc reloadTBCWithController:allVC];
                    [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];
                }
                    break;
                case MINE_WINDOW:
                {
                    OwnerVC * allVC = [[OwnerVC alloc]init];
                    allVC.title = @"我的橱窗";
                    allVC.userType = self.userTypeID.intValue;
                    
                    [app.mTbc reloadTBCWithController:allVC];
                    [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case TEACTER_USER:
        {
            NSLog(@"教师用户");
            
            switch (indexPath.row) {
                case ALL_WINDOW:
                {
                    TotalVC * allVC = [[TotalVC alloc]init];
                    allVC.title = @"橱窗全部";
                    [app.mTbc reloadTBCWithController:allVC];
                    [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];
                }
                    break;
            
                case MINE_WINDOW:
                {
                    OwnerVC * allVC = [[OwnerVC alloc]init];
                    allVC.title = @"我的橱窗";
                    allVC.userType = self.userTypeID.intValue;
                    
                    [app.mTbc reloadTBCWithController:allVC];
                    [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];
                }
                default:
                    break;
            }
            
        }
            break;
        case PARENT_USER:
        {
            switch (indexPath.row) {
                case ALL_WINDOW:
                {
                    TotalVC * allVC = [[TotalVC alloc]init];
                    allVC.title = @"橱窗全部";
                    [app.mTbc reloadTBCWithController:allVC];
                    [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];
                }
                    break;
                case MINE_WINDOW:
                {

                    OwnerVC * allVC = [[OwnerVC alloc]init];
                    allVC.title = @"我的橱窗";
                    allVC.userType = self.userTypeID.intValue;
                    [app.mTbc reloadTBCWithController:allVC];
                    [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];
                }
                    break;
            
                default:
                    break;
            }
            
            break;
        }
        default:
            break;
    }
}

@end
