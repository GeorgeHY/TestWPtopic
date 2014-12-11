//
//  MeMiddleVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define dTag_HeaderView  100 //头像
#define dTag_PetNameLbl  101 //昵称
#define dTag_NumLbl      102 //娃朋号码
#define dTag_TableHeaderView 103
#import "MeMiddleVC.h"
#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "UIView+WhenTappedBlocks.h"
#import "MyDatumVC.h"
#import "SetVC.h"
#import "MessageVC.h"
#import "StoresVC.h"
#import "MyMailVC.h"
#import "DataItem.h"
#import "UIImageView+WebCache.h"
#import "MyCollentVC.h"
#import "KindergartenVC.h"
@interface MeMiddleVC ()
@property(nonatomic , strong) UITableView * tableView;
@property(nonatomic , strong) NSArray * dataSource;

@property (nonatomic, strong) NSString * wpCode;//娃朋号码
@property (nonatomic, strong) NSString * petName;//用户昵称
@end

@implementation MeMiddleVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我";
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}


#pragma mark - 加载用户信息

-(void)loadUserInfo
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid , @"D_ID", nil];
    
    DataItem * item = [[DataItem alloc]init];
    
    AFN_HttpBase * http = [[AFN_HttpBase alloc]init];
    
    __weak MeMiddleVC * weakSelf = self;
    
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
        
        
        if (item.userType == PARENT_USER || item.userType == TEACHER_USER) {
            
            item.located = kNullData;
            
            if (isNotNull([[root objectForKey:@"value"] objectForKey:@"userInfoExtension"])) {
                
                if (isNotNull([[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"located"])) {
                    
                    item.located = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"located"];
                }
            }
          
            item.personnelSignature = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"personnelSignature"];
            item.gender =[[[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"gender"]integerValue];
            item.wpCode = [[root objectForKey:@"value"] objectForKey:@"wpCode"];
            item.mid = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"id"];

            
        }else{
            
            NSDictionary * value = [root objectForKey:@"value"];
            
            item.located = kNullData;
            if (isNotNull([value objectForKey:@"organizationExtension"])) {
                if (isNotNull([[value objectForKey:@"organizationExtension"] objectForKey:@"bizAddress"])) {
                    item.located = [[value objectForKey:@"organizationExtension"] objectForKey:@"bizAddress"];
                }
            }
            
            NSLog(@"%@", item.located);
            
            item.wpCode = [[root objectForKey:@"value"] objectForKey:@"wpCode"];
            item.personnelSignature =[[value objectForKey:@"organizationExtension"] objectForKey:@"description"];
//            item.mid = [value objectForKey:@"organizationExtension" objectForKey:@"id"];
            item.mid = [[value objectForKey:@"organizationExtension"] objectForKey:@"id"];
    
            NSLog(@"%@", item.personnelSignature);
        }
        
        UILabel * petLbl = (UILabel *)[weakSelf.view viewWithTag:dTag_PetNameLbl];
        petLbl.text = item.petName;
        
        UILabel * wpCodeLbl = (UILabel *)[weakSelf.view viewWithTag:dTag_NumLbl];
        
        wpCodeLbl.text = item.wpCode;
        
        UIImageView * iv =  (UIImageView *)[weakSelf.view viewWithTag:dTag_HeaderView];
        
        NSURL * url = [NSURL URLWithString:item.relativePath];

        [iv setImageWithURL:url placeholderImage:kDefaultPic];
        
        MyDatumVC * datumVC = [[MyDatumVC alloc]init];
        datumVC.item = item;
        datumVC.type = 2;
        
        UIView * view = [self.view viewWithTag:dTag_TableHeaderView];
        
        
        [view whenTapped:^{

            [weakSelf.navigationController pushViewController:datumVC animated:YES];
        }];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:dTips_requestError];
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    
    
    int user = [[d objectForKey:UD_userType] intValue];
    
    NSArray * array1 = nil;
     array1 = [[NSArray alloc]  initWithObjects:@"宝宝资料", nil];
    if (user == AGENT_USER) {
        
        array1 = [[NSArray alloc]  initWithObjects:@"班级信息", nil];
    }
 
    NSArray * array2 = [[NSArray alloc]  initWithObjects:@"我的私信",@"我的消息", nil];
    NSArray * array3 = [[NSArray alloc]  initWithObjects: @"我的设置", nil];
    NSArray * array4 = [[NSArray alloc]  initWithObjects: @"我的收藏", nil];
    self.dataSource = [[NSArray alloc]  initWithObjects:array1,array2,array3,array4,nil];
    
    self.view.backgroundColor = kRGB(239, 239, 239);
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0 ,self.view.frame.size.width ,100)];
    v.tag = dTag_TableHeaderView;
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 20)];
    img.backgroundColor = kRGB(239, 239, 239);
    [v addSubview:img];
    
    UIImageView *iv = [[UIImageView alloc]  initWithFrame:CGRectMake(20, 30, 60, 60)];
    [iv setImage:[UIImage imageNamed:@"heardIcon.png"]];
    iv.tag = dTag_HeaderView;
    [v  addSubview:iv];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iv.frame)+20, iv.frame.origin.y +5, kMainScreenWidth / 2, 20)];
    name.textColor = [UIColor blackColor];
    name.text = @"碧凌";
    name.tag = dTag_PetNameLbl;
    [v addSubview:name];
    
    UIImage *QR = [UIImage imageNamed:@"QR_code"];
    UIImage *arrow = [UIImage imageNamed:@"arrow"];
    
    UIImageView *QRImg = [[UIImageView alloc]initWithImage:QR];
    QRImg.center = CGPointMake(kMainScreenWidth - 80, iv.center.y);
    [v addSubview:QRImg];
    
    UIImageView *arrowImg = [[UIImageView  alloc]initWithFrame:CGRectMake(CGRectGetMaxX(QRImg.frame) + 30, QRImg.frame.origin.y, arrow.size.width, arrow.size.height)];
    arrowImg.image = arrow;
    [v addSubview:arrowImg];
    
    UILabel * num = [[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(iv.frame)+20,CGRectGetMaxY(name.frame) + 10, 100, 20)];
    num.textColor = [UIColor blackColor];
    num.tag = dTag_PetNameLbl;
    num.text = @"11234132";
    [v addSubview:num];
    
    self.tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 49 - 64)];
    self.tableView.tableHeaderView = v;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view  addSubview:self.tableView];
    
    [self loadUserInfo];
}
-(void)navItemClick:(UIButton *)B
{
    
}
-(void)btnClick
{
    
}

#pragma mark tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = [self.dataSource  objectAtIndex:section];
    return array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier] ;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray * array = [self.dataSource  objectAtIndex:[indexPath section]];
    cell.textLabel.text = [array  objectAtIndex:[indexPath  row]];
    
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    //宝宝资料
                    
                {
                    
                    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
                    
                    int num = [[d objectForKey:UD_userType]intValue];
                    
                    if (num == AGENT_USER) {
                        KindergartenVC * kinderGartenVC = [[KindergartenVC alloc]init];
                        
                        [self.navigationController pushViewController:kinderGartenVC animated:YES];
                        
                        return;
                    }
                    MessageVC * baby = [[MessageVC alloc]initWithNibName:@"MessageVC" bundle:nil];
                    //                    MyDatumVC * md = [[MyDatumVC alloc]  init];
                    [self.navigationController  pushViewController:baby animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //我的私信
                    MyMailVC * mailVc = [[MyMailVC alloc]  init];
                    [self.navigationController pushViewController:mailVc animated:YES];
                }
                    break;
                    
                case 1:
                    //我的消息
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {//设置
                    SetVC * set = [[SetVC alloc]  init];
                    
                    [self.navigationController pushViewController:set animated:YES];
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //我的收藏
                    
                    MyCollentVC * myCollecntVC = [[MyCollentVC alloc]init];
                    [self.navigationController pushViewController:myCollecntVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
            
            
        default:
            break;
    }
}

@end
