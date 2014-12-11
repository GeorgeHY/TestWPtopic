//
//  MyMailVC.m
//  if_wapeng
//
//  Created by 早上好 on 14-10-27.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MyMailVC.h"
#import "UIViewController+General.h"
#import "Cell_Mail.h"
#import "Cell_MyMail.h"
#import "Item_MyMailEntity.h"
#import "MyMailTask.h"
#import "AppDelegate.h"
#import "HMSegmentedControl.h"
#import "UIImageView+WebCache.h"
#import "UIView+WhenTappedBlocks.h"
@interface MyMailVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic , assign) int pageIndex;
@property (nonatomic, assign) BOOL isRefresh;//yes下拉no上啦
@property (nonatomic, assign) int isButtom;
@property(nonatomic , strong)HMSegmentedControl *segmented;
@end

@implementation MyMailVC
{
    NSString * D_ID;
    AppDelegate *app;
    AFN_HttpBase * http;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"私信";
        http = [[AFN_HttpBase alloc]init];
        self.leftDataArray = [[NSMutableArray alloc]init];
        self.rightDataArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.pageIndex = 1;

    app = [AppDelegate shareInstace];
    D_ID = [app.loginDict  objectForKey:@"d_ID"];
    [self initLeftItem];
    [self createComponet];
 
    
    [self startHttpRequestWithType:self.letterStyle pageNum:self.pageIndex];
    
}
-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)viewWillAppear:(BOOL)animated
{
     app.mTbc.mainView.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    app.mTbc.mainView.hidden =NO;
}
#pragma  mark 网络请求
-(void)startHttpRequestWithType:(int)type pageNum:(int)pageNum
{
    
    NSString * url = nil;
    
    __weak NSMutableArray * temp = nil;
    
    __weak UITableView * tempTableVeiw = nil;
    
    switch (self.letterStyle) {
        case letterLeftStyle:
        {
            url = P2P_1_1_1;
            temp = self.leftDataArray;
            tempTableVeiw = self.leftTableView;
        }
            break;
        case letterRightStyle:
        {
            url = P2P_1_1_2;
            temp = self.rightDataArray;
            tempTableVeiw = self.rightTableView;
        }
            break;
        default:
            break;
    }
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSString * pageStr = [NSString stringWithFormat:@"%d", pageNum];
    
    NSDictionary * postDict = [[NSDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", pageStr , @"letterQuery.pageNum", nil];
    
    [http sixReuqestUrl:url postDict:postDict succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
//        weakSelf.segmented.enabled = NO;
//        self.isLoadData = YES;
        
        if (self.isRefresh == YES) {
            
            [temp removeAllObjects];
        }
        NSDictionary * root =  (NSDictionary *)obj;

        if (isNotNull([root objectForKey:@"value"])) {
            
            if (isNotNull([[root objectForKey:@"value"] objectForKey:@"list"])) {
                
                NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
                
                for (NSDictionary * dict in list) {
                    
                    Item_MyMailEntity * item = [[Item_MyMailEntity alloc]init];
                    item.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"] intValue];
                    
                    NSLog(@"%d", item.isButtom);
                    
                    NSArray * letterList = [dict objectForKey:@"letterList"];
                    NSDictionary * newDict = [letterList lastObject];
                    item.content = [newDict objectForKey:@"content"];
                    item.createTime = [newDict objectForKey:@"createTime"];
                    item.read = [[dict objectForKey:@"read"]intValue];
                    item.petName = kNullData;
                    if (isNotNull([[dict objectForKey:@"sender"] objectForKey:@"petName"])) {
                        item.petName = [[dict objectForKey:@"sender"] objectForKey:@"petName"];
                    }
                    
                    
                    item.relativePath = kNullData;
                    if (isNotNull([dict objectForKey:@"photo"])) {
                        if (isNotNull([[dict objectForKey:@"photo"] objectForKey:@"relativePath"])) {
                            item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion,[[dict objectForKey:@"photo"] objectForKey:@"relativePath"]];
                        }
                    }
                    
                    [temp addObject:item];
                }

            }
        }
        
        [tempTableVeiw reloadData];
        [tempTableVeiw headerEndRefreshing];
        [tempTableVeiw footerEndRefreshing];
    } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        
    }];
  
}

#pragma  mark - 下拉刷新
-(void)headerRereshing
{
    self.isRefresh = YES;
    self.pageIndex = 1;
    
    [self startHttpRequestWithType:self.letterStyle pageNum:self.pageIndex];
    
}
#pragma mark  -上拉加载更多
-(void)footerRereshing
{
    self.isRefresh = NO;
    NSMutableArray * temp = nil;

    switch (self.letterStyle) {
        case letterLeftStyle:
        {
            temp = self.leftDataArray;
        }
            break;
        case letterRightStyle:
        {

            temp = self.rightDataArray;
        }
            break;
        default:
            break;
    }
    Item_MyMailEntity * item = [[Item_MyMailEntity alloc]init];
    
    if (item.isButtom == YES) {
        
        [SVProgressHUD showSuccessWithStatus:dTips_noMoreData];
        
        return;
    }
    
    self.pageIndex++;
    
    [self startHttpRequestWithType:self.letterStyle pageNum:self.pageIndex];
    
}

#pragma mark -创建 UI
-(void)createComponet{
    
    //两个tableView的背景view
    UIScrollView * bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44 - 49)];
    bgScrollView.contentSize = CGSizeMake(kMainScreenWidth * 2, kMainScreenHeight - 44 - 49);
    bgScrollView.pagingEnabled = YES;
    bgScrollView.bounces = NO;
    [self.view addSubview:bgScrollView];
    
    NSArray * array = @[@"我的熟人私信",@"我的陌生人私信"];
    self.segmented = [[HMSegmentedControl alloc]  initWithSectionTitles:array];

    self.segmented.selectionIndicatorColor = [UIColor redColor];
    self.segmented.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    [self.segmented setSelectedTextColor:[UIColor redColor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ]];
    self.segmented.selectionStyle = HMSegmentedControlSelectionStyleBox;
    [self.segmented setFont:[UIFont systemFontOfSize:14]];
    __weak MyMailVC * weakSelf = self;
    
    __weak UIScrollView * temp = bgScrollView;
    
    [self.segmented setIndexChangeBlock:^(NSInteger index) {
        switch (index) {
            case 0:
            {
                CGRect frame = weakSelf.segmented.frame;
                frame.origin.x = 0;
                
                temp.scrollEnabled = YES;
                [UIView animateWithDuration:0.3 animations:^{
                    temp.contentOffset = CGPointMake(0, 0);
                    weakSelf.segmented.frame = frame;
                    temp.scrollEnabled = NO;
                }];
                
                weakSelf.pageIndex = 1;
                
                weakSelf.letterStyle = letterLeftStyle;
                
                [weakSelf.leftTableView headerBeginRefreshing];
                
            }
                break;
            case 1:
            {
                CGRect frame = weakSelf.segmented.frame;
                frame.origin.x = kMainScreenWidth;
                
                temp.scrollEnabled = YES;
                [UIView animateWithDuration:0.3 animations:^{
                   temp.contentOffset = CGPointMake(kMainScreenWidth, 0);
                    weakSelf.segmented.frame = frame;
                    temp.scrollEnabled = NO;
                }];
                
                weakSelf.pageIndex = 1;
                
                weakSelf.letterStyle = letterRightStyle;
                [weakSelf.rightTableView headerBeginRefreshing];
            }
                break;
            default:
                break;
        }
    }];
    [bgScrollView addSubview:self.segmented];
    
    
    //粘贴左table
    self.leftTableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, 40,kMainScreenWidth,kMainScreenHeight - 44)];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    [bgScrollView addSubview:self.leftTableView];

    [self setupRefresh:self.leftTableView];
    
    //粘贴右table
    self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(kMainScreenWidth, 40, kMainScreenWidth, kMainScreenHeight - 44) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    [bgScrollView addSubview:self.rightTableView];
    [self setupRefresh:self.rightTableView];
}

#pragma mark tableView delegat
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 102;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSMutableArray * temp;
    
    switch (self.letterStyle) {
        case letterLeftStyle:
        {
            temp = self.leftDataArray;
        }
            break;
        case letterRightStyle:
        {
            temp = self.rightDataArray;
        }
            break;
        default:
            break;
    }
    return temp.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    Cell_Mail *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[Cell_Mail alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    NSMutableArray * temp;
    
    switch (self.letterStyle) {
        case letterLeftStyle:
        {
            temp = self.leftDataArray;
            
        
        }
            break;
        case letterRightStyle:
        {

            temp = self.rightDataArray;
        
          
        }
            break;
        default:
            break;
    }
    
    /*快速点击seg的时候如果lfetArr 被清空同时 cellforrow还在取数据模型，会崩溃所以要加判断*/
    if (temp.count >= indexPath.row + 1) {
        
        Item_MyMailEntity * item = temp[indexPath.row]
        ;
        [cell.headerIV setImageWithURL:[NSURL URLWithString:item.relativePath] placeholderImage:kDefaultPic];
        cell.mailContent.text = item.content;
        cell.name.text = item.petName;
        
        
    }
    return cell;
}


@end
