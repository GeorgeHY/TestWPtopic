//
//  LetterVC.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-22.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "LetterVC.h"
#import "UIViewController+General.h"
#import "LetterFlagVC.h"
@interface LetterVC ()

@end

@implementation LetterVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"私信";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:dPic_Public_back forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    [leftBtn  addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(0, 0, 60, 25);
    [rightBtn  setTitle:@"发送" forState:UIControlStateNormal];
    rightBtn.titleLabel.textColor = [UIColor blackColor];
    [rightBtn addTarget:self action:@selector(navItemRightClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
//系统的Item方法
-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)navItemRightClick:(UIButton *) b
{
    LetterFlagVC * letterFlag = [[LetterFlagVC alloc]  initWithNibName:@"LetterFlagVC" bundle:nil];
    [self.navigationController pushViewController:letterFlag animated:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
