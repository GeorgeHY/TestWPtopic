//
//  RegisterVC09.m
//  if_wapeng
//
//  Created by 永不死的圣斗士 on 14-6-26.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RegisterVC09.h"
#import "RigisterVC10.h"
@interface RegisterVC09 ()
{
    float nav_Y;
    
    float nav_H;
    
}
@end

@implementation RegisterVC09

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"设置头像";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    nav_Y = [[d objectForKey:UD_navY]floatValue];
    
    nav_H = [[d objectForKey:UD_navH]floatValue];
    
    [self initUIView];
}

-(void)initUIView
{
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, 50, 35);
    
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    leftBtn.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    UIImageView * headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, nav_Y, 100, 100)];
    
    headImageView.backgroundColor = [UIColor redColor];
    
    headImageView.image = [UIImage imageNamed:@"2"];
    
    [self.view addSubview:headImageView];
    
    UIButton * takePhoto = [UIButton buttonWithType:UIButtonTypeSystem];
    
    takePhoto.frame = CGRectMake(160, nav_Y, 100, 44);
    
    [takePhoto setTitle:@"现在拍照" forState:UIControlStateNormal];
    
    [takePhoto addTarget:self action:@selector(takePhotoClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:takePhoto];
    
    UIButton * startWPBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    startWPBtn.backgroundColor = [UIColor redColor];
    
    [startWPBtn setTitle:@"开启娃朋之旅" forState:UIControlStateNormal];
    
    startWPBtn.frame = CGRectMake(100, nav_Y + 120, 120, 44);
    
    [startWPBtn addTarget:self action:@selector(startWPClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:startWPBtn];
    
    
}

-(void)takePhotoClick:(UIButton *)button
{
    [SVProgressHUD showSimpleText:@"拍照"];
}
-(void)startWPClick:(UIButton *)button
{
    RigisterVC10 * registerVC10 = [[RigisterVC10 alloc]init];
    
    [self.navigationController pushViewController:registerVC10 animated:YES];
}
-(void)leftBtnClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
