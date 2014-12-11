//
//  RegVC09.m
//  if_wapeng
//
//  Created by 心 猿 on 14-12-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

static NSString  * strID = @"ID";
static NSString  * headerStrID = @"ID2";
#import "RegVC09.h"
#import "Cell_Reg09.h"
#import "HeaderKindView.h"
#import "RegisterDataManager.h"
#import "UIViewController+General.h"
#import "UIView+WhenTappedBlocks.h"
#import "Item_Reg09.h"
#import "RegisterDataManager.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
@interface RegVC09 ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView * _collectionView;
    AFN_HttpBase * http;
    RegisterDataManager * dm;
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * arr1;
@property (nonatomic, strong) NSMutableArray * arr2;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSString * ddid;

@end

@implementation RegVC09

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataArray = [[NSMutableArray alloc]init];
        self.arr1 = [[NSMutableArray alloc]init];
        self.arr2 = [[NSMutableArray alloc]init];
        http = [[AFN_HttpBase alloc]init];
    }
    return self;
}
/**
 获取同班家长或 推荐关注人（宝宝同班）
 **/
-(void)commonRequestWithPageIndex:(int)pageIndex
{
    NSString * page = [NSString stringWithFormat:@"%d", pageIndex];
    
    __weak RegVC09 * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_OSM_1_1_2 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * root = (NSDictionary *)obj;
        
        if (!isNotNull([[root objectForKey:@"value"] objectForKey:@"list"])) {
            
            [SVProgressHUD showSuccessWithStatus:dTips_noMoreData];

            return;
        }
        
        NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];

        for (NSDictionary * dict in list) {
            
            Item_Reg09 * item = [[Item_Reg09 alloc]init];
            item.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"] intValue];
            item.petName = [dict objectForKey:@"petName"];
            
            item.relativePath = kNullData;
            
            if (isNotNull([dict objectForKey:@"photo"])) {
                if (isNotNull([[dict objectForKey:@"photo"] objectForKey:@"relativePath"])) {
                    item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion,[[dict objectForKey:@"photo"] objectForKey:@"relativePath"]];
                }
            }
            
            [weakSelf.arr1 addObject:item];
        }
        
        NSIndexSet * set = [NSIndexSet indexSetWithIndex:0];
        [weakSelf.collectionView reloadSections:set];
        [weakSelf httpRequest];
     
    } failed:^(NSObject *obj, BOOL isFinished) {
        
            [weakSelf.collectionView footerEndRefreshing];
            [weakSelf.collectionView headerEndRefreshing];
    
    
    } andKeyValuePairs:@"D_ID",self.ddid,@"userInfoQuery.pageNum",page, nil];
}
#pragma mark - 获取相同居住地的宝宝

-(void)httpRequest
{
    
    __weak RegVC09 * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_OSM_1_1_4 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * root = (NSDictionary *)obj;
        
        if (!isNotNull([root objectForKey:@"value"])) {
            
            [SVProgressHUD showSuccessWithStatus:dTips_noMoreData];
            return;
        }
        if (!isNotNull([[root objectForKey:@"value"] objectForKey:@"list"])) {
           [SVProgressHUD showSuccessWithStatus:dTips_noMoreData];
        }
        NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];

        for (NSDictionary * dict  in  list) {
            
            Item_Reg09 * item = [[Item_Reg09 alloc]init];
            item.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"] intValue];
            item.petName = [dict objectForKey:@"petName"];
            item.relativePath = kNullData;
            
            if (isNotNull([dict objectForKey:@"photo"])) {
                if (isNotNull([[dict objectForKey:@"photo"] objectForKey:@"relativePath"])) {
                    item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion,[[dict objectForKey:@"photo"] objectForKey:@"relativePath"]];
                }
            }
            
            [weakSelf.arr2 addObject:item];
        }
        NSIndexSet * set = [NSIndexSet indexSetWithIndex:1];
        [weakSelf.collectionView reloadSections:set];
       
            [weakSelf.collectionView footerEndRefreshing];
            [weakSelf.collectionView headerEndRefreshing];
    
        
    } failed:^(NSObject *obj, BOOL isFinished) {

    } andKeyValuePairs:@"D_ID",self.ddid,@"userInfoQuery.searchType",@"1",@"userInfoQuery.longitude",@"117.187441",@"userInfoQuery.latitude",@"39.187636",@"userInfoQuery.generalTypeID",@"1",@"userInfoQuery.disNo",@"3",@"userInfoQuery.startIndex",@"1",@"userInfoQuery.keyWord",@"",nil];
    
}
/**先登录，获得ddid**/
-(void)loginHttpRequest
{
    //暂时用家长1来代替
    dm.phoneNum = @"30000000001";
    
    __weak RegVC09 * weakSelf = self;
    
    __weak AppDelegate * app = [AppDelegate shareInstace];
    
    [http thirdRequestWithUrl:dUrl_ACC_1_1_3 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * root = (NSDictionary *)obj;
        
        NSLog(@"%@", root);
        
        weakSelf.ddid = [[root objectForKey:@"value"] objectForKey:@"d_ID"];
        
        app.loginDict = [root objectForKey:@"value"];
        
    
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"accountQuery.userName",dm.phoneNum,@"accountQuery.password",@"1111",@"accountQuery.deviceCode",dm.uuid, nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
    
    self.navigationItem.title = @"附近的邻居";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    dm = [RegisterDataManager shareInstance];
    //宝宝昵称
    NSString * babyNick = dm.childNickName;
    //常住地
    NSString * place = dm.localPlace;
    NSString * header1 = [NSString stringWithFormat:@"他们的宝宝与/""%@/""同班", babyNick];
    NSString * header2= [NSString stringWithFormat:@"住在/""%@/""附近的宝宝", place];
    self.titleArray = @[header1,header2];
    
    [self initLeftItem];
    
    [self createCollenctionView];
    
    [self addHeader];
    [self addFooter];
    [self.dataArray addObject:self.arr1];
    [self.dataArray addObject:self.arr2];
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    self.ddid = [d objectForKey:UD_ddid];
    
    [self loginHttpRequest];
    [self commonRequestWithPageIndex:1];
//    [self httpRequest];
    
}

#pragma mark - 上拉加载更多
-(void)addFooter
{
    [SVProgressHUD showSuccessWithStatus:dTips_noMoreData];
    return;
//    __weak RegVC09 * weakSelf = self;
//    
//    [self.collectionView addFooterWithCallback:^{
//        
//        [weakSelf commonRequestWithPageIndex:1];
//     
//    }];
}

#pragma mark - 下拉刷新

-(void)addHeader
{
    __weak RegVC09 * weakSelf = self;
    
    [self.collectionView addHeaderWithCallback:^{
        
        [weakSelf commonRequestWithPageIndex:1];
        [weakSelf httpRequest];
    }];
    
}
-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 创建colletionView

-(void)createCollenctionView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kMainScreenWidth - 20) / 3, (kMainScreenWidth - 20) / 3);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44 - 40) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.collectionView];
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"Cell_Reg09" bundle:nil] forCellWithReuseIdentifier:strID];
    //注册headerView
    [self.collectionView registerClass:[HeaderKindView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerStrID];
    
    UIButton * allFocusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allFocusBtn.frame = CGRectMake(20, CGRectGetMaxY(self.collectionView.frame), kMainScreenWidth / 2 - 40, 40);
    
    [allFocusBtn setBackgroundImage:[UIImage imageNamed:@"_0001_button-拷贝.png"] forState:UIControlStateNormal];
    
    [allFocusBtn setTitle:@"全部关注" forState:UIControlStateNormal];
    [allFocusBtn setTitle:@"全部取消" forState:UIControlStateSelected];
    [allFocusBtn addTarget:self action:@selector(focusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:allFocusBtn];
    
    UIButton * completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    completeBtn.frame = CGRectMake(kMainScreenWidth / 2 + 20, CGRectGetMaxY(self.collectionView.frame), kMainScreenWidth / 2 - 40, 40);
    
    [completeBtn setBackgroundImage:[UIImage imageNamed:@"public_green_btn.png"] forState:UIControlStateNormal];
    
    [completeBtn setTitle:@"完成注册" forState:UIControlStateNormal];

    [completeBtn addTarget:self action:@selector(completeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeBtn];
}

#pragma mark - 完成注册

-(void)completeClick
{
    AppDelegate * app = [AppDelegate shareInstace];
    [app showViewController:showVCTypeTab];
}

#pragma mark - 全选

-(void)focusBtnClick:(UIButton *)btn
{
   
    btn.selected = !btn.selected;
     BOOL selected = btn.selected;
    for (Item_Reg09 * item1 in self.arr1) {
        
        item1.isSelected = selected;
    }
    for (Item_Reg09 * item2 in self.arr2) {
        
        item2.isSelected = selected;
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataArray count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.dataArray objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_Reg09 * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:strID forIndexPath:indexPath];
    
    Item_Reg09 * item = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.nameLbl.text = item.petName;
//    cell.headImageView.hidden = item.isSelected;
    cell.headImageView.layer.masksToBounds = YES;
    cell.headImageView.layer.cornerRadius = 6;
    
    NSURL * url = [NSURL URLWithString:item.relativePath];
    [cell.headImageView setImageWithURL:url placeholderImage:kDefaultPic];

    __weak RegVC09 * weakSelf = self;
    [cell.headImageView whenTapped:^{
        
        Item_Reg09 * item = [[weakSelf.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        item.isSelected = !item.isSelected;
        
        [weakSelf.collectionView reloadData];
    }];
    
     cell.selectImageView.hidden = !item.isSelected;
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderKindView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerStrID forIndexPath:indexPath];
    
    view.sectionLbl.text = [self.titleArray objectAtIndex:indexPath.section];
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    return CGSizeMake(kMainScreenWidth, 44);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", indexPath.row);

}

@end
