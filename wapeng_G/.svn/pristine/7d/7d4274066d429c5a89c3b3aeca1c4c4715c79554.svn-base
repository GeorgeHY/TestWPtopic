//
//  RegVC03.m
//  if_wapeng
//
//  Created by 心 猿 on 14-12-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RegVC03.h"
#import "RegisterDataManager.h"
#import "RegisterMapViewController.h"
#import "UIViewController+General.h"
@interface RegVC03 ()<UITextFieldDelegate>
{
    RegisterDataManager * dm;
}

@property (weak, nonatomic) IBOutlet UITextField *nickText;

@property (nonatomic, assign)int genger;
@end

@implementation RegVC03

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //默认为男性
    self.title = @"您的昵称与常住地";
    self.genger = 1;
    [self initLeftItem];
    
    self.nickText.delegate = self;
}

-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nan:(id)sender {
    self.genger = 1;
}
- (IBAction)nv:(id)sender {
    self.genger = 2;
}

-(void)saveData
{
    dm = [RegisterDataManager shareInstance];
    dm.parentGender = [NSString stringWithFormat:@"%d", self.genger];
    dm.parentNickName = self.nickText.text;
}

- (IBAction)next:(id)sender {
    
    if (self.nickText.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"昵称不能为空"];
        return;
    }
    
    [self saveData];
    
    RegisterMapViewController * map = [[RegisterMapViewController alloc]init];
    map.type = 1;
    [self.navigationController pushViewController:map animated:YES];
}

#pragma mark - textFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
