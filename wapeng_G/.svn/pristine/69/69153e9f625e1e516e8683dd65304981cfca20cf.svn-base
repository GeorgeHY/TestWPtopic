//
//  MeLeftVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MeLeftVC.h"

@interface MeLeftVC ()
{
    float nav_Y;
    float nav_H;
    float screenheight;
    float screenwidth;
}
@end

@implementation MeLeftVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)createLayout
{
    CGFloat iosversion = [[[UIDevice currentDevice]systemVersion]floatValue];
    
    if (iosversion >= 7) {
        
        nav_Y = 64;
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }else{
        nav_Y = 0;
    }
    screenheight = self.view.frame.size.height;
    screenwidth = self.view.frame.size.width;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createLayout];
    
    [self createUI];
}
-(void)createUI
{
    //顶部的"导航"视图
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, nav_Y, screenwidth, 88)];
//    
//    UIButton * headPicButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    headPicButton.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
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
