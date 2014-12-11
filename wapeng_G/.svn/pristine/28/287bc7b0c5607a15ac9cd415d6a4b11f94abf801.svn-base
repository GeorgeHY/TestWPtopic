//
//  UIViewController+General.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-23.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "UIViewController+General.h"
#import "UIColor+AddColor.h"
#import "HMSegmentedControl.h"

@implementation UIViewController (General)

//初始化系统的导航条
-(void)initLeftItem
{
    UIImage *backImage = [UIImage imageNamed:@"public_back"];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"public_back_hightLight"] forState:UIControlStateHighlighted];
    
    [back addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    self.navigationItem.leftBarButtonItem = leftItem;

}
//系统的Item方法
-(void)navItemClick:(UIButton *)button
{

}

-(void)buildSeperateline
{
    UIView * seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 3)];
    seperateLine.backgroundColor = [UIColor colorWithHexString:@"#C1C1C1"];
    [self.view addSubview:seperateLine];

}

-(void)buildSeperatelineAndLiftItem
{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftButton.frame = CGRectMake(0, 0,  15, 15);
    
    leftButton.titleLabel.textColor = [UIColor blackColor];
    
    //    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    
    [leftButton setBackgroundImage:dPic_Public_back forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //导航条分割下,色值有待改变
    UIView * seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 3)];
    seperateLine.backgroundColor = [UIColor colorWithHexString:@"#C1C1C1"];
    [self.view addSubview:seperateLine];
}

-(void)createNavigation:(UIColor *)btnBgColor{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:dPic_Public_topmenu forState:UIControlStateNormal];
    leftBtn.backgroundColor = btnBgColor;
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    [leftBtn addTarget:self action:@selector(leftButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 注册下拉刷新和上拉刷新
/**注册下拉刷新和上拉刷新**/
- (void)setupRefresh:(UITableView *)newTableView
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [newTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.leftTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [newTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    newTableView.headerPullToRefreshText = @"下拉即可刷新";
    newTableView.headerReleaseToRefreshText = @"松开马上刷新";
    newTableView.headerRefreshingText = @"正在刷新";
    
    newTableView.footerPullToRefreshText = @"上拉即可刷新";
    newTableView.footerReleaseToRefreshText = @"松开马上刷新";
    newTableView.footerRefreshingText = @"正在刷新";
}
-(void)leftButtonOnClick:(UIButton*)btn
{
    
}
-(void)rightButtonOnClick:(UIButton*)btn
{
    
}

//必须被重写
-(void)headerRereshing
{
    
}//必须被重写
-(void)footerRereshing
{
    
}

#pragma mark - HMSegCtrl 创建HMSegCtrl,后添加的方法，

-(HMSegmentedControl *)createSegCtrlWithTitles:(NSArray *)titles
{
    
    HMSegmentedControl * seg = [[HMSegmentedControl alloc]initWithSectionTitles:titles];
    seg.selectionIndicatorColor = [UIColor redColor];
    seg.frame = CGRectMake(0, 0, kMainScreenWidth, 40);
    [seg setSelectedTextColor:[UIColor redColor]];
    seg.selectionStyle = HMSegmentedControlSelectionStyleBox;
    [seg setFont:[UIFont systemFontOfSize:14]];
    
    return seg;
}
@end
