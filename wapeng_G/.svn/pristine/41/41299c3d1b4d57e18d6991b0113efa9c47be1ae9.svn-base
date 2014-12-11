//
//  MeLeftVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MeLeftVC.h"
#import "MyDatumVC.h"
#import "MessageVC.h"
#import "AppDelegate.h"
#import "SetVC.h"
#import "MeMiddleVC.h"
#import "UIViewController+MMDrawerController.h"
#import "MyMailVC.h"
@interface MeLeftVC ()
{
    NSArray *_allTitle;
}

@property(nonatomic , strong) UITableView * tableView;
@property(nonatomic , strong) NSMutableArray * dataSource;



@end

@implementation MeLeftVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc]  init];
    NSArray * array1 = [[NSArray alloc] initWithObjects:@"我",@"我的资料",@"宝宝资料", nil];
    NSArray * array2 = [[NSArray alloc] initWithObjects:@"我的私信",@"我的消息", nil];
    NSArray * array3 = [[NSArray alloc] initWithObjects:@"我的设置", nil];
    NSArray * array4 = [[NSArray alloc] initWithObjects:@"我的收藏", nil];
    [self.dataSource  addObject:array1];
    [self.dataSource  addObject:array2];
    [self.dataSource  addObject:array3];
    [self.dataSource  addObject:array4];
    [self createUIView];
}
-(void)createUIView
{
    self.view.backgroundColor = [UIColor blackColor];
    UIView * v = [[UIView alloc]  initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 88)];
    v.backgroundColor = kRGB(113, 59, 144);
    [self.view addSubview:v];
    
    UIImageView * iv = [[UIImageView alloc]  initWithFrame:CGRectMake(50, 14, 60, 60)];
    [iv  setImage:[UIImage imageNamed:@"heardIcon.png"]];
    iv.layer.masksToBounds = YES;
    iv.layer.cornerRadius = 8;
    [v  addSubview:iv];
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(iv.frame.origin.x + iv.frame.size.width+20, 20, 60, 20)];
    name.textColor = [UIColor whiteColor];
    name.text = @"我";
    [v addSubview:name];
    
    UILabel * num = [[UILabel alloc]  initWithFrame:CGRectMake(iv.frame.origin.x + iv.frame.size.width+20,name.frame.origin.y +  name.frame.size.height + 2,kMainScreenWidth - CGRectGetMaxX(iv.frame), 20)];
    num.textColor = [UIColor whiteColor];
    num.text = @"1123132";
    [v addSubview:num];
    [self.view addSubview:v];
    
    self.tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, CGRectGetMaxY(v.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(v.frame))];
    self.tableView.backgroundView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.backgroundColor = kRGB(36, 40, 45);
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}


#pragma mark - 表格视图的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.dataSource  objectAtIndex:section] ;
    return array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else
        return 35;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

//
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 35)];
    view.backgroundColor = kRGB(36, 40, 45);
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, view.frame.size.height - 1, kMainScreenWidth, 1);
    imageView.backgroundColor = [UIColor whiteColor];
    [view addSubview:imageView];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = kRGB(36, 40, 45);
        cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"activity_cell_selected"]];
    }
    
    UIImageView * imageView = [[UIImageView alloc]init];
    CGRect frame = cell.frame;
    frame.origin.y = frame.size.height - 1;
    frame.size.height = 1;
    imageView.frame = frame;
    imageView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:imageView];
    
    
    NSArray * array = [self.dataSource  objectAtIndex:[indexPath section]];
    cell.textLabel.text = [array  objectAtIndex:[indexPath  row]];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate * app = [AppDelegate shareInstace];
    switch (indexPath.section) {
        case 0:
        {
            
            switch (indexPath.row) {
                case 0:
                {
                    MeMiddleVC * myDatum = [[MeMiddleVC alloc]  init];
                    [app.mTbc reloadTBCWithController:myDatum];
                    [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];;
                    
                }
                    break;
                case 1:
                {   //我的资料
                    MyDatumVC * myDatum = [[MyDatumVC alloc]  init];
                    [app.mTbc reloadTBCWithController:myDatum];
                    [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];;
                    
                }
                    break;
                case 2:
                {
                    //宝宝的资料
                    MessageVC * baby = [[MessageVC alloc]initWithNibName:@"MessageVC" bundle:nil];
                    
                    //
                    //            BabyDatumVC * baby = [[BabyDatumVC alloc]  init];
                    
                    
                    [app.mTbc reloadTBCWithController:baby];
                    [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];
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
                    
                    [app.mTbc reloadTBCWithController:set];
                    [self.mm_drawerController setCenterViewController:app.mTbc withCloseAnimation:YES completion:nil];
                    
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
                    //我的收藏
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}
@end
