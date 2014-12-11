//
//  SetPasswordViewController.m
//  if_wapeng
//
//  Created by iwind on 14-11-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "RegisterDataManager.h"
#import "AFN_HttpBase.h"
#import "AppDelegate.h"
@interface SetPasswordViewController ()<UIAlertViewDelegate>
{
    RegisterDataManager * _dm;
    NSUserDefaults * ud;
    AFN_HttpBase * http;
    UITextField * alertText;
    NSString * alertFirstPwd;
    UIAlertView * alert;
    NSString * reg_Succ_D_ID;//注册成功时候，分配的D_ID
}
@end

@implementation SetPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"设置密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.firstPwd=@"2";
    ud=[NSUserDefaults standardUserDefaults];
    _dm=[RegisterDataManager shareInstance];
    http=[[AFN_HttpBase alloc]init];
    self.setPwdFlag=[[NSString alloc]init];
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(clickLeftButton)];
    self.navigationItem.leftBarButtonItem=leftButton;
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(setComplete)];
    self.navigationItem.rightBarButtonItem=rightButton;
    self.phoneNumText.text= [ud objectForKey:@"LoginSuccPhoneNum"];
    
    [self checkSetPwd];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.passWordText resignFirstResponder];
    [self.repeatPasswordText resignFirstResponder];
}
#pragma mark  获取account实体
-(void)checkSetPwd
{
    NSString *strUd= [ud objectForKey:UD_uuid];
    NSString * d_Id= [ud objectForKey:UD_LoginSucc_D_ID];
    NSLog(@"deviceCode=%@   NEWd_id=%@",strUd,d_Id);
    [http thirdRequestWithUrl:dUrl_ACC_1_1_7 succeed:^(NSObject *obj, BOOL isFinished) {
        NSDictionary * resultDic=(NSDictionary *)obj;
        NSDictionary * valueDic=[resultDic objectForKey:@"value"];
        NSString * valueStr=[NSString stringWithFormat:@"%@",valueDic];
        if ([valueStr isEqualToString:@"<null>"]) {
            [SVProgressHUD showSimpleText:@"对不起，没有对应的账户信息"];
            return;
        }else{
            self.setPwdFlag=[NSString stringWithFormat:@"%@",[valueDic objectForKey:@"setPassword"]];
            if ([self.setPwdFlag isEqualToString:@"1"]) {
                NSLog(@"--1--");
                self.firstPwd=@"1";//改过密码
                alert=[[UIAlertView alloc]initWithTitle:@"验证原密码" message:@"为保障你的数据安全，修改密码前请填写原密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.delegate=self;
                alert.tag=15000;
                alert.alertViewStyle= UIAlertViewStylePlainTextInput;
                [alert show];
            }else if([self.setPwdFlag isEqualToString:@"2"]){
                NSLog(@"--2--");
                self.firstPwd=@"2";//没动密码
                reg_Succ_D_ID=[ud objectForKey:UD_RegisterSucc_D_ID];
            }
            
        }
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID",d_Id, nil];
    
}
#pragma mark 点击右上角  完成 按钮触发的事件
-(void)setComplete
{
    if ([self.firstPwd isEqualToString:@"1"]) {
        alertFirstPwd=alertText.text;
        NSLog(@"firstPwd=%@",alertFirstPwd);
    }else if([self.firstPwd isEqualToString:@"2"]){
        NSLog(@"%@",self.firstPwd);
        [self submitHttpNewPwd];
        return;
    }
    NSString * passwd=self.passWordText.text;
    NSString * rePwd=self.repeatPasswordText.text;
    if (![passwd isEqual:rePwd]) {
        [SVProgressHUD showSimpleText:@"两次输入的密码不一致"];
        return;
    }else{
        NSString * login_D_Id= [ud objectForKey:@"login"];
        
        NSString * request_D_ID=[[NSString alloc]init];
        if (login_D_Id.length!=0) {
            request_D_ID=login_D_Id;
        }
        if (reg_Succ_D_ID.length!=0) {
            request_D_ID=reg_Succ_D_ID;
        }
        [http thirdRequestWithUrl:dUrl_ACC_1_1_7 succeed:^(NSObject *obj, BOOL isFinished){
            NSDictionary * resultDic=(NSDictionary *)obj;
            NSDictionary * valueDic=[resultDic objectForKey:@"value"];
            NSString * valueStr=[NSString stringWithFormat:@"%@",valueDic];
            if(![valueStr isEqualToString:@"<null>"]){
                //[ud objectForKey:UD_LoginSucc_D_ID];
                //[ud objectForKey:UD_RegisterSucc_D_ID];
                [ud setObject:@"" forKey:UD_LoginSucc_D_ID];
                [ud setObject:@"" forKey:UD_RegisterSucc_D_ID];
                [SVProgressHUD showSimpleText:@"修改密码成功"];
            }
        } failed:^(NSObject *obj, BOOL isFinished) {
            [SVProgressHUD showSimpleText:@"修改密码失败"];
        } andKeyValuePairs:@"D_ID",request_D_ID,@"accountQuery.password",alertFirstPwd,@"accountQuery.newpassword",passwd, nil];
    }
    
    
    
}
#pragma mark 登出
-(void)logOut{
    NSString *strUd= [ud objectForKey:UD_uuid];
    NSString * d_Id= [ud objectForKey:UD_LoginSucc_D_ID];
    NSString * regD_ID=[ud objectForKey:UD_RegisterSucc_D_ID];
    NSString * reqD_ID=[[NSString alloc]init];
    if (d_Id.length!=0) {
        reqD_ID=d_Id;
    }
    if (regD_ID.length!=0) {
        reqD_ID=regD_ID;
    }
    
    [http thirdRequestWithUrl:dUrl_ACC_1_1_5 succeed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSimpleText:@"注销成功"];
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID",reqD_ID,@"accountQuery.deviceCode",strUd,nil];
    AppDelegate * app = [AppDelegate shareInstace];
    // app.loginDict;
    [app  showViewController:showVCTypeLogin];
}
#pragma mark ACC1.1.6
-(void)submitHttpNewPwd
{
    NSLog(@"new");
    NSString * passwd=self.passWordText.text;
    NSString * rePwd=self.repeatPasswordText.text;
    if (![passwd isEqual:rePwd]) {
        [SVProgressHUD showSimpleText:@"两次输入的密码不一致"];
        return;
    }else{
        NSString * login_D_Id= [ud objectForKey:UD_LoginSucc_D_ID];
        NSString * request_D_ID=[[NSString alloc]init];
        if (login_D_Id.length!=0) {
            request_D_ID=login_D_Id;
        }
        if (reg_Succ_D_ID.length!=0) {
            request_D_ID=reg_Succ_D_ID;
        }
        [http thirdRequestWithUrl:dUrl_ACC_1_1_6 succeed:^(NSObject *obj, BOOL isFinished){
            NSDictionary * resultDic=(NSDictionary *)obj;
            [SVProgressHUD showSimpleText:@"修改成功"];
            [self logOut];
        } failed:^(NSObject *obj, BOOL isFinished) {
            [SVProgressHUD showSimpleText:@"修改密码网络请求失败"];
        } andKeyValuePairs:@"D_ID",request_D_ID,@"account.password", passwd,nil];
    }
}
#pragma mark  alertView   delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==15000&&buttonIndex==1) {
        //得到输入框
        alertText=[alertView textFieldAtIndex:0];
        NSLog(@"alert==%@",alertText.text);
    }
}
-(void)clickLeftButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
