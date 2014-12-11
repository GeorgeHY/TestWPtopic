//
//  ResertPasswordVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-27.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "ResertPasswordVC.h"
#import "UIViewController+General.h"
@interface ResertPasswordVC ()<UITextFieldDelegate>
{
    AFN_HttpBase *http;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *insurePasswordTextField;

@end

@implementation ResertPasswordVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        http = [[AFN_HttpBase alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.passwordTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.insurePasswordTextField.delegate = self;
    
    [self initLeftItem];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(setComplete)];
    self.navigationItem.rightBarButtonItem=rightButton;
}

-(void)setComplete
{
    [self changePasswordRequest];
}

-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 修改密码的请求。

-(void)changePasswordRequest
{
    if (![self.passwordTextField.text isEqualToString:self.insurePasswordTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
        return;
    }
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    //现在登录没有走通所以旧的密码先写死
    NSString * oldPassword = @"12345789";
    __weak ResertPasswordVC * weakSelf = self;
    [http thirdRequestWithUrl:dUrl_ACC_1_1_7 succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:dTips_changeSuccess];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:dTips_changeFailed];
        
    } andKeyValuePairs:@"D_ID", ddid, @"accountQuery.password", oldPassword, @"accountQuery.newpassword",self.insurePasswordTextField.text,nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.insurePasswordTextField resignFirstResponder];
}

@end
