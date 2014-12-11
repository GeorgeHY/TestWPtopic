//
//  RegisterVC07.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-20.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RegisterVC07.h"
#import "Register07Cell.h"
#import "R07TableCellM.h"
#import "UIViewController+General.h"
#import "UIColor+AddColor.h"
#import "RegisterVC08.h"
#import "MJRefresh.h"
#import "AFN_HttpBase.h"
#import "GlobalKeys.h"
#import "SVProgressHUD.h"
#import "RegisterVC06.h"
#import "RegisterDataManager.h"

@interface RegisterVC07 ()<UISearchBarDelegate,UIAlertViewDelegate,UISearchDisplayDelegate>
{
    AFN_HttpBase * http;
    NSUserDefaults * userDefaults;
    NSArray *filterData;
    UISearchBar *_searchBar;
    int pageIndex;
    NSString * searchName;
    RegisterDataManager * _dm;
}
@property(nonatomic , strong) UISearchBar * searchF;

@property(nonatomic , strong) NSMutableArray * dateSource;
@property(nonatomic , strong) NSUserDefaults * ud;

@end

@implementation RegisterVC07

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        http=[[AFN_HttpBase alloc]init];
        self.dateSource = [[NSMutableArray alloc]  init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ud = [NSUserDefaults standardUserDefaults];
    userDefaults=[NSUserDefaults standardUserDefaults];
    _dm=[RegisterDataManager shareInstance];
    
    [self initLeftItem];
    
	[self createComponent];
    
    pageIndex =  1;
    
    [self httpRequestWithPage:pageIndex];
    
}
#pragma mark 头部刷新  下拉刷新
-(void)headerRereshing
{
    self.operaiton = 1;//刷新标志，1-刷新
    pageIndex = 1;
    
    [self httpRequestWithPage:pageIndex];
}
#pragma mark  脚部加载   上拉加载
-(void)footerRereshing
{
    
    R07TableCellM * item = [self.dateSource lastObject];
    
    if (item.isButtom == 1) {
        
        [self.tableview headerEndRefreshing];
        [self.tableview footerEndRefreshing];
        
        [SVProgressHUD showSuccessWithStatus:dTips_noMoreData];
        
        return;
        
    }
    self.operaiton = 2;//加载标志 2-加载
    pageIndex++;
    [self httpRequestWithPage:pageIndex];
}

-(void)httpRequestWithPage:(int)newPage{
    if (self.kind_Name.length==0){
        self.kind_Name=@"";
    }
    NSString * areaID=[userDefaults objectForKey:@"cityID"];
    NSLog(@"diqu=%@",areaID);
    NSString * d_ID=[userDefaults objectForKey:@"UD_logindict"];
    NSLog(@"d_ID=%@",d_ID);
    NSString * page = [NSString stringWithFormat:@"%d", newPage];
    
    if (self.operaiton == 1) {
        [self.dateSource removeAllObjects];
    }
    
    [http thirdRequestWithUrl:dUrl_PUB_1_3_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary* dicResult  = (NSDictionary *)obj;
        
        NSDictionary *valueDic=[dicResult  objectForKey:@"value"];
        
        NSString *sValue=[NSString stringWithFormat:@"%@",valueDic];
        if ([sValue isEqualToString:@"<null>"]) {
            // [SVProgressHUD showSimpleText:@"没有数据"];
            if (searchName.length==0) {
                searchName=@"幼儿园";
            }
            _dm.customKindergaten=searchName;
            _dm.kindgardenID=@"";
            _dm.kindergaten=@"";
            _dm.classID=@"";
            NSString * msg=[NSString stringWithFormat:@"您输入的‘%@’系统中尚未收录，我们会尽快进行收录，谢谢",searchName];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"重搜" otherButtonTitles:@"确定", nil];
            alert.delegate=self;
            alert.tag=10000;
            [alert show];
            [self.tableview headerEndRefreshing];
            [self.tableview footerEndRefreshing];
            [self.tableview reloadData];
            return;
        }
        NSArray * array  = [valueDic objectForKey:@"list"];
        if (array.count == 0) {
            [SVProgressHUD showSimpleText:dTips_noMoreData];
            [self.tableview headerEndRefreshing];
            [self.tableview footerEndRefreshing];
            [self.tableview reloadData];
            return;
        }
        
        for (NSDictionary * dict in array) {
            
            R07TableCellM * item = [[R07TableCellM alloc]init];
            item.isButtom = [[[dicResult objectForKey:@"value"] objectForKey:@"isButtom"]intValue];
            item.title = [dict objectForKey:@"name"];
            
            
        }
        
        for (int i=0; i<array.count; i++) {
            
            R07TableCellM * rm = [[R07TableCellM alloc]  init];
            NSDictionary * d1 = [array  objectAtIndex:i];
            
            //是否有下一页
            rm.isButtom = [[[dicResult objectForKey:@"value"] objectForKey:@"isButtom"]intValue];
            
            NSString  * name = [d1  objectForKey:@"name"];
            rm.title=name;
            _dm.customKindergaten=@"";
            _dm.kindergaten=name;
            if ([[d1 objectForKey:@"userInfo"]isKindOfClass:[NSNull class]]) {
                NSLog(@"空指针");
                rm.kindergarten_Id=@"";
                _dm.kindgardenID=@"";
            }else{
                NSString * _id=[[d1 objectForKey:@"userInfo"]objectForKey:@"id"];
                rm.kindergarten_Id=_id;
                _dm.kindgardenID=_id;
                
            }
            [self.dateSource addObject:rm];
        }
        
        [self.tableview headerEndRefreshing];
        [self.tableview footerEndRefreshing];
        [self.tableview reloadData];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:dTips_requestError];
        
    } andKeyValuePairs:@"kindergartenQuery.longitude",@"117.187431",@"kindergartenQuery.latitude",@"39.187626",@"kindergartenQuery.name",self.kind_Name,@"kindergartenQuery.pageNum",page,@"kindergartenQuery.zoneAreaID",areaID, nil];
    
}
#pragma mark 在这里处理UIAlertView中的按钮被单击的事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    RegisterVC06 *vc=[[RegisterVC06 alloc]init];
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self.navigationController pushViewController:vc animated:YES];
            break;
        default: break;
    }
}
#pragma mark 建立刷新
-(void)setupRefresh
{
    [self.tableview addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableview headerBeginRefreshing];
    
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.kind_Name=searchBar.text;
    searchName=searchBar.text;
    [self setupRefresh];
    [_searchBar resignFirstResponder];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_searchBar resignFirstResponder];
}

-(void) createComponent{
    
    if(IOS7)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    self.navigationItem.title = @"附近的幼儿园";
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 44)];
    _searchBar.placeholder = @"没找到？可以在这里搜索";
    _searchBar.delegate=self;
    [self.view addSubview:_searchBar];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, _searchBar.frame.size.height + _searchBar.frame.origin.y, kMainScreenWidth, kMainScreenHeight - 44 - 44) style:UITableViewStylePlain];
    
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.scrollEnabled = YES;
    [self.view addSubview:self.tableview];
    [self setupRefresh:self.tableview];
    UIView *v=[[UIView alloc]init];
    self.tableview.tableFooterView=v;
}
//监听textfiled的变化
- (void) textFieldDidChange:(id) sender {
    UITextField *_field = (UITextField *)sender;
    NSLog(@"%@",[_field text]);
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"%@",_field.text];
    [self.dateSource filteredArrayUsingPredicate:pre];

}

//制定个性标题，这里通过UIview来设计标题，功能上丰富，变化多。
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *bagV=[[UIView alloc]init];
//    bagV.frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
//    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 44)];
//    _searchBar.placeholder = @"没找到？可以在这里搜索";
//    _searchBar.delegate=self;
//    [bagV addSubview:_searchBar];
//    return bagV;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateSource.count;
}

-(void)saveDataWithIndex:(int)index
{
    
    R07TableCellM * item = [self.dateSource objectAtIndex:index];
    
    //保存幼儿园id
    _dm.kindgardenID = item.kindergarten_Id;


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    // r8.view.backgroundColor=[UIColor whiteColor];
    //kindergarten_Id
    R07TableCellM * rm = [self.dateSource objectAtIndex:indexPath.row];
    
    RegisterVC08 * r8 = [[RegisterVC08 alloc]  init];
    
    r8._id=rm.kindergarten_Id;
    [userDefaults setObject:rm.kindergarten_Id forKey:@"kindergardenID"];
    r8.name=rm.title;
    [userDefaults setObject:rm.title forKey:@"kinggardenName"];
    NSLog(@"xuanzhongName=%@",r8.name);
    //[_searchBar removeFromSuperview];
    
    [self saveDataWithIndex:indexPath.row];
    [self.navigationController pushViewController:r8 animated:YES];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    Register07Cell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[Register07Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    R07TableCellM * rm = [self.dateSource objectAtIndex:indexPath.row];
    cell.nameLable.text = rm.title;
   
    return cell;
}

#pragma mark - 返回
-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
