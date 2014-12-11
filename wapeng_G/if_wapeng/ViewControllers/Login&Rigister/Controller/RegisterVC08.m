//
//  RegisterVC08.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-27.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#import "RegisterVC07.h"
#import "RegisterVC08.h"
#import "Cell_Class.h"
#import "UIColor+AddColor.h"
#import "RegisterVC06.h"
#import "MJRefresh.h"
#import "AFN_HttpBase.h"
#import "GlobalKeys.h"
#import "SVProgressHUD.h"
#import "Item_RC08.h"
#import "UIImageView+WebCache.h"
#import "RegsiterVC009.h"
#import "UIViewController+General.h"
#import "RegisterDataManager.h"

@interface RegisterVC08 ()
{
    AFN_HttpBase * http;
    NSUserDefaults * userDefaults;
    UILabel *nameLB;
    int pageIndex;
    RegisterDataManager * _dm;
}
@end

@implementation RegisterVC08
@synthesize dataArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
         http=[[AFN_HttpBase alloc]init];
        dataArray=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.title = @"宝宝班级";
    
    if (IOS7) {
        
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
   
   
    userDefaults=[NSUserDefaults standardUserDefaults];
    [self initLeftItem];
    [self createUIView];
    pageIndex = 1;
//    [self httpRequestWithPage:pageIndex];
    [self httpRequestWithPageIndex:pageIndex];
    
}

#pragma mark - 创建UIView
-(void)createUIView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kMainScreenWidth, kMainScreenHeight - 44) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    //注册下拉刷新
    [self setupRefresh:self.tableView];
}

-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 上拉加载更多
-(void)footerRereshing
{
    Item_RC08 * item = [dataArray lastObject];
    
    if (item.isButtom == 1) {
        [SVProgressHUD showSuccessWithStatus:dTips_noMoreData];
        
        [self.tableView footerEndRefreshing];
        
        return;
    }
    pageIndex++;
    [self httpRequestWithPageIndex:pageIndex];
    
}
#pragma mark - 下拉刷新
-(void)headerRereshing
{
    pageIndex = 1;
    //先清空数据源
    [dataArray removeAllObjects];
//    [self httpRequestWithPage:pageIndex];
    [self httpRequestWithPageIndex:pageIndex];
}

-(void)httpRequestWithPageIndex:(int)page
{
    NSString * pageStr = [NSString stringWithFormat:@"%d", page];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:self._id, @"organizationBranchQuery.organizationID",pageStr,@"ctivityQuery.pageNum", @"2", @"organizationBranchQuery.dormant",nil];
    
    
    __weak RegisterVC08 * weakSelf = self;
    
    [http fiveReuqestUrl:dUrl_OSM_1_2_1 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * root = (NSDictionary *)obj;
        
        if (!isNotNull([[root objectForKey:@"value"] objectForKey:@"list"])) {
            
            [SVProgressHUD showSuccessWithStatus:dTips_noData];
            return;
        }
        NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
        
        for (NSDictionary * dict in list) {
            
            Item_RC08 * item = [[Item_RC08 alloc]init];
            item.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"] intValue];
            item.name = [dict objectForKey:@"name"];
            item._id = [dict objectForKey:@"id"];
            NSArray * respList = [dict objectForKey:@"respList"];
            if (respList.count == 1) {
                
                item.petName1 = [[respList[0] objectForKey:@"responsible"] objectForKey:@"petName"];
                item.photo1 = [NSString stringWithFormat:@"%@%@",dUrl_PhotoPrefixion,[[[respList[0] objectForKey:@"responsible"] objectForKey:@"photo"]objectForKey:@"relativePath"]];
                item.isUnique = 1;
            }
            if (respList.count == 2) {
                
                item.petName1 = [[respList[0] objectForKey:@"responsible"] objectForKey:@"petName"];
                item.photo1 = [NSString stringWithFormat:@"%@%@",dUrl_PhotoPrefixion,[[[respList[0] objectForKey:@"responsible"] objectForKey:@"photo"]objectForKey:@"relativePath"]];
                item.petName2 = [[respList[1] objectForKey:@"responsible"] objectForKey:@"petName"];
                item.photo2 = [NSString stringWithFormat:@"%@%@",dUrl_PhotoPrefixion,[[[respList[1] objectForKey:@"responsible"] objectForKey:@"photo"]objectForKey:@"relativePath"]];
                item.isUnique = 0;
            }
            [weakSelf.dataArray addObject:item];
        }
        
        [weakSelf.tableView footerEndRefreshing];
        [weakSelf.tableView headerEndRefreshing];
        
        [weakSelf.tableView reloadData];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    }];
}

//-(void)httpRequestWithPage:(int)newPage
//{
//    
//    NSLog(@"%@", self._id);
//    
//    NSString *newPageIndex=[NSString stringWithFormat:@"%d",newPage];
//    
//    __weak RegisterVC08 * weakSelf = self;
//    
//    [http thirdRequestWithUrl:dUrl_OSM_1_2_1 succeed:^(NSObject *obj, BOOL isFinished) {
//        NSDictionary* dicResult  = (NSDictionary *)obj;
//        NSDictionary * valueDic = [dicResult  objectForKey:@"value"];
//        NSString *sValue=[NSString stringWithFormat:@"%@",valueDic];
//        if ([sValue isEqualToString:@"<null>"]) {
//            [SVProgressHUD showSimpleText:@"没有数据"];
//            [_tableView headerEndRefreshing];
//            return;
//        }
//        NSArray * listArr=[valueDic objectForKey:@"list"];
//        if (listArr.count==0) {
//            [SVProgressHUD showSimpleText:@"没有数据"];
//            [_tableView headerEndRefreshing];
//            return;
//        }
//        for (NSDictionary * dict in listArr) {
//            
//            Item_RC08 * item = [[Item_RC08 alloc]init];
//            item.isButtom = [[[dicResult objectForKey:@"value"] objectForKey:@"isButtom"]intValue];
//            item.name = [dict objectForKey:@"name"];
//            NSLog(@"获取的name==%@",item.name);
//            item._id=[dict objectForKey:@"id"];
//            _dm.classID=item._id;
//            NSArray * respList = [dict objectForKey:@"respList"];
//            NSString * petName=[NSString stringWithFormat:@"%@",[[respList[0] objectForKey:@"responsible"] objectForKey:@"petName"]];
//            if (![petName isEqualToString:@"<null>"]){
//                item.petName1 =petName;
//            }else{
//                item.petName1=@"";
//            }
//            if(respList.count==2){
//                NSString * petName2=[NSString stringWithFormat:@"%@",[[respList[1] objectForKey:@"responsible"] objectForKey:@"petName"]];
//                
//                if (![petName2 isEqualToString:@"<null>"]){
//                    item.petName2 =petName;
//                }else{
//                    item.petName2=@"";
//                }
//            }else{
//                item.petName2=@"";
//            }
//            NSLog(@"petname1=%@  petname2=%@",item.petName1,item.petName2);
//        
//            item.photo1=[NSString stringWithFormat:@"%@%@",dUrl_PhotoPrefixion,[[[respList[0] objectForKey:@"responsible"] objectForKey:@"photo"]objectForKey:@"relativePath"]];
//
//    
//            if ([item.photo1 isEqualToString:@"<null>"]){
//                NSLog(@"photo1 null");
//            }
//            if(respList.count==2){
//                item.photo2=[NSString stringWithFormat:@"%@",[[[respList[1] objectForKey:@"responsible"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
//                
//                item.photo1 = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion,[[[respList[1] objectForKey:@"responsible"] objectForKey:@"photo"]objectForKey:@"relativePath"]];
//    
//
//            }else{
//                item.photo2=@"";
//            }
//
//            [dataArray addObject:item];
//        }
//        
//        [weakSelf.tableView footerEndRefreshing];
//        [weakSelf.tableView headerEndRefreshing];
//        [weakSelf.tableView reloadData];
//        
//
//    } failed:^(NSObject *obj, BOOL isFinished) {
//        [SVProgressHUD showSimpleText:@"传参有误，请重试"];
//        [_tableView headerEndRefreshing];
//    } andKeyValuePairs:@"organizationBranchQuery.organizationID",self._id,@"activityQuery.pageNum",newPageIndex,@"organizationBranchQuery.dormant",@"2",nil];
//}
//

/**头部视图的名称**/
#pragma mark  tableView  section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.name;
}
#pragma mark - tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    Cell_Class * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_Class" owner:self options:nil]lastObject];;
    }
    
    Item_RC08 * item = [dataArray objectAtIndex:indexPath.row];
    cell.mainLabel.text = item.name;
    cell.petName1.text=item.petName1;
    cell.petName1.numberOfLines = 0;
      [cell.leftImageView setImageWithURL:[NSURL URLWithString:item.photo1] placeholderImage:kDefaultPic];
    if (item.isUnique == 0) {
        cell.petName2.text=item.petName2;
        cell.petName2.numberOfLines = 0;
        [cell.rightImageView setImageWithURL:[NSURL URLWithString:item.photo2] placeholderImage:kDefaultPic];
    }
  
    return cell;
}
#pragma mark - tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self saveDataWithIndex:indexPath.row];
    RegisterVC06 * registerVC06 = [[RegisterVC06 alloc]  initWithNibName:@"RegisterVC06" bundle:nil];
    Item_RC08 *item=[dataArray objectAtIndex:indexPath.row];
    registerVC06.class_Name=item.name;
    [userDefaults setObject:item._id forKey:@"classId"];
    [self.navigationController pushViewController:registerVC06 animated:YES];
}
#pragma mark - 保存数据
-(void)saveDataWithIndex:(int)index
{
    Item_RC08 * item = [self.dataArray objectAtIndex:index];
    
    NSLog(@"%@", item._id);
    
    _dm = [RegisterDataManager shareInstance];
    //保存班级id
    _dm.classID = item._id;
}
@end
