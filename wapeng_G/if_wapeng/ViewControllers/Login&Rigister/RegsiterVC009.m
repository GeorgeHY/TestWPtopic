//
//  Item_RegsiterVC009.m
//  if_wapeng
//
//  Created by iwind on 14-10-24.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RegsiterVC009.h"
#import "MJRefresh.h"
#import "Cell_RegisterVC009.h"
#import "GlobalKeys.h"
#import "UIViewController+General.h"
#import "AFN_HttpBase.h"
#import "SVProgressHUD.h"
#import "RegisterDataManager.h"
#import "Item_RegisterM009.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@interface RegsiterVC009 ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray *_dataSourceArr;
    NSMutableArray *_dataSourceArrNo2;
    NSMutableArray *_dataSourceArrNo3;
    UILabel *tLB;
    Cell_RegisterVC009 *_cell;
    NSMutableArray* checkedIndexArr;
    NSUserDefaults *userdefaults;
    AFN_HttpBase * http;
    RegisterDataManager *_dm;
    int pageIndex;
    NSString * uuid;
    NSIndexPath *_indexPath;
}
@end

@implementation RegsiterVC009
BOOL flag=YES;
- (void)viewWillAppear:(BOOL)animated
{
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"附近的邻居";
    userdefaults=[NSUserDefaults standardUserDefaults];
    http=[[AFN_HttpBase alloc]init];
    _dm=[RegisterDataManager shareInstance];
    _dataSourceArr=[[NSMutableArray alloc]init];
    _dataSourceArrNo2=[[NSMutableArray alloc]init];
    _dataSourceArrNo3=[[NSMutableArray alloc]init];
    [self httpRequestDidNetWorking];
    uuid=[userdefaults objectForKey:@"UD_uuid"];
    pageIndex =  1;
    
    UIImage *backImage = [UIImage imageNamed:@"public_back"];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"public_back_hightLight"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(navItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = left;
    
    
    
    UITableView * tableView=[[UITableView alloc]init];
    tableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100);
    //tableView.backgroundColor=[UIColor purpleColor];
    [self.view addSubview:tableView];
    _tableView=tableView;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _dataSourceArr=[[NSMutableArray alloc]init];
    checkedIndexArr=[[NSMutableArray alloc]init];
    //[_tableView reloadData];
    
    //    UIView *v=[[UIView alloc]init];
    //    _tableView.tableFooterView=v;
    UIButton *btn01=[UIButton buttonWithType:UIButtonTypeCustom];
    btn01.frame=CGRectMake(0,tableView.frame.size.height, self.view.frame.size.width*0.5, 40);
    [btn01 setTitle:@"全部选择" forState:UIControlStateNormal];
    //btn01.backgroundColor=[UIColor blueColor];
    [btn01 setBackgroundImage:[UIImage imageNamed:@"guanzhu.png"] forState:UIControlStateNormal];
    [btn01 addTarget:self action:@selector(allSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn01];
    
    UIButton *btn02=[UIButton buttonWithType:UIButtonTypeCustom];
    btn02.frame=CGRectMake(btn01.frame.size.width,tableView.frame.size.height, self.view.frame.size.width*0.5, 40);
    [btn02 setTitle:@"下一步" forState:UIControlStateNormal];
    //btn02.backgroundColor=[UIColor blueColor];
    [btn02 setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [btn02 addTarget:self action:@selector(navNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn02];
    
    
}
#pragma mark 进入主页面
-(void)navNext
{
    NSLog(@"goto next");
    AppDelegate * app = [AppDelegate shareInstace];
    app.loginDict=[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"ds", nil];
    [app  showViewController:showVCTypeTab];
}
-(void)setupRefresh{
    NSLog(@"setupRefresh!!!");
    //添加头部控件的方法
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_tableView headerBeginRefreshing];
    //添加尾部控件的方法
    // [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
-(void)returnPhoneNum:(NSNotification *)sender
{
    NSLog(@"returnPhoneNum   send=%@",sender.object);
}
#pragma mark 调用登录接口 获取D_ID
-(void)httpRequestDidNetWorking
{
    NSLog(@"httpRequestDidNetWorking");
    NSString *phoneNum=_dm.phoneNum;
    NSLog(@"phoneNum=%@",phoneNum);
    //@"accountQuery.userName",@"30000000001",@"accountQuery.password",@"123",@"accountQuery.deviceCode",@"12344"
    //@"accountQuery.userName",_dm.phoneNum,@"accountQuery.password",@"654321",@"accountQuery.deviceCode",_dm.uuid,
    [http thirdRequestWithUrl:dUrl_ACC_1_1_3 succeed:^(NSObject *obj, BOOL isFinished) {
        NSLog(@"login succ!!!");
        NSDictionary *dicResult=(NSDictionary *)obj;
        NSDictionary *valueDic=[dicResult objectForKey:@"value"];
        NSString *vStr=[NSString stringWithFormat:@"%@",valueDic];
        [userdefaults setObject:@"654321" forKey:@"pwd"];
        if ([vStr isEqualToString:@"null"]) {
            [SVProgressHUD showSimpleText:@"没有数据"];
            return;
        }
        NSString *d_ID=[NSString stringWithFormat:@"%@",[valueDic objectForKey:@"d_ID"]];
        NSLog(@"d_ID=%@",d_ID);
        if ([d_ID isEqualToString:@"null"]) {
            [SVProgressHUD showSimpleText:@"没有数据"];
            return;
        }else{
            self.d_ID=d_ID;
            _dm.d_ID=d_ID;
            [userdefaults setObject:d_ID forKey:UD_RegisterSucc_D_ID];
            [userdefaults setObject:d_ID forKey:UD_LoginSucc_D_ID];
            [userdefaults setObject:@"" forKey:@"pwd"];
            [self setupRefresh];
        }
    } failed:^(NSObject *obj, BOOL isFinished) {
        NSLog(@"failed");
    }andKeyValuePairs:@"accountQuery.userName",_dm.phoneNum,@"accountQuery.password",@"654321",@"accountQuery.deviceCode",_dm.uuid, nil];
    
    
}
#pragma mark 头部刷新  下拉刷新
-(void)headerRereshing
{
    NSLog(@"headerRequest!!");
    self.operaiton = 1;//刷新标志，1-刷新
    pageIndex = 1;
    
    [self httpRequestWithPage:pageIndex];
}
-(void)footerRereshing
{
    self.operaiton = 2;//加载标志 2-加载
    pageIndex++;
    
    // [self httpRequestWithPage:pageIndex];
}
#pragma mark 请求第一组数据  与宝宝同班
-(void)httoRequestDataNoOne:(NSString *)page
{
    
    [http thirdRequestWithUrl:dUrl_OSM_1_1_2 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * root = (NSDictionary *)obj;
        
        NSArray * list = [[root objectForKey:@"value"]objectForKey:@"list"];
        if (list.count==0) {
            return;
        }
        NSString * str=[NSString stringWithFormat:@"%@",list];
        if ([str isEqualToString:@"null"]) {
            return;
        }
        for (NSDictionary * dict in list) {
            
            Item_RegisterM009 * item = [[Item_RegisterM009 alloc]init];
            NSArray * arr = [dict objectForKey:@"childInfoList"];
            NSString * arrStr=[NSString stringWithFormat:@"%@",arr];
            if ([arrStr isEqualToString:@"null"]) {
                return;
            }
            NSDictionary * new = arr[0];
            NSString *name =[NSString stringWithFormat:@"%@",[new objectForKey:@"name"]];
            if ([name isEqualToString:@"<null>"]) {
                item.name1=@"";
            }else{
                item.name1=name;
            }
            NSString *photo=[NSString stringWithFormat:@"%@",[[dict objectForKey:@"photo"] objectForKey:@"relativePath"]];
            if ([photo isEqualToString:@"<null>"]) {
                item.photo1=@"";
            }else{
                item.photo1 = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion,[[dict objectForKey:@"photo"] objectForKey:@"relativePath"]];
            }
            item.isSelected1 = NO;
            [_dataSourceArr addObject:item];
        }
        NSIndexSet * index = [NSIndexSet indexSetWithIndex:0];
        [_tableView reloadSections:index withRowAnimation:UITableViewRowAnimationRight];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    } failed:^(NSObject *obj, BOOL isFinished) {
        NSLog(@"failed--");
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    } andKeyValuePairs:@"D_ID",self.d_ID,@"userInfoQuery.pageNum",page, nil];
    
}
#pragma mark 住在荣迁东里附近的邻居
-(void)httoRequestDataNoTwo:(NSString *)page
{
    
    [http thirdRequestWithUrl:dUrl_OSM_1_1_4 succeed:^(NSObject *obj, BOOL isFinished) {
        NSDictionary * root = (NSDictionary *)obj;
        NSString * str=[NSString stringWithFormat:@"%@", [[root objectForKey:@"value"]objectForKey:@"list"]];
        if(str.length==0){
            NSLog(@"list什么都没有");
            return;
        }
        NSArray * list=[[NSArray alloc]init];
        list = [[root objectForKey:@"value"]objectForKey:@"list"];
        NSString * countStr=[NSString stringWithFormat:@"%@",list];
        if ([countStr isEqualToString:@"null"] ) {
            NSLog(@"list failed");
            return ;
        }
        NSLog(@"第二list长度 %ld",list.count);
        for (NSDictionary * dict in list) {
            Item_RegisterM009 * item = [[Item_RegisterM009 alloc]init];
            
            NSArray * arr = [dict objectForKey:@"childInfoList"];
            NSString * arrStr=[NSString stringWithFormat:@"%@",arr];
            if ([arrStr isEqualToString:@"<null>"]) {
                NSLog(@"空指针");
                item.name1=@"";
                item.photo1=@"";
                item.isSelected1 = NO;
                //return;
            }else{
                if (!arr) {
                    //return;
                    NSLog(@"arr是空的");
                    item.name1=@"";
                    item.photo1=@"";
                }
                if(arr.count==1){
                    NSDictionary * new = arr[0];
                    NSString *name=[NSString stringWithFormat:@"%@",[new objectForKey:@"name"]];
                    if ([name isEqualToString:@"<null>"]) {
                        item.name1=@"";
                    }else{
                        item.name1=name;
                    }
                }else{
                    item.name1=@"";
                }
                item.isSelected1 = NO;
                if([[dict objectForKey:@"photo"]isKindOfClass:[NSNull class]] )
                {
                    NSLog(@"空指针");
                    item.photo1=@"";
                    item.name1=@"";
                }
                else{
                    item.photo1 = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion,[[dict objectForKey:@"photo"] objectForKey:@"relativePath"]];
                }
            }
            [_dataSourceArrNo2 addObject:item];
            
        }
        
        NSLog(@"countNo2=%u",_dataSourceArrNo2.count);
        // [_tableView reloadData];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        NSIndexSet * index = [NSIndexSet indexSetWithIndex:1];
        [_tableView reloadSections:index withRowAnimation:UITableViewRowAnimationLeft];
    } failed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSimpleText:@"请求错误"];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    } andKeyValuePairs:@"D_ID",_dm.d_ID,@"userInfoQuery.searchType",@"1",@"userInfoQuery.longitude",@"117.187441",@"userInfoQuery.latitude",@"39.187636",@"userInfoQuery.generalTypeID",@"1",@"userInfoQuery.disNo",@"3",@"userInfoQuery.startIndex",@"1",@"userInfoQuery.keyWord",@"",nil];
    
    
    
    
}
#pragma mark 获取在同一医院出生的宝宝邻居
-(void)httoRequestDataNoThree:(NSString *)page
{
    /*   for(int i=0;i<3;i++)
     {
     Item_RegisterM009 * item=[[Item_RegisterM009 alloc]init];
     item.isSelected1=NO;
     [_dataSourceArrNo3 addObject:item];
     }
     */
    [_tableView headerEndRefreshing];
    [_tableView footerEndRefreshing];
    //  NSIndexSet * index = [NSIndexSet indexSetWithIndex:2];
    // [_tableView reloadSections:index withRowAnimation:UITableViewRowAnimationRight];
    
}
#pragma mark 登陆接口调用成功后，刷新所有数据
-(void)httpRequestWithPage:(int) newPage
{
    NSString * page = [NSString stringWithFormat:@"%d", newPage];
    if (self.operaiton == 1)
    {
        NSLog(@"刷新");
        [_dataSourceArr removeAllObjects];
        [_dataSourceArrNo2 removeAllObjects];
        [_dataSourceArrNo3 removeAllObjects];
    }
    if (self.d_ID.length==0)
    {
        self.d_ID=@"";
    }
    
    [self httoRequestDataNoOne:page];
    
    if (_dm.d_ID.length==0)
    {
        [SVProgressHUD showSimpleText:@"请填写d_ID"];
        return;
    }
    
    [self httoRequestDataNoTwo:page];
    [self httoRequestDataNoThree:page];
    
}
-(void)navItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 全部选择
-(void)allSelect
{
    //    flag=NO;
    
    for (Item_RegisterM009 * model in _dataSourceArr) {
        
        model.isSelected1 = YES;
        //        model.isSelected2 = YES;
        //        model.isSelected3 = YES;
    }
    NSIndexSet * index = [NSIndexSet indexSetWithIndex:0];
    [_tableView reloadSections:index withRowAnimation:UITableViewRowAnimationNone];
    for (Item_RegisterM009 * model in _dataSourceArrNo2) {
        
        model.isSelected1 = YES;
        //        model.isSelected2 = YES;
        //        model.isSelected3 = YES;
    }
    NSIndexSet * index2 = [NSIndexSet indexSetWithIndex:1];
    [_tableView reloadSections:index2 withRowAnimation:UITableViewRowAnimationNone];
    for (Item_RegisterM009 * model in _dataSourceArrNo3) {
        
        model.isSelected1 = YES;
        //        model.isSelected2 = YES;
        //        model.isSelected3 = YES;
    }
    NSIndexSet * index3 = [NSIndexSet indexSetWithIndex:2];
    [_tableView reloadSections:index3 withRowAnimation:UITableViewRowAnimationNone];
    //[_tableView reloadData];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    flag=YES;
    [_tableView reloadData];
}
//#pragma mark 建立刷新功能
//-(void)setUpRefresh{
//
//    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [_tableView headerBeginRefreshing];
//    //[self.tableview addFooterWithTarget:self action:@selector(footerRereshing)];
//}
#pragma mark   tableView  delegate
//每个section显示的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * childName=[NSString stringWithFormat:@"他们的宝宝与%@同班",_dm.childNickName ];
    switch (section) {
            
        case 0:
            
            return childName;
            
        case 1:
            
            return @"住在荣迁东里附近的宝宝";
            
        case 2:
            
            return [NSString stringWithFormat:@"他们的宝宝同日与%@在同一医院出生",_dm.childNickName];
        default:
            return nil;
            
    }
    
    
    
}
#pragma mark tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
            
        case 0:
            
            return  [_dataSourceArr count] % 3 == 0 ? _dataSourceArr.count / 3 : _dataSourceArr.count / 3 + 1;
            
            break;
            
        case 1:
            
            return  [_dataSourceArrNo2 count] % 3 == 0 ? _dataSourceArrNo2.count / 3 : _dataSourceArrNo2.count / 3 + 1;
            
            break;
        case 2:
            
            return  1;
            
            break;
        default:
            
            return 0;
            
            break;
            
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifier=@"cell";
    Cell_RegisterVC009 *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_RegisterVC009" owner:self options:nil]lastObject];
        
    }
    
    [cell.myIcon01 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [cell.myIcon02 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
    [cell.myIcon03 addTarget:self action:@selector(btn3:) forControlEvents:UIControlEventTouchUpInside];
    //int yushu;
    NSUInteger section=indexPath.section;
    　　if (section==0)
    {
        cell.myIcon01.tag=indexPath.row+100;
        cell.myIcon02.tag=indexPath.row+101;
        cell.myIcon03.tag=indexPath.row+102;
        [self configureCell:cell atIndexPath:indexPath WithArr:_dataSourceArr];
        //       NSIndexSet * index = [NSIndexSet indexSetWithIndex:0];
        //        [_tableView reloadSections:index withRowAnimation:UITableViewRowAnimationNone];
    }
    if (section==1) {
        cell.myIcon01.tag=indexPath.row+1200;
        cell.myIcon02.tag=indexPath.row+1201;
        cell.myIcon03.tag=indexPath.row+1202;
        [self configureCell:cell atIndexPath:indexPath WithArr:_dataSourceArrNo2];
        //          NSIndexSet * index = [NSIndexSet indexSetWithIndex:1];
        //        [_tableView reloadSections:index withRowAnimation:UITableViewRowAnimationNone];
    }
    if (section==2) {
        cell.myIcon01.tag=indexPath.row+1800;
        cell.myIcon02.tag=indexPath.row+1801;
        cell.myIcon03.tag=indexPath.row+1802;
        //[self configureCell:cell atIndexPath:indexPath WithArr:_dataSourceArrNo3];
        
        //           NSIndexSet * index = [NSIndexSet indexSetWithIndex:2];
        //                [_tableView reloadSections:index withRowAnimation:UITableViewRowAnimationNone];
    }
    
    return cell;
}
#pragma mark 构建cell
-(void)configureCell:(Cell_RegisterVC009 *)cell atIndexPath:(NSIndexPath *)indexPath WithArr:(NSMutableArray *)arr
{
    if (arr.count==0) {
        return;
    }
    int yushu;
    yushu = arr.count % 3;
    
    int chushu = 0;
    
    chushu = arr.count / 3;
    
    if (yushu != 0) {
        
        chushu = arr.count / 3 + 1;
    }
    
    if (yushu == 1) {
        
        
        if (chushu != indexPath.row + 1) {
            
            Item_RegisterM009 * item1 = arr[indexPath.row * 3];
            if (item1.isSelected1==YES) {
                cell.myIcon01.backgroundColor=[UIColor clearColor];
                [cell.myIcon01 setBackgroundImage:[UIImage imageNamed:@"Reg_Checkmark.png"] forState:UIControlStateNormal];
            }else{
                cell.myIcon01.backgroundColor=[UIColor greenColor];
            }
            cell.myLabel01.text = item1.name1;
            Item_RegisterM009 * item2 = arr[indexPath.row * 3 + 1];
            cell.myLabel02.text = item2.name1;
            if (item2.isSelected1==YES) {
                cell.myIcon02.backgroundColor=[UIColor clearColor];
                [cell.myIcon02 setBackgroundImage:[UIImage imageNamed:@"Reg_Checkmark.png"] forState:UIControlStateNormal];
            }else{
                cell.myIcon02.backgroundColor=[UIColor greenColor];
            }
            
            Item_RegisterM009 * item3 = arr[indexPath.row * 3 + 2];
            if (item3.isSelected1==YES) {
                cell.myIcon03.backgroundColor=[UIColor clearColor];
                [cell.myIcon03 setBackgroundImage:[UIImage imageNamed:@"Reg_Checkmark.png"] forState:UIControlStateNormal];
            }else{
                cell.myIcon03.backgroundColor=[UIColor greenColor];
            }
            cell.myLabel03.text = item3.name1;
        }else{
            cell.myIcon02.hidden=YES;
            cell.myIcon02.enabled=NO;
            cell.myIcon03.hidden=YES;
            cell.myIcon03.enabled=NO;
            cell.myImageView02.hidden=YES;
            cell.myImageView02.userInteractionEnabled=NO;
            cell.myImageView03.hidden=YES;
            cell.myImageView03.userInteractionEnabled=NO;
            cell.myLabel02.hidden=YES;
            cell.myLabel03.hidden=YES;
            Item_RegisterM009 * item1 = arr[indexPath.row * 3];
            cell.myLabel01.text = item1.name1;
            if (item1.isSelected1==YES) {
                cell.myIcon01.backgroundColor=[UIColor clearColor];
                [cell.myIcon01 setBackgroundImage:[UIImage imageNamed:@"Reg_Checkmark.png"] forState:UIControlStateNormal];
            }else{
                cell.myIcon01.backgroundColor=[UIColor greenColor];
            }
            
        }
    }
    
    if (yushu == 2) {
        
        if (chushu != indexPath.row + 1) {
            
            Item_RegisterM009 * item1 = arr[indexPath.row * 3];
            if (item1.isSelected1==YES) {
                cell.myIcon01.backgroundColor=[UIColor clearColor];
                [cell.myIcon01 setBackgroundImage:[UIImage imageNamed:@"Reg_Checkmark.png"] forState:UIControlStateNormal];
            }else{
                cell.myIcon01.backgroundColor=[UIColor greenColor];
            }
            
            cell.myLabel01.text = item1.name1;
            Item_RegisterM009 * item2 = arr[indexPath.row * 3 + 1];
            if (item2.isSelected1==YES) {
                cell.myIcon02.backgroundColor=[UIColor clearColor];
                [cell.myIcon02 setBackgroundImage:[UIImage imageNamed:@"Reg_Checkmark.png"] forState:UIControlStateNormal];
            }else{
                cell.myIcon02.backgroundColor=[UIColor greenColor];
            }
            
            cell.myLabel02.text = item2.name1;
            Item_RegisterM009 * item3 = arr[indexPath.row * 3 + 2];
            if (item3.isSelected1==YES) {
                cell.myIcon03.backgroundColor=[UIColor clearColor];
                [cell.myIcon03 setBackgroundImage:[UIImage imageNamed:@"Reg_Checkmark.png"] forState:UIControlStateNormal];
            }else{
                cell.myIcon03.backgroundColor=[UIColor greenColor];
            }
            cell.myLabel03.text = item3.name1;
        }else{
            cell.myIcon03.enabled=NO;
            cell.myImageView03.userInteractionEnabled=NO;
            cell.myImageView03.hidden=YES;
            cell.myLabel03.hidden=YES;
            cell.myIcon03.hidden=YES;
            Item_RegisterM009 * item1 = arr[indexPath.row * 3];
            cell.myLabel01.text = item1.name1;
            Item_RegisterM009 * item2 = arr[indexPath.row * 3 + 1];
            cell.myLabel02.text = item2.name1;
        }
        
    }
    if (yushu == 0) {
        Item_RegisterM009 * item1 = arr[indexPath.row * 3];
        if (item1.isSelected1==YES) {
            cell.myIcon01.backgroundColor=[UIColor clearColor];
            [cell.myIcon01 setBackgroundImage:[UIImage imageNamed:@"Reg_Checkmark.png"] forState:UIControlStateNormal];
        }else{
            cell.myIcon01.backgroundColor=[UIColor greenColor];
        }
        
        cell.myLabel01.text = item1.name1;
        Item_RegisterM009 * item2 = arr[indexPath.row * 3 + 1];
        if (item2.isSelected1==YES) {
            cell.myIcon02.backgroundColor=[UIColor clearColor];
            [cell.myIcon02 setBackgroundImage:[UIImage imageNamed:@"Reg_Checkmark.png"] forState:UIControlStateNormal];
        }else{
            cell.myIcon02.backgroundColor=[UIColor greenColor];
        }
        
        cell.myLabel02.text = item2.name1;
        Item_RegisterM009 * item3 = arr[indexPath.row * 3 + 2];
        if (item3.isSelected1==YES) {
            cell.myIcon03.backgroundColor=[UIColor clearColor];
            [cell.myIcon03 setBackgroundImage:[UIImage imageNamed:@"Reg_Checkmark.png"] forState:UIControlStateNormal];
        }else{
            cell.myIcon03.backgroundColor=[UIColor greenColor];
        }
        
        cell.myLabel03.text = item3.name1;
    }
    
}
-(void)configureCell:(Cell_RegisterVC009 *)cell atIndexPath:(NSIndexPath *)indexPath Withflag:(bool) flag
{}
#pragma mark cell中btn的点击
-(void)btn1:(UIButton *)btn
{
    /*    Item_RegisterM009 *model=[[Item_RegisterM009 alloc]init];
     if(btn.tag>=100){
     model = _dataSourceArr[(btn.tag - 100)*3];
     NSLog(@"100");
     }
     if (btn.tag>=1200) {
     model = _dataSourceArrNo2[(btn.tag - 1200)*3];
     model.isSelected1 = !model.isSelected1;
     NSLog(@"1200");
     }
     if (btn.tag>=1800) {
     model = _dataSourceArrNo3[(btn.tag - 1800)*3];
     NSLog(@"1800");
     model.isSelected1 = !model.isSelected1;
     }
     // model.isSelected1 = !model.isSelected1;
     [_tableView reloadData];
     */
    NSLog(@"btn1");
}
-(void)btn2:(UIButton *)btn {
    Item_RegisterM009 *model=[[Item_RegisterM009 alloc]init];
    //    if(btn.tag>100){
    //        model = _dataSourceArr[(btn.tag - 101)*3+1];
    //    }
    //    if(btn.tag>1200){
    //        model = _dataSourceArrNo2[(btn.tag - 1201)*3+1];
    //    }
    //    if(btn.tag>1800){
    //        model = _dataSourceArrNo3[(btn.tag - 1801)*3+1];
    //    }
    model.isSelected1 = !model.isSelected1;
    NSLog(@"btn2");
    [_tableView reloadData];
    
}
-(void)btn3:(UIButton *)btn {
    //    Item_RegisterM009 *model=[[Item_RegisterM009 alloc]init];
    //    if(btn.tag>100){
    //        model = _dataSourceArr[(btn.tag - 102)*3+1];
    //    }
    //    if(btn.tag>1200){
    //        model = _dataSourceArrNo2[(btn.tag - 1202)*3+1];
    //    }
    //    if(btn.tag>1800){
    //        model = _dataSourceArrNo3[(btn.tag - 1802)*3+1];
    //    }
    //    model.isSelected1 = !model.isSelected1;
    //    NSLog(@"btn3 sel=%d",model.isSelected1);
    //    [_tableView reloadData];
    //
    NSLog(@"btn3");
}
@end
