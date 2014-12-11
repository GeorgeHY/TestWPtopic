//
//  MyTalkVC.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-16.
//  Copyright (c) 2014年 funeral. All rights reserved.
//我的话题

#import "MyTalkVC.h"
#import "UIViewController+General.h"
#import "MyTalkView.h"
#import "AFN_HttpBase.h"
#import "Item_MyTalkView.h"
#import "UIView+WhenTappedBlocks.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "UIViewController+MMDrawerController.h"

@interface MyTalkVC ()

@property(nonatomic , strong) UITextField * tf;
@property(nonatomic , strong) UIScrollView * scrollView;
@property(nonatomic ,strong) NSMutableArray * dataSourceLeft;
@property(nonatomic ,strong) NSMutableArray * dataSourceRight;
@property(nonatomic , strong)    UIImageView * aimIv;

@property(nonatomic , strong) MyTalkView * leftView;
@property(nonatomic , strong) MyTalkView * rightView;
@property(nonatomic , strong)  NSString * pageNum;

@end

@implementation MyTalkVC
{
    AFN_HttpBase * http;
    NSString * url;
    NSMutableDictionary * param;
    MBProgressHUD * loading;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的话题";
        
    }
    return self;
}
//我参与的
-(void)setRequestParticipationParam{
    [param removeAllObjects];
    AppDelegate * app = [AppDelegate shareInstace];
    [param setValue:[app.loginDict  objectForKey:@"d_ID"]  forKey:@"D_ID"];
    
}
//我发起的
-(void)setRequestSendParam:(NSString *)num{
    [param removeAllObjects];
    AppDelegate * app = [AppDelegate shareInstace];
    [param setValue:[app.loginDict  objectForKey:@"d_ID"]  forKey:@"D_ID"];
    [param setValue:num forKey:@"topicQuery.pageNum"];
}
//请求数据 0 代表左面的表 1 代表右面的表
-(void)requestData:(int )type{
    //    [self showLoading];
    __weak MyTalkVC * weakSelf = self;
    [http  sixReuqestUrl:url postDict:param succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        NSDictionary * dic = [(NSDictionary *)obj objectForKey:@"value"];
        NSArray * list = [dic objectForKey:@"list"];
        
        for (int i = 0; i<2; i++) {
            Item_MyTalkView*item = [[Item_MyTalkView alloc]  init];
            NSDictionary * dic = [list objectAtIndex:i];
            NSString * title = [dic  objectForKey:@"title"];
            NSString * replies = [dic objectForKey:@"replies"];
            NSString * friendCount = [dic objectForKey:@"viewFriendPartInCount"];
            item.title = title;
            item.friends = friendCount;
            replies = [NSString stringWithFormat:@"%@",replies];
            item.respond = replies;
            if (type == 0) {
                [weakSelf.dataSourceLeft addObject:item];
            }else{
                [weakSelf.dataSourceRight addObject:item];
            }
        }
        
        [weakSelf.leftView reloadTableData];
        [weakSelf.rightView reloadTableData];
        [weakSelf.leftView stopRefresh];
        [weakSelf.rightView stopRefresh];
        //        [weakSelf disMissLoading];
    } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        
    }];
}

-(void)createNavigation{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        [leftBtn setBackgroundImage:dPic_Public_topmenu forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"top_icon_huati_normal"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"top_icon_huati_selected"] forState:UIControlStateHighlighted];
    //    leftBtn.backgroundColor = [UIColor greenColor];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    [leftBtn addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}
//返回
-(void)leftDrawerButtonPress:(id)sender{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


-(void) createComponent
{
    http = [[AFN_HttpBase alloc]  init];
    param = [[NSMutableDictionary alloc]  init];
    self.dataSourceLeft = [[NSMutableArray alloc]  init];
    self.dataSourceRight = [[NSMutableArray alloc]  init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavigation];
    UIView * v = [[UIView alloc]  initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 60)];
    self.tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 40)];
    self.tf.delegate = self;
    UIImageView * magnify = [[UIImageView alloc]  initWithFrame:CGRectMake(10, 10, 20, 20)];
    UIImage * image = [UIImage imageNamed:@"public_ magnify.png"];
    magnify.image = image;
    self.tf.placeholder = @"版内搜索";
    self.tf.borderStyle = UITextBorderStyleRoundedRect;
    self.tf.clearButtonMode = UITextFieldViewModeAlways;
    self.tf.adjustsFontSizeToFitWidth = YES;
    self.tf.clearsOnBeginEditing = YES;
    self.tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.tf.keyboardType = UIKeyboardTypeDefault;
    self.tf.leftView = magnify;
    self.tf.leftViewMode = UITextFieldViewModeAlways;
    
    [v  addSubview:self.tf];
    [self.view addSubview:v];
    
    UIView * btnGroup = [[UIView alloc]  initWithFrame:CGRectMake(0,v.frame.origin.y + v.frame.size.height,self.view.frame.size.width, 40)];
    btnGroup.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btnGroup];
    
    self.aimIv = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0,self.view.frame.size.width/2, 40)];
    [self.aimIv setImage:[UIImage imageNamed:@"btn_age_perschooler.png"]];
    [btnGroup addSubview:self.aimIv];
    UILabel * leftLable = [[UILabel alloc]  initWithFrame:CGRectMake(0, 0,self.view.frame.size.width/2, 40)];
    leftLable.text = @"我发起的";
    leftLable.textColor = [UIColor whiteColor];
    leftLable.font = [UIFont boldSystemFontOfSize:17];
    leftLable.textAlignment = NSTextAlignmentCenter;
    UILabel * rightLable = [[UILabel alloc]  initWithFrame:CGRectMake(self.view.frame.size.width/2, 0,self.view.frame.size.width/2, 40)];
    rightLable.text = @"我参与的";
    rightLable.textColor = [UIColor whiteColor];
    rightLable.textAlignment = NSTextAlignmentCenter;
    rightLable.font = [UIFont boldSystemFontOfSize:17];
    [btnGroup addSubview:leftLable];
    [btnGroup addSubview:rightLable];
    
    
    UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width/2, 40)];
    [leftBtn  addTarget:self action:@selector(onTouchListener:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 100;
    [btnGroup addSubview:leftBtn];
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 0,self.view.frame.size.width/2, 40)];
    [rightBtn  addTarget:self action:@selector(onTouchListener:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    rightBtn.tag = 101;
    [btnGroup addSubview:rightBtn];
    
    
    
    self.scrollView = [[UIScrollView alloc]  initWithFrame:CGRectMake(0, v.frame.size.height + btnGroup.frame.size.height ,self.view.frame.size.width, self.view.frame.size.height - (v.frame.size.height+btnGroup.frame.size.height) - 49 - 64)];
    self.scrollView.backgroundColor = [UIColor redColor];
    self.leftView = [[MyTalkView alloc]initWithFrame:CGRectMake(0, 0 ,self.view.frame.size.width, self.view.frame.size.height - (v.frame.size.height+btnGroup.frame.size.height)-49-64)];
    
    self.rightView = [[MyTalkView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0,self.view.frame.size.width, self.view.frame.size.height - (v.frame.size.height+btnGroup.frame.size.height)-49-64)];
    [self.leftView  setDataSource:self.dataSourceLeft];
    [self.rightView  setDataSource:self.dataSourceRight];
    __weak MyTalkVC * weakSelf = self;
    self.leftView.headerBlock = ^{//刷新
        [weakSelf.dataSourceLeft  removeAllObjects];
        [weakSelf setRequestSendParam:weakSelf.pageNum];
        [weakSelf  requestData:0];
        
    };
    self.leftView.footerBlock = ^{//追加
        int  pagNumI = [weakSelf.pageNum intValue];
        pagNumI+= 1;
        weakSelf.pageNum = [NSString stringWithFormat:@"%d",pagNumI];
        [weakSelf setRequestSendParam:weakSelf.pageNum];
        [weakSelf requestData:0];
    };
    
    self.rightView.headerBlock = ^{
        [weakSelf.dataSourceRight removeAllObjects];
        [weakSelf setRequestSendParam:weakSelf.pageNum];
        [weakSelf requestData:1];
    };
    
    self.rightView.footerBlock = ^{
        int  pagNumI = [weakSelf.pageNum intValue];
        pagNumI+= 1;
        weakSelf.pageNum = [NSString stringWithFormat:@"%d",pagNumI];
        [weakSelf setRequestSendParam:weakSelf.pageNum];
        [weakSelf requestData:1];
    };
    
    [self.scrollView  addSubview:self.leftView];
    [self.scrollView  addSubview:self.rightView];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*2, self.view.frame.size.height- (v.frame.size.height+btnGroup.frame.size.height)-49-64);
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //    作用：决定了子视图的显示范围。具体的说，就是当取值为YES时，剪裁超出父视图范围的子视图部分；当取值为NO时，不剪裁子视图（超出部分继续显示，例如在scrollview中。。。）。默认值为NO。
    self.scrollView.clipsToBounds = YES;
    self.scrollView.pagingEnabled = YES;//页面翻动
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.directionalLockEnabled = YES;
    
    self.scrollView.scrollEnabled = NO;
    
    //    self.scrollView.showsHorizontalScrollIndicator = NO;
    //    self.scrollView.showsVerticalScrollIndicator = NO;
    
    //   当用户抵达滚动区域边缘时，这个功能允许用户稍微拖动到边界外一点。当用户松开手指后，这个区域会像个橡皮筋一样，弹回到原位，给用户一个可见的提示，表示他已经到达了文档开始或结束位置。如果不想让用户的滚动范围能够超出可见内容，可以将这个属性设置为NO。
    self.scrollView.bounces = NO;
    [self.view  addSubview:self.scrollView];
    [self.leftView setupRefresh];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageNum = @"1";
    url = TOP_1_2_9;
    [self createComponent];
}
//系统的Item方法
-(void)navItemClick:(UIButton *)button
{
    
}

-(void) onTouchListener:(UIButton *)button
{
    if(button.tag == 100){
        url = TOP_1_2_9;//我发起的
        CGSize viewSize = self.scrollView.frame.size;
        CGRect rect = CGRectMake(0, 0, viewSize.width, viewSize.height);
        [self.scrollView scrollRectToVisible:rect animated:YES];
        //        CGRect frame = self.aimIv.frame;
        [UIView animateWithDuration:0.3 animations:^{
            self.aimIv.frame = CGRectMake(0,self.aimIv.frame.origin.y,self.aimIv.frame.size.width, self.aimIv.frame.size.height);
        }];
    }else{
        url = TOP_1_2_10;//我参与的
        CGSize viewSize = self.scrollView.frame.size;
        CGRect rect = CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
        [self.scrollView scrollRectToVisible:rect animated:YES];
        [UIView animateWithDuration:0.3 animations:^{
            self.aimIv.frame = CGRectMake(self.aimIv.frame.size.width,self.aimIv.frame.origin.y,self.aimIv.frame.size.width, self.aimIv.frame.size.height);
        }];
        if (self.dataSourceRight.count <= 0) {
            [self.rightView setupRefresh];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)showLoading{
	loading = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:loading];
	loading.labelText = @"Loading";
    [loading show:YES];
}
-(void)disMissLoading{
    if (nil != loading) {
        [loading  removeFromSuperview];
    }
}


@end
