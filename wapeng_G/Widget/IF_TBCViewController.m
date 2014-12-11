//
//  IF_TBCViewController.m
//  if_wapeng
//
//  Created by 永不死的圣斗士 on 14-6-17.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define dModule(i)  i // 不同的模块 1.橱窗 2.话题 3.活动 4.我的
#define height_tabbar 49
#define tag_buttons(i)  101 + i
#import "IF_TBCViewController.h"
#import "ShowWindowLeftVC.h"
#import "HotLeftViewController.h"
#import "ActivityLeftVC.h"
#import "MeLeftVC.h"
#import "AppDelegate.h"
#import "TabItem.h"
@interface IF_TBCViewController ()
{
    NSArray * _imageArray;
    NSArray * tabBarItemBgArray;
    UIButton * lastBtn;
}
@end

@implementation IF_TBCViewController
@synthesize mainView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark - tabbar按钮被点击

-(void)buttonClick:(UIButton *)button
{
    if (button == lastBtn) {
        return;
    }
    self.selectedIndex = button.tag;
    
    [self setLeftVC:self.selectedIndex + 1];
    
    button.backgroundColor = [tabBarItemBgArray objectAtIndex:button.tag];
    
    lastBtn.backgroundColor = [UIColor clearColor];
    lastBtn = button;
}
-(void)setItemWithIndexBg:(int)index{
    self.selectedIndex = index;
    UIButton * button = [self.butArray  objectAtIndex:index];
    button.backgroundColor = [tabBarItemBgArray objectAtIndex:index];
    lastBtn = button;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard:) name:dNoti_isHideKeyBoard object:nil];
    

     self.butArray = [[NSMutableArray alloc]  init];
    self.tabBar.hidden = YES;//隐藏tabBar
    //mainView是配合左菜单滑动的动画使用的
    mainView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - height_tabbar, 320 , height_tabbar)];
//    mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth , height_tabbar)];

    mainView.backgroundColor = [UIColor blackColor];
    NSArray * imageArray = @[dPic_show, dPic_topic, dPic_exercise, dPic_me];
    
    UIColor *color1 = kRGB(217, 78, 48);
    UIColor *color2 = kRGB(225, 136, 42);
    UIColor *color3 = kRGB(84, 113, 178);
    UIColor *color4 = kRGB(132, 75, 161);
    
    NSArray *titles = @[@"橱窗",@"话题",@"活动",@"个人"];
    
    tabBarItemBgArray = [[NSArray alloc]  initWithObjects:color1,color2,color3,color4,nil];
    
    
    for (int i = 0; i < imageArray.count; i++) {
        CGRect frame = CGRectMake(kMainScreenWidth/4.0 *i, 0, kMainScreenWidth/4.0, height_tabbar);
        TabItem * grid = [[TabItem alloc]initWithFrame:frame title:titles[i] image:imageArray[i]];
        [self.butArray  addObject:grid];
//        grid.
//        grid.backgroundColor = [UIColor clearColor];
//        
//        UIImageView * iView = [[UIImageView alloc]init];
//        iView.frame = CGRectMake(27, 10, 26, 26);
//        iView.image = [imageArray objectAtIndex:i];
//        [grid addSubview:iView];
        grid.tag = i;
        [mainView addSubview:grid];

        [grid addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    }
    
//    [self.tabBar addSubview:mainView];
     [self.view addSubview:mainView];
    
    self.tabBarController.delegate = self;
 }

//将tabBar 隐藏或者显示
- (void)hideKeyBoard:(NSNotification *)notification
{
    NSString * key = [notification  object];
    if ([@"0" isEqualToString:key]) {
        [self.mainView setHidden:YES];
    }else{
        [self.mainView setHidden:NO];
    }
}

/*
 function :此方法不仅为 “拍照” 模块隐藏tabbar而设计
 而且为MMDrawer的中菜单跳进详情页而设计，在后一种情下viewwillappear和viewwilldisappear 或者 pop的时候发通知
 para     : 通知
 return   :
 */
-(void)updateMainView:(NSNotification *)notify
{
    NSString * type = [NSString stringWithFormat:@"%@", notify.object];
    //显示
    if ([type isEqualToString:@"1"]) {
        [UIView animateWithDuration:.5 animations:^{
            
            self.mainView.frame = CGRectMake(0, self.view.frame.size.height - height_tabbar, 320 , height_tabbar);
            self.mainView.hidden = NO;
        }];
    }
    //隐藏
    if ([type isEqualToString:@"2"]) {
        [UIView animateWithDuration:.5 animations:^{
            CGRect frame = self.mainView.frame;
            frame.origin.y += height_tabbar;
            self.mainView.frame = frame;
            self.mainView.hidden = YES;
        }];
    }
}
-(void)setLeftVC:(NSInteger)type
{
    ShowWindowLeftVC * vc01 = [[ShowWindowLeftVC alloc]init];
    HotLeftViewController * vc02 = [[HotLeftViewController alloc]init];
    ActivityLeftVC * vc03 = [[ActivityLeftVC alloc]init];
    MeLeftVC * vc04 = [[MeLeftVC alloc]init];
    
    AppDelegate * app = [AppDelegate shareInstace];
    switch (type) {
        case dModule(1):
        {
            [app.mmVC setLeftDrawerViewController:vc01];
        }
            break;
        case dModule(2):
        {
            [app.mmVC setLeftDrawerViewController:vc02];
        }
            break;
        case dModule(3):
        {
            [app.mmVC setLeftDrawerViewController:vc03];
        }
            break;
        case dModule(4):
        {
            [app.mmVC setLeftDrawerViewController:nil];
            
        }
            break;
        default:
            break;
    }
}
//重置中菜单
-(void)reloadTBCWithController:(UIViewController *)vc
{
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    NSInteger index = self.selectedIndex;
    NSMutableArray * temp = [[NSMutableArray alloc]initWithArray:self.viewControllers];
    [temp removeObjectAtIndex:index];
    [temp insertObject:nav atIndex:index];
    self.viewControllers = temp;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
