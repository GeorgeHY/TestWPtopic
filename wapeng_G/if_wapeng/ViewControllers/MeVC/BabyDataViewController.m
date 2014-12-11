//
//  BabyDataViewController.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-24.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "BabyDataViewController.h"
@interface BabyDataViewController ()
{
    float nav_Y;
    float nav_H;
    float screenheight;
    float screenWidth;
}
@end

@implementation BabyDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"宝宝资料";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"ziliao");
    [self initLayout];
    
    
    [self initDataSource];
    
    [self initUIView];
}
-(void)initLayout
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    nav_Y = [[d objectForKey:UD_navY]floatValue];
    
    nav_H = [[d objectForKey:UD_navH]floatValue];
    
    screenheight = [[d objectForKey:UD_screenHeight]floatValue];
    
    screenWidth = self.view.frame.size.width;
    
    CGFloat iosversion = [[[UIDevice currentDevice]systemVersion]floatValue];
    
    if (iosversion >= 7) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.navigationController.navigationBarHidden = YES;
    
}
-(void)initDataSource
{
    
}
-(void)initLeftItem
{
    UIImageView * leftIView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftIView.image = [UIImage imageNamed:@"1"];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftIView];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
-(void)initUIView
{
    [self initLeftItem];
    
    UITextField * nickNameField = [[UITextField alloc]initWithFrame:CGRectMake(20, nav_Y + 10, 200, 35)];
    nickNameField.placeholder = @"宝宝昵称";
    nickNameField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:nickNameField];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
