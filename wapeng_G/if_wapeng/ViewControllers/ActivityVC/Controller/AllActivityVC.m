//
//  AllActivityVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-29.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#define dTag_leftBtn 100
#define dTag_rightBtn 101
#define dTag_searchText 102

#define dTag_girdBtn1 103//暂时不用
#define dTag_girdBtn2 104//暂时不用
#define dTag_girdBtn3 105//暂时不用
#define dTag_girdBtn4 106//暂时不用

#define dTag_activBtn1 107//@"新生儿(0~100天)",
#define dTag_activBtn2 108//@"1岁~2岁"
#define dTag_activBtn3 109//, @"3岁~6岁"
#define dTag_activBtn4 110//3个月~1岁",
#define dTag_activBtn5 111//@"2岁~4岁"
#define dTag_activBtn6 112// @"6岁以上

#define dTag_mainView1 113//打折放风筝轮滑
#define dTag_mainView2 114
#define dTag_mainView3 115
#define dTag_mainView4 116

//搜索结果页面
#define dTag_label1    117//按关系
#define dTag_label2    118//按热度
#define dTag_label3    119//按年龄
#define dTag_label4    120//按距离
#import "AllActivityVC.h"
#import "HMSegmentedControl.h"
#import "UIColor+AddColor.h"
#import "Cell_SellerAciti.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIViewController+MMDrawerController.h"
#import "ActivityDetailVC.h"
#import "SellerAcitvityVC.h"
#import "SearchResultVC.h"
#import "UIViewController+MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+General.h"
#import "Cell_SellerAciti2.h"
#import "AppDelegate.h"
#import "PushAcitivityController.h"

@interface AllActivityVC ()
{
    HMSegmentedControl * seg;
    NSArray * _name;
    CGFloat lastOffset;
}
@end

@implementation AllActivityVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)btnClick2:(UIButton *)button
{
    SellerAcitvityVC * vc = [[SellerAcitvityVC alloc]init];
//    vc.type  = PageType_hidderHeader;
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
//暂时不用
-(void)btnClick:(UIButton *)button
{
    switch (button.tag) {
        case dTag_girdBtn1:
        {
            NSLog(@"宝宝");
            SearchResultVC * searchVC = [[SearchResultVC alloc]init];
            [self.navigationController pushViewController:searchVC animated:YES];
        }
            break;
        case dTag_girdBtn2:
        {
            NSLog(@"妈妈");
        }
            break;
        case dTag_girdBtn3:
        {
            NSLog(@"家庭");
        }
            break;
        case dTag_girdBtn4:
        {
            NSLog(@"活动");
        }
            break;
        default:
            break;
    }
}

#pragma mark  -发布活动
-(void)navItemClick:(UIButton *)button
{
    PushAcitivityController *push = [[PushAcitivityController alloc]init];
    [self.navigationController pushViewController:push animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    [self createFalseData];
    [self createUIView];
    //MMDraver的leftItem
//    [self  setupLeftMenuButton];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendUIView:) name:dNoti_willReceiveUIView object:nil];
    
}
/*
 因为AllAcitivityVC 包含了 WaterFlowVC.h,WaterFlowVC.h详情是AllAcitivityVC,会导致重复包含,为了避免这种情况的发生,用通知让AllAcitivityVC自己push自己既可以解决页面跳转问题又可以解决重复包含问题还可以增加复用性
 */
-(void)sendUIView:(NSNotification *)notify
{
    AllActivityVC * searchVC = [[AllActivityVC alloc]init];
    searchVC.vcType = searchResult;
    
    [self.navigationController pushViewController:searchVC animated:YES];
}
-(void)createFalseData
{
     _dataArray = [[NSMutableArray alloc]init];
    if (self.vcType == searchResult) {
        
        for (int i = 0; i < 2; i++) {
            
            NSMutableArray * _samllArray = [[NSMutableArray alloc]init];
            
            for (int j = 0; j < 3; j++) {
                
                NSString * falseStr = [NSString stringWithFormat:@"%d:section%d:row", i, j];
                [_samllArray  addObject:falseStr];
            }
            [_dataArray addObject:_samllArray];
        }
        
    }else{
        
        for (int i = 0; i < 3; i++) {
            
            NSMutableArray * _samllArray = [[NSMutableArray alloc]init];
            
            for (int j = 0; j < 3; j++) {
                
                NSString * falseStr = [NSString stringWithFormat:@"%d:section%d:row", i, j];
                [_samllArray  addObject:falseStr];
            }
            [_dataArray addObject:_samllArray];
        }
    }
}
//创建mmdrawer的leftBarButton
-(void)setupLeftMenuButton
{
    MMDrawerBarButtonItem * leftButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSlide];
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
}

//返回
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
/*
 暂时弃用
 */
-(void)createSearchText
{
    //自定义搜索栏
    UIImageView * leftIView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 10, 25, 25)];
    leftIView.image = dPic_Public_mangnifty;
    UITextField * searchText = [[UITextField alloc]
                                initWithFrame:CGRectMake(10, 5, kMainScreenWidth - 20, 35)];
    leftIView.backgroundColor = [UIColor redColor];
    searchText.returnKeyType = UIReturnKeySearch;
    searchText.placeholder = @"搜索";
    searchText.layer.cornerRadius = 15;
    searchText.layer.borderWidth = 1;
    searchText.layer.borderColor = [UIColor whiteColor].CGColor;
    searchText.layer.masksToBounds = YES;
    searchText.tag = dTag_searchText;
    searchText.delegate = self;
    searchText.borderStyle = UITextBorderStyleRoundedRect;
    searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchText.adjustsFontSizeToFitWidth = YES;
    searchText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    searchText.leftView = leftIView;
    searchText.leftViewMode = UITextFieldViewModeAlways;
    searchText.delegate = self;
    [searchText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:searchText];
}
-(void)createButtons
{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 80)];
    
    //打折 滑雪  放风筝  轮滑
    
    NSArray * name = @[@"打折", @"滑雪", @"放风筝", @"轮滑"];
    //就选取热门前四个标签
    NSArray * imageArray = @[dPic_redpoint, dPic_greenpoint, dPic_bluepoint, dPic_orangepoint];
    for (int i = 0; i < name.count; i++) {
  
        UIView * mainView = [[UIView alloc]init];
        mainView.backgroundColor = kRGB(242, 242, 242);
        mainView.frame = CGRectMake(kMainScreenWidth / 4 * i, self.searchBar.frame.size.height + self.searchBar.frame.origin.y, kMainScreenWidth / name.count, 40);
        mainView.tag = 113 + i;
        
        UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainView.frame.size.width, 1)];
        img1.backgroundColor = kRGB(189, 189, 189);
        [mainView addSubview:img1];
        
        UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, mainView.frame.size.height - 1, mainView.frame.size.width, 1)];
        img2.backgroundColor = kRGB(189, 189, 189);
        [mainView addSubview:img2];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:(CGRect){{0,0},mainView.frame.size}];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:name[i] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:imageArray[i] forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [mainView addSubview:btn];
        btn.enabled = NO;
//        UIImageView * pointView = [[UIImageView alloc]init];
//        pointView.frame = CGRectMake(5, 10, 10, 10);
//        pointView.image = [imageArray objectAtIndex:i];
//        [mainView addSubview:pointView];
//        
//        UILabel * label = [[UILabel alloc]init];
//        label.frame = CGRectMake(15, 0, kMainScreenWidth/ 4 - 15, 30);
//        label.font = [UIFont systemFontOfSize:13.5];
//        label.text = [name objectAtIndex:i];
//        label.textAlignment = NSTextAlignmentCenter;
//        [mainView addSubview:label];
//        label.backgroundColor = [UIColor clearColor];
        [headerView addSubview:mainView];
        
        __weak AllActivityVC * weakSelf = self;
        [mainView whenTapped:^{
            //根据i的值跳转道指定页面
            SellerAcitvityVC * sellerVC = [[SellerAcitvityVC alloc]init];
            switch (mainView.tag - 113) {
                case 0:
                {
                    NSLog(@"打折");
//                    sellerVC.type = PageType_hidderHeader;
                    sellerVC.title = @"打折";
                    [weakSelf.navigationController pushViewController:sellerVC animated:YES];
                }
                    break;
                case 1:
                {
                    NSLog(@"滑雪");
//                    sellerVC.type = PageType_hidderHeader;
                    sellerVC.title = @"滑雪";
                     [weakSelf.navigationController pushViewController:sellerVC animated:YES];
                }
                    break;
                case 2:
                {
                    NSLog(@"放风筝");
//                    sellerVC.type = PageType_hidderHeader;
                    sellerVC.title = @"放风筝";
                     [weakSelf.navigationController pushViewController:sellerVC animated:YES];
                }
                    break;
                case 3:
                {
                    NSLog(@"轮滑");
//                    sellerVC.type = PageType_hidderHeader;
                    sellerVC.title = @"轮滑";
                    [weakSelf.navigationController pushViewController:sellerVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }];
        [self.view addSubview:mainView];
    }

}
-(void)createUIView
{
    
    
//    [self createSearchText];

//    [self createSeg];
    if (self.vcType == allACtivity) {
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [leftBtn setBackgroundImage:dPic_Public_topmenu forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"top_icon_huodong normal"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"top_icon_huodong selected"] forState:UIControlStateHighlighted];
        leftBtn.frame = CGRectMake(0, 0,25, 25);
        leftBtn.tag = dTag_leftBtn;
        [leftBtn addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
        
        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setBackgroundImage:dPic_Public_toprelease forState:UIControlStateNormal];
        rightBtn.frame = CGRectMake(0, 0, 25, 25);
        rightBtn.tag = dTag_rightBtn;
        [rightBtn addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
        self.title = @"全部活动";
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.placeholder = @"Search";
        _searchBar.frame = CGRectMake(0, 0, kMainScreenWidth, 30);
        _searchBar.delegate = self;
        [self.view addSubview:_searchBar];
        [self createButtons];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, kMainScreenWidth, kMainScreenHeight - 44 - 70-50) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        [self.view addSubview:_tableView];
        
        //分割线
        //    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth - 20, 149.5)];
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth , 500)];
        view1.backgroundColor = [UIColor whiteColor];
        
        /*瀑布流视图*/
        self.wateflowVC = [[WaterFlowVC alloc]init];
        [self addChildViewController:self.wateflowVC];
        self.wateflowVC.view.frame = view1.frame;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame) - 1, kMainScreenWidth, 1)];
        img.backgroundColor = kRGB(198, 198, 198);
        [view1 addSubview:img];
        [view1 addSubview:self.wateflowVC.mainView];
        
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 149.5, kMainScreenWidth - 20, 1)];
        
        UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), kMainScreenWidth, 209.5)];
        view2.backgroundColor = kRGB(242, 242, 242);
        UIImageView * redView = [[UIImageView alloc]init];
        redView.frame = CGRectMake(20, 10, 5, 20);
        redView.backgroundColor = kRGB(131, 0, 10);
        
        [view2 addSubview:redView];
        UILabel * activyLbl = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, kMainScreenWidth - 30 - 20, 30)];
        activyLbl.text = @"同龄活动";
        //    activyLbl.backgroundColor = [UIColor blueColor];
        [view2 addSubview:activyLbl];
        
        NSArray * nameArray1 = @[@"新生儿(0~100天)", @"1岁~2岁", @"3岁~6岁"];
        NSArray * imageArr1 = @[dPic_age_red, dPic_age_blue, dPic_age_green];
        for (int i = 0; i < 3; i++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[imageArr1 objectAtIndex:i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.tag = i + 107;
            button.frame = CGRectMake(18, activyLbl.frame.size.height + activyLbl.frame.origin.y + 20 + 50 * i, (kMainScreenWidth - 60) / 2.0, 35);
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
            button.frame = CGRectMake(18 + (kMainScreenWidth - 20) / 2.0, activyLbl.frame.size.height + activyLbl.frame.origin.y + 20 + 50 * i, (kMainScreenWidth - 60) / 2.0, 35);
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setTitle:[nameArray2 objectAtIndex:i] forState:UIControlStateNormal];
            //        button.backgroundColor = [UIColor greenColor];
            [button setBackgroundImage:[imageArray2 objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
            [view2 addSubview:button];
        }
        
        line.backgroundColor = [UIColor blackColor];
        UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, CGRectGetMaxY(view2.frame))];
        [footerView addSubview:line];
        [footerView addSubview:view1];
        [footerView addSubview:view2];
        //    footerView.backgroundColor = [UIColor redColor];
        _tableView.tableFooterView = footerView;
        
        
        //取消键盘相应
        __weak UISearchBar * weakSearch = _searchBar;
        
        [self.mm_drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
            
            [weakSearch resignFirstResponder];
            return 0;
            
        }];

    }else{
        self.title = @"搜索结果";
        [self initLeftItem];
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44 ) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
    }
}
/*
 暂时废弃
 */
-(void)createSeg
{
    NSArray * array = @[@"打折", @"滑雪", @"放风筝", @"轮滑"];
    NSArray * name = @[@"身边热门活动", @"商家活动", @"用户互动"];
    _name = name;
    seg = [[HMSegmentedControl alloc]initWithSectionTitles:array];
    [seg setBackgroundColor:[UIColor redColor]];
    seg.frame = CGRectMake(0, 45, kMainScreenWidth, 40);
    [seg setSelectedTextColor:[UIColor colorWithHexString:@"#344934"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ]];
    seg.selectionStyle = HMSegmentedControlSelectionStyleBox;
    seg.selectionLocation = HMSegmentedControlSelectionLocationDown;
    [seg setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:seg];
    
    [seg setIndexChangeBlock:^(NSInteger index) {
        
        switch (index) {
            case 0:
            {
                NSLog(@"打折");
            }
                break;
            case 1:
            {
                NSLog(@"滑雪");
            }
                break;
            case 2:
            {
                NSLog(@"放风筝");
            }
                break;
            case 3:
            {
                NSLog(@"轮滑");
            }
                break;
            default:
                break;
        }
    }];
}

-(void)textFieldDidChange:(id)sender
{
    NSLog(@"change");
}
#pragma mark - uitxtfielddelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    if (textField.tag == dTag_searchText) {
//        [textField resignFirstResponder];
//        SellerAcitvityVC * vc = [[SellerAcitvityVC alloc]init];
//        vc.type = PageType_hidderHeader;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    return YES;
}
#pragma mark - tableViewDataSoure

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dataArray objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.vcType == allACtivity) {
        
        static NSString * strID2  = @"ID2";
        
        Cell_SellerAciti2 * cell = [tableView dequeueReusableCellWithIdentifier:strID2];
        
        if (nil == cell) {
            
            cell = [[Cell_SellerAciti2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID2];
        }
        
        if (indexPath.row == 0) {
            
            cell.topLabel.textColor = [UIColor redColor];
        }
        if (indexPath.row == 1) {
            
            cell.topLabel.textColor = [UIColor purpleColor];
        }
        if (indexPath.row == 2) {
            
            cell.topLabel.textColor = [UIColor greenColor];
        }
        cell.headerImage.image = [UIImage imageNamed:@"saga2.jpg"];
        return cell;
    }
    
    static NSString * strID  = @"ID";
    
    Cell_SellerAciti * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        cell = [[Cell_SellerAciti alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
  
    NSMutableArray * smallArray = [_dataArray objectAtIndex:indexPath.section];
    cell.mainLabel.text = [smallArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"团购来袭，四折起";
    cell.joinLabel.text = @"320位熟人参与";
    if (indexPath.section == 0) {
        cell.headerImage.image = [UIImage imageNamed:@"saga2.jpg"];
    }
    if (indexPath.section == 1) {
        
         cell.headerImage.image = [UIImage imageNamed:@"gouwuche.jpg"];
    }
    if (indexPath.section == 2) {
        cell.headerImage.image = [UIImage imageNamed:@"saga2.jpg"];
    }
    return cell;
}
#pragma mark - uisearchbarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    AllActivityVC * vc = [[AllActivityVC alloc]init];
    vc.vcType = searchResult;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"搜索");

}

#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.vcType == allACtivity && indexPath.section == 0) {
        return 125;
    }else{
        return 100;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.vcType == searchResult) {
        
        NSArray * name = @[@"商家活动", @"用户活动"];
        _name = name;
        UIView * mainView = [[UIView alloc]init];
        
        UIView * redView = [[UIView alloc]init];
        mainView.frame = CGRectMake(0, 0, kMainScreenWidth, 30);
       
        if (section == 1) {
            mainView.frame = CGRectMake(0, 0, kMainScreenWidth, 30 + 40);
            NSArray * name = @[@"按关系",@"按热度", @"按距离", @"按年龄"];
            UIView * moveView = [[UIView alloc]init];
            moveView.backgroundColor = [UIColor redColor];
            moveView.frame = CGRectMake(10, 65, kMainScreenWidth/4 - 20, 5);
            moveView.backgroundColor = [UIColor redColor];
            [mainView addSubview:moveView];
            for (int i = 0; i < [name count]; i++) {
                UILabel * label = [[UILabel alloc]init];
                label.frame = CGRectMake(i * kMainScreenWidth / 4.0, 35, kMainScreenWidth / 4, 35);
                label.text = [name objectAtIndex:i];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor blueColor];
                label.tag = 117 + i;
                [mainView addSubview:label];
                
                [label whenTapped:^{
                    
                    switch (label.tag -117) {
                        case 0:
                        {
                            NSLog(@"按关系");
                            [UIView animateWithDuration:0.3 animations:^{
                                CGRect frame = moveView.frame;
                                frame.origin.x = label.frame.origin.x + 10;
                                moveView.frame = frame;
                            }];
                        }
                            break;
                        case 1:
                        {
                            NSLog(@"按热度");
                            [UIView animateWithDuration:0.3 animations:^{
                                CGRect frame = moveView.frame;
                                frame.origin.x = label.frame.origin.x + 10;
                                moveView.frame = frame;
                            }];
                        }
                            break;
                        case 2:
                        {
                            NSLog(@"按年龄");
                            [UIView animateWithDuration:0.3 animations:^{
                                CGRect frame = moveView.frame;
                                frame.origin.x = label.frame.origin.x + 10;
                                moveView.frame = frame;
                            }];
                        }
                            break;
                        case 3:
                        {
                            NSLog(@"按距离");
                            [UIView animateWithDuration:0.3 animations:^{
                                CGRect frame = moveView.frame;
                                frame.origin.x = label.frame.origin.x + 10;
                                moveView.frame = frame;
                            }];
                        }
                            break;
                        default:
                            break;
                    }
                }];
                UIView * grayView = [[UIView alloc]init];
                grayView.backgroundColor = [UIColor grayColor];
                grayView.frame = CGRectMake(kMainScreenWidth/ 4  * (i + 1) + 1, 42, 5, 20);
                [mainView addSubview:grayView];
            }
        }
        
        redView.frame = CGRectMake(20, 0, 10, 30);
        redView.backgroundColor = [UIColor redColor];
        [mainView addSubview:redView];
        UILabel * sectionLbl = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, kMainScreenWidth - 20, 30)];
        sectionLbl.textAlignment =  NSTextAlignmentLeft;
        sectionLbl.textColor = [UIColor blackColor];
        sectionLbl.text = [_name objectAtIndex:section];
        //    sectionLbl.backgroundColor = [UIColor greenColor];
        [mainView addSubview:sectionLbl];
        return mainView;
    }else{
        NSArray * name = @[@"身边热门活动", @"商家活动", @"用户互动"];
        _name = name;
        UIView * mainView = [[UIView alloc]init];
        mainView.frame = CGRectMake(0, 0, kMainScreenWidth, 30);
        UIView * redView = [[UIView alloc]init];
        redView.frame = CGRectMake(20, 5, 5, 20);
        redView.backgroundColor = kRGB(131, 0, 10);
        [mainView addSubview:redView];
        UILabel * sectionLbl = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, kMainScreenWidth - 20, 30)];
        sectionLbl.textAlignment =  NSTextAlignmentLeft;
        sectionLbl.textColor = [UIColor blackColor];
        sectionLbl.text = [_name objectAtIndex:section];
        //    sectionLbl.backgroundColor = [UIColor greenColor];
        [mainView addSubview:sectionLbl];
        return mainView;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * mainView = [[UIView alloc]init];
    mainView.frame = CGRectMake(0, 0, kMainScreenWidth, 30);
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, mainView.frame.size.height - 1, kMainScreenWidth, 1)];
    img.backgroundColor  = kRGB(193, 193, 193);
    [mainView addSubview:img];
    
    UILabel * sectionLbl = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth - 70, 5, 40, 20)];
    sectionLbl.font = [UIFont systemFontOfSize:16];
    sectionLbl.textColor = kRGB(193, 193, 193);
    
    __weak AllActivityVC * weakSelf = self;
    [mainView whenTapped:^{
        
        NSLog(@"more");
         SellerAcitvityVC * sellerVC = [[SellerAcitvityVC alloc]init];
//        sellerVC.type = PageType_hidderHeader;
        sellerVC.title = @"more";
        [weakSelf.navigationController pushViewController:sellerVC animated:YES];
    }];
    sectionLbl.textAlignment = NSTextAlignmentCenter;
    sectionLbl.text = @"more";
//    sectionLbl.backgroundColor = [UIColor greenColor];
    [mainView addSubview:sectionLbl];
    return mainView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.vcType == searchResult && section == 1) {
        return 70;
    }
    return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActivityDetailVC * activityVC = [[ActivityDetailVC alloc]init];
     [self.navigationController pushViewController:activityVC animated:YES];   
}
#pragma mark - uiscrollviewdelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UITextField * search = (UITextField *)[self.view viewWithTag:dTag_searchText];
    [search resignFirstResponder];
    
    lastOffset = scrollView.contentOffset.y;
}

@end
