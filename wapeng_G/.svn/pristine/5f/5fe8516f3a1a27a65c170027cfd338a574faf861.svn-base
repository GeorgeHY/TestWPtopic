//
//  FocusVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-13.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define FANS  1 //粉丝
#define FOUCS 2 //关注
#define PARENT 1 //家长用户类型
#define TEACHER 2//教师用户类型
#define AGENT   3//机构用户类型
#define MAN     1 //男孩
#define WOMAN   2 //女孩
#import "FocusVC.h"
#import "Cell_Focus.h"
#import "UIViewController+General.h"
#import "Item_foucs.h"
#import "StringTool.h"
#import "TimeTool.h"
#import "UIImageView+WebCache.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIViewController+General.h"
@interface FocusVC ()
{
    AFN_HttpBase * http;
    int pageIndex;
}
@property (nonatomic, assign) int isButtom;//是否有下一页
@property (nonatomic, assign) BOOL isRefresh;//什么操作
@end

@implementation FocusVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        http = [[AFN_HttpBase alloc]init];
        _dataArray = [[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark - 下拉刷新
//下拉刷新
-(void)headerRereshing
{
    self.isRefresh = YES;
    pageIndex = 1;
    
    [self httpRequestWithType:self.type pageIndex:pageIndex];

}
#pragma mark - 上拉加载更多
//上拉加载更多
-(void)footerRereshing
{
    self.isRefresh = NO;
    if (self.isButtom == YES) {
        
        [SVProgressHUD showErrorWithStatus:dTips_noMoreData];
        
        [self.tableView footerEndRefreshing];
        
        return;
    }
    
    pageIndex++;
    
     [self httpRequestWithType:self.type pageIndex:pageIndex];
}

#pragma mark - 用户粉丝列表或用户关注列表
-(void)httpRequestWithType:(int)type pageIndex:(int)newPageIndex
{
    
    NSString * page = [NSString stringWithFormat:@"%d", newPageIndex];
    
    NSString * url = nil;
    
    switch (type) {
        case FANS:
        {
            url = dUrl_OSM_1_1_15;
        }
            break;
        case FOUCS:
        {
            url = dUrl_OSM_1_1_16;
        }
            break;
        default:
            break;
    }
    
       __weak FocusVC * weakSelf = self;
    
    [http thirdRequestWithUrl:url succeed:^(NSObject *obj, BOOL isFinished) {
        
        if (weakSelf.isRefresh == YES) {
            
            [weakSelf.dataArray removeAllObjects];
            
        }
        
        NSDictionary * root = (NSDictionary *)obj;
        
        weakSelf.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"]intValue];
        
        NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
        
        for (NSDictionary * dict in list) {
            
            Item_foucs * item = [[Item_foucs alloc]init];
            //先判断用户类型用户类型
            item.userType = [[[dict objectForKey:@"userType"] objectForKey:@"id"]intValue];
            //熟人关注数
            item.viewAttentionCount = [NSString stringWithFormat:@"%@个熟人关注", [dict objectForKey:@"viewAttentionCount"]];
            item.createTime = [dict objectForKey:@"createTime"];
            item.petName = [dict objectForKey:@"petName"];
            //先赋值
            item.isHidden = YES;
            
            item.relativePath = @"";
            if (![[dict objectForKey:@"photo"] isKindOfClass:[NSNull class]]) {
                
                if (![[[dict objectForKey:@"photo"] objectForKey:@"relativePath"] isKindOfClass:[NSNull class]]) {
                    item.relativePath = [[dict objectForKey:@"photo"] objectForKey:@"relativePath"];
                    item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, item.relativePath];
                }
                
            }
            
            if (item.userType == PARENT) {
                item.isHidden = NO;
                
                item.loaction = [[dict objectForKey:@"userInfoExtension"] objectForKey:@"located"];
                
                item.birthday = [[[dict objectForKey:@"childInfoList"] objectAtIndex:0] objectForKey:@"birthday"];
                item.gender = [[[[dict objectForKey:@"childInfoList"] objectAtIndex:0] objectForKey:@"gender"]intValue];
                
            }
            else if (item.userType == TEACHER) {
                
                item.loaction = [[dict objectForKey:@"userInfoExtension"] objectForKey:@"located"];
                item.loaction = [NSString stringWithFormat:@"供职于:%@", item.loaction];
                
        
                if (![dict objectForKey:@"childInfoList"]) {
                    
                    if (![[dict objectForKey:@"childInfoList"] objectAtIndex:0]) {
                        item.birthday = [[[dict objectForKey:@"childInfoList"] objectAtIndex:0] objectForKey:@"birthday"];
                    
                        item.gender = [[[[dict objectForKey:@"childInfoList"] objectAtIndex:0] objectForKey:@"gender"]intValue];
                    }
                }
                
            }else{
                
                item.loaction = [[dict objectForKey:@"organizationExtension"] objectForKey:@"bizAddress"];
                
            }
            
            item.age = [TimeTool getBabyAgeWithBirthday:item.birthday publicTime:item.createTime];
            
            [weakSelf.dataArray addObject:item];
        }
        [weakSelf.tableView footerEndRefreshing];
        [weakSelf.tableView headerEndRefreshing];
        [weakSelf.tableView reloadData];

        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:dTips_requestError];
        
    } andKeyValuePairs:@"userInfoQuery.id", self.authorID,@"userInfoQuery.pageNum", page, nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (IOS7) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    switch (self.type) {
        case FANS:
        {
            self.title = @"我的粉丝";
        }
            break;
        case FOUCS:
        {
            self.title = @"我的关注";
        }
            break;
        default:
            break;
    }
    
    [self initLeftItem];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44 - 49) style:UITableViewStylePlain];
    //取消指示条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self setupRefresh:self.tableView];
    
    pageIndex = 1;
    
    [self httpRequestWithType:self.type pageIndex:pageIndex];
    
    __weak FocusVC * weakSelf = self;
    
    //双击导航条之后下拉刷新
    [self.navigationController.navigationBar whenDoubleTapped:^{
        
        [weakSelf.tableView headerBeginRefreshing];
        
    }];
}

-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * strID = @"ID";
    
    Cell_Focus * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_Focus" owner:self options:nil]lastObject];
    }
    Item_foucs * item = _dataArray[indexPath.row];
    
    cell.nickLbl.text = item.petName;
    cell.foucsCountLbl.text = item.viewAttentionCount;
    
    NSURL * url = [NSURL URLWithString:item.relativePath];
    [cell.headerIV setImageWithURL:url placeholderImage:[UIImage imageNamed:@"saga2.jpg"]];
    
    cell.loactionLbl.text = item.loaction;
    
    if (item.isHidden == NO) {
        
        switch (item.gender) {
            case MAN:
            {
                cell.genderIv.image = [UIImage imageNamed:@"boy-notselected30"];
            }
                break;
            case WOMAN:
            {
                cell.genderIv.image = [UIImage imageNamed:@"girl-notselected30"];
            }
            default:
                break;
        }
        cell.ageLbl.text = item.age;
    }
    cell.genderIv.hidden = item.isHidden;
    cell.ageLbl.hidden = item.isHidden;
    return cell;
}
@end
