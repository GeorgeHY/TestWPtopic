//
//  WelcomeVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-12-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "WelcomeVC.h"
#import "LoginViewController.h"
#import "RegVC02.h"
@interface WelcomeVC ()

@end

@implementation WelcomeVC


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)login:(id)sender {
    
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)register:(id)sender {
    
    RegVC02 * regvc  = [[RegVC02 alloc]initWithNibName:@"RegVC02" bundle:nil];
    [self.navigationController pushViewController:regvc animated:YES];
}
@end
