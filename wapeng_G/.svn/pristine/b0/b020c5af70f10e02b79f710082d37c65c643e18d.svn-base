//
//  WaterFlowVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
/*
 */
#define waterFlowHeight 430
#define dTag_button(i) 100 + i// 100 101
#define dTag_greenIV   102
#define dTag_activBtn1 107//@"新生儿(0~100天)",
#define dTag_activBtn2 108//@"1岁~2岁"
#define dTag_activBtn3 109//, @"3岁~6岁"
#define dTag_activBtn4 110//3个月~1岁",
#define dTag_activBtn5 111//@"2岁~4岁"
#define dTag_activBtn6 112// @"6岁以上

#import "WaterFlowVC.h"
#import "Item_water.h"
#import "Cell_WaterFlow.h"
#import "UIView+WhenTappedBlocks.h"
#import "SellerAcitvityVC.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ActivityDetailVC.h"
#import "UIViewController+MMDrawerController.h"
#import "UIViewController+General.h"
#import "PushAcitivityController.h"
#import "HMSegmentedControl.h"
@interface WaterFlowVC ()
{
    BOOL viewType;
    NSMutableArray * _view_Arr;
    int currentPage;
}
@property (nonatomic, strong) UILabel * titleLabel;//标题
@property (nonatomic, strong) HMSegmentedControl * seg;
@end

@implementation WaterFlowVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dataArr_left = [[NSMutableArray alloc]init];
        _dataArr_right = [[NSMutableArray alloc]init];
        _dataArr_all = [[NSMutableArray alloc]init];
        _view_Arr = [[NSMutableArray alloc]initWithCapacity:0];
        _isButtom = 0;//默认是有下一页的
    }
    return self;
}
-(void)btnClick2:(UIButton *)button
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [NSString stringWithFormat:@"%@", [d objectForKey:UD_ddid]];
    SellerAcitvityVC * vc = [[SellerAcitvityVC alloc]init];
    vc.pageType = 1;//页面类型
    vc.age = button.tag - 106;
    vc.ddid = ddid;
    switch (button.tag) {
        case dTag_activBtn1:
        {
            NSLog(@"1");
            vc.title = @"新生儿(0~100天)";
            
        }
            break;
        case dTag_activBtn2:
        {
            NSLog(@"2");
            vc.title = @"1岁~2岁";
        }
            break;
        case dTag_activBtn3:
        {
            NSLog(@"3");
            vc.title = @"3岁~6岁";
            
        }
            break;
        case dTag_activBtn4:
        {
            NSLog(@"4");
            vc.title = @"3个月~1岁";
        }
            break;
        case dTag_activBtn5:
        {
            NSLog(@"5");
            vc.title = @"2岁~4岁";
        }
            break;
        case dTag_activBtn6:
        {
            NSLog(@"6");
            vc.title = @"6岁以上";
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)createLeftItem
{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"top_icon_huodong normal"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)leftItemClick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
-(void)createRightItem
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:dPic_Public_toprelease forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)rightItemClick
{
    PushAcitivityController *push = [[PushAcitivityController alloc]init];
    push.type = 2;
    [self.navigationController pushViewController:push animated:YES];
}
-(void)createBGView
{
    
    UIView * view2 = [[UIView alloc]init];
    view2.frame = CGRectMake(0, 60, kMainScreenWidth, kMainScreenHeight);
    NSArray * nameArray1 = @[@"新生儿(0~100天)", @"1岁~2岁", @"3岁~6岁"];
    NSArray * imageArr1 = @[dPic_age_red, dPic_age_blue, dPic_age_green];
    for (int i = 0; i < 3; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[imageArr1 objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = i + 107;
        button.frame = CGRectMake(18, 20 + 50 * i, (kMainScreenWidth - 60) / 2.0, 35);
        [button setTitle:[nameArray1 objectAtIndex:i] forState:UIControlStateNormal];
        //        button.backgroundColor = [UIColor greenColor];
        [button addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:button];
    }
    NSArray * nameArray2 = @[@"3个月~1岁", @"2岁~4岁", @"6岁以上"];
    NSArray * imageArray2 = @[dPic_age_yellow, dPic_age_black, dPic_age_purple];
    for (int i = 0; i < 3; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 110 + i;
        button.frame = CGRectMake(18 + (kMainScreenWidth - 20) / 2.0, 20 + 50 * i, (kMainScreenWidth - 60) / 2.0, 35);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitle:[nameArray2 objectAtIndex:i] forState:UIControlStateNormal];
        //        button.backgroundColor = [UIColor greenColor];
        [button setBackgroundImage:[imageArray2 objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:button];
    }
    _backgroundView = view2;
}
//删除橱窗
-(void)deleteAction
{
    
}
-(void)btnClick:(UIButton *)btn
{
    UIImageView * iV = (UIImageView *)[self.view viewWithTag:dTag_greenIV];
    CGRect frame;
    switch (btn.tag) {
        case dTag_button(0):
        {
            _mainView.hidden = NO;
            
            frame = btn.frame;
            frame.origin.y += 30;
            frame.size.height -=30;
          
        }
            break;
        case dTag_button(1):
        {
            _mainView.hidden = YES;
            
            frame = btn.frame;
            frame.origin.y += 30;
            frame.size.height -=30;
        }
            break;
        default:
            break;
    }
    [UIView  animateWithDuration:0.3 animations:^{
        iV.frame = frame;
    }];
}
-(void)createSegCtrl
{
    NSArray * titles = @[@"分类热门活动", @"同龄活动"];
    
    HMSegmentedControl * seg = [[HMSegmentedControl alloc]initWithSectionTitles:titles];
    seg.selectionIndicatorColor = [UIColor redColor];
    seg.frame = CGRectMake(0, 0, kMainScreenWidth, 40);
    [seg setSelectedTextColor:[UIColor redColor]];
    seg.selectionStyle = HMSegmentedControlSelectionStyleBox;
    [seg setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:seg];
    self.seg = seg;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分类热门和同龄活动";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (IOS7) {
        
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    //创建seg
    [self createSegCtrl];

    [self createBGView];
    
    [self createLeftItem];
    
    [self createRightItem];
    
    [self.view addSubview:_backgroundView];
    
    
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _mainView = [[UIView alloc]init];
    
    _mainView.frame = CGRectMake(0, 40, kMainScreenWidth, kMainScreenHeight - 40 - 40 - 49);
    [self.view addSubview:_mainView];

    _leftTableView = [[UITableView alloc]init];
    _leftTableView.frame = CGRectMake(0, 0, kMainScreenWidth/2, kMainScreenHeight - 40 - 40 - 49);
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.showsVerticalScrollIndicator = NO;

    _leftTableView.bounces = YES;
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    [_mainView addSubview:_leftTableView];
    
    _rightTableView = [[UITableView alloc]init];
    _rightTableView.frame = CGRectMake(kMainScreenWidth/ 2, 0, kMainScreenWidth / 2, kMainScreenHeight - 40 - 40 - 49);
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.showsVerticalScrollIndicator = NO;
    _rightTableView.bounces = YES;
    _rightTableView.delegate = self;
    _rightTableView.dataSource  = self;
    [_mainView addSubview:_rightTableView];
    [self.view addSubview:_mainView];
    
    [self setupRefresh:_leftTableView];
    [self setupRefresh:_rightTableView];
    //设置当前页码
    currentPage = 1;
    [self waterFlowHttpRequestWithPageIndex:currentPage];
    
    
    __weak UIView * tempMainView = _mainView;
    [self.seg setIndexChangeBlock:^(NSInteger index) {
        
        tempMainView.hidden = index;
    }];
}

#pragma mark - 下拉刷新

//必须被重写
-(void)headerRereshing
{
   
}

#pragma mark - 上拉加载

//必须被重写
-(void)footerRereshing
{
    
}
-(void)waterFlowHttpRequestWithPageIndex:(int)pageIndex
{
    NSString * ddid = [NSString stringWithFormat:@"%@", [self.loginDict objectForKey:@"d_ID"]];
    NSString * latitude = [self.loginDict objectForKey:@"latitude"];
    NSString * longtitude = [self.loginDict objectForKey:@"longitude"];
    NSString * pageIdx = [NSString stringWithFormat:@"%d", pageIndex];
    //标签id暂时写死
    NSString * labelID = @"85d1b374-3287-4060-9a06-df9fbf8bc06f";
    AFN_HttpBase * http = [[AFN_HttpBase alloc]init];
    
    __weak WaterFlowVC * weakSelf = self;
    [http thirdRequestWithUrl:dUrl_ACT_1_2_4 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * dict = (NSDictionary *)obj;
        
        //是否有下一页
        self.isButtom = [[[dict objectForKey:@"value"] objectForKey:@"isButtom"]intValue];
        
        NSArray * list = [[dict objectForKey:@"value"] objectForKey:@"list"];
        for (NSDictionary * dict in list) {
            Item_water * item = [[Item_water alloc]init];
            
            //这个是真的url.
//            NSString * trueUrl = [[[[dict objectForKey:@"activityAttachmentList"]firstObject] objectForKey:@"attachment"] objectForKey:@"relativePath"];
            //暂时用假的url
            NSString * url = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion,[[dict objectForKey:@"author"]objectForKey:@"photoURL"] ];
            item.photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
            item.createTime = [dict objectForKey:@"createTime"];
            item.limitTime = [[dict objectForKey:@"author"] objectForKey:@"limitTime"];
            item.content = [dict objectForKey:@"content"];
            item.petName = [[dict objectForKey:@"author"] objectForKey:@"petName"];
            //发帖人头像的url,暂时是没有数据
            item.imageUrl = [NSString stringWithFormat:@"%@%@",dUrl_PhotoPrefixion, [[dict objectForKey:@"author"] objectForKey:@"relativePath"]];
            item.replies = [NSString stringWithFormat:@"%@", [dict objectForKey:@"replies"]];
            item.supports  = [NSString stringWithFormat:@"%@",[dict objectForKey:@"supports"]];
            item.title = [dict objectForKey:@"title"];
            item.actId = [dict objectForKey:@"id"];
            [weakSelf.dataArr_all addObject:item];
            
        }
        
        int leftHeight = 0, rightHeight = 0;
        
        [weakSelf.dataArr_left removeAllObjects];
        [weakSelf.dataArr_right removeAllObjects];
        
        for (Item_water * item in weakSelf.dataArr_all) {
            
            if (leftHeight <= rightHeight) {
                
                [weakSelf.dataArr_left addObject:item];
                
                //照片的高度加内容的高度
                leftHeight += item.photo.size.height + [item height];
                
            }else{
                
                [weakSelf.dataArr_right addObject:item];
                
                //照片的高度加内容的高度
                rightHeight += item.photo.size.height + [item height];
            }
        }
        
        [weakSelf.leftTableView reloadData];
        [weakSelf.rightTableView reloadData];

    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID", ddid, @"activityQuery.longitude", longtitude, @"activityQuery.latitude", latitude,@"activityQuery.labelID", labelID, @"activityQuery.startIndex", pageIdx, @"activityQuery.disNo", @"3", nil];
}

/*
修复瀑布流滚动的bug
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat height;
    
   height = (_leftTableView.contentSize.height - _rightTableView.contentSize.height) >= 0 ? _leftTableView.contentSize.height : _rightTableView.contentSize.height;
    CGSize size = _leftTableView.contentSize;
    size.height = height;
    _leftTableView.contentSize = size;
    _rightTableView.contentSize = size;
    NSArray * array = @[_leftTableView, _rightTableView];
    
    for (UIScrollView * s in array) {
        
        if (scrollView != s) {
            
            s.contentOffset = scrollView.contentOffset;
        }
    }
}
#pragma mark - tableViewDelegate & tableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        Item_water * item = [_dataArr_left objectAtIndex:indexPath.row];
        
        return 220 + [item height] + 20 +  [item heightImage];
    }
    if (tableView == _rightTableView) {
        
        Item_water * item = [_dataArr_right objectAtIndex:indexPath.row];
        
        return 220 + [item height] + 20 + [item heightImage];
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftTableView) {
        
        return [_dataArr_left count];
    }else{
        return [_dataArr_right count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        static NSString * strID = @"ID";
        
        Cell_WaterFlow * cell = [tableView dequeueReusableCellWithIdentifier:strID];
        
        if (cell == nil) {
            
            cell = [[Cell_WaterFlow alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        }
        Item_water * item = [_dataArr_left objectAtIndex:indexPath.row];
        CGRect frame = cell.headerIView.frame;
        frame.size.height = [item heightImage];
        cell.headerIView.frame = frame;
        cell.headerIView.image = item.photo;
        frame = cell.mainLabel.frame;
        frame.origin.y = cell.headerIView.frame.size.height + cell.headerIView.frame.origin.y;
        frame.size.height = [item height] + 10;
        cell.mainLabel.frame = frame;
        cell.mainLabel.text = item.content;
         cell.centerView.frame = CGRectMake(cell.mainLabel.frame.origin.x, cell.mainLabel.frame.origin.y + cell.mainLabel.frame.size.height,kMainScreenWidth / 2 - 20, 40);
        cell.footerMainView.frame = CGRectMake(cell.mainLabel.frame.origin.x, cell.mainLabel.frame.origin.y + cell.mainLabel.frame.size.height + 30,kMainScreenWidth / 2 - 20, 40);
        cell.titleLabel.text = item.title;
        cell.timeLabel.text = [item getUTCFormateDate:item.createTime];
        cell.postMsgLabel.text = item.petName;
        cell.goodCountLbl.text = item.supports;
        cell.remarkLabel.text = [NSString stringWithFormat:@"评论:%@", item.replies];
        /*以后会打开*/
//        [cell.postMsgView setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:nil];
        return cell;
    }else{
        static NSString * strID2 = @"ID2";
        Cell_WaterFlow * cell = [tableView dequeueReusableCellWithIdentifier:strID2];
        
        if (cell == nil) {
            
            cell = [[Cell_WaterFlow alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID2];
        }
        Item_water * item = [_dataArr_right objectAtIndex:indexPath.row];
//        cell.headerIView.image = [UIImage imageNamed:item.imageUrl];
        CGRect frame = cell.headerIView.frame;
        frame.size.height = [item heightImage];
        cell.headerIView.frame = frame;
        cell.headerIView.image = item.photo;
        frame = cell.mainLabel.frame;
        frame.origin.y = cell.headerIView.frame.origin.y + cell.headerIView.frame.size.height;
        frame.size.height = [item height] + 10;
        cell.mainLabel.frame = frame;
//        cell.mainLabel.text = item.text;
        cell.mainLabel.text = item.content;
        cell.centerView.frame = CGRectMake(cell.mainLabel.frame.origin.x, cell.mainLabel.frame.origin.y + cell.mainLabel.frame.size.height,kMainScreenWidth / 2 - 20, 40);
        cell.footerMainView.frame = CGRectMake(cell.mainLabel.frame.origin.x, cell.mainLabel.frame.origin.y + cell.mainLabel.frame.size.height + 30,kMainScreenWidth / 2 - 20, 40);
        cell.postMsgLabel.text = item.petName;
        cell.goodCountLbl.text = item.supports;
        cell.remarkLabel.text = [NSString stringWithFormat:@"评论:%@", item.replies];
        cell.titleLabel.text = item.title;
        cell.timeLabel.text = [item getUTCFormateDate:item.createTime];
        /*以后会打开*/
        //        [cell.postMsgView setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:nil];
        return cell;
    }
}
#pragma mark - 点击进入详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityDetailVC * detailVc = [[ActivityDetailVC alloc]init];
    
    Item_water * item = nil;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView isEqual:_leftTableView]) {
        
        item = _dataArr_left[indexPath.row];
        
    }else{
        item = _dataArr_right[indexPath.row];
    }
    
    detailVc.activityID = item.actId;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
