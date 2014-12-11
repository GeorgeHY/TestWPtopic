//
//  LoginViewController.m
//  if_wapeng
//
//  Created by 永不死的圣斗士 on 14-6-18.
//  Copyright (c) 2014年 funeral. All rights reserved.

#define dTag_login 200
#define dTag_textBtn(i) i + 201
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "FinderPasswordVC.h"
#import "UIViewController+General.h"
#import "RigisterVC02.h"
#import "UIColor+AddColor.h"
#import "UIView+WhenTappedBlocks.h"
#import "ASIHttpTool.h"
#import "RegisterDataManager.h"
#import "GlobalKeys.h"
#import "RegVC02.h"
@interface LoginViewController ()
{
    AFN_HttpBase * afn;
    RegisterDataManager * _dm;
    NSString * checkFlag;
    NSUserDefaults * ud;
    NSString * strD_ID;
    UIButton * loginBtn;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //        self.title = @"登录";
        afn = [[AFN_HttpBase alloc]init];
        self.loginDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    ud=[NSUserDefaults standardUserDefaults];
    NSLog(@"用户偏好pwd=%@",[ud objectForKey:@"pwd"]);
    self.view.backgroundColor = [UIColor colorWithHexString:@"#d5d6db"];
    self.uuID=[ud objectForKey:UD_uuid];
    NSLog(@"用户偏好uuDI=%@",self.uuID);
    self.navigationController.navigationBar.translucent = NO;
    
    [self initLeftItem];
    
    [self initUIView];
    
    [self textLoginBtn];
}

-(void)textLoginBtn
{
    NSArray * name = @[@"机构用户", @"教师用户", @"家长用户1"];
    
    for (int i = 0; i < name.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor greenColor];
        btn.frame = CGRectMake(20, 20 + i* 50, kMainScreenWidth - 40, 40);
        btn.tag = dTag_textBtn(i);
        [btn setTitle:[name objectAtIndex:i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

#pragma mark 判断手机号是否符合格式规范,是否已经注册
-(void)checkMobileWithPhoneNum:(NSString *)phoneNum
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:phoneNum];
    if (!isMatch) {
        [SVProgressHUD showSimpleText:@"手机号码格式输入不对"];
        return;
    }else{
        [afn thirdRequestWithUrl:dUrl_ACC_1_1_1 succeed:^(NSObject *obj, BOOL isFinished){
            NSDictionary * resultDic=(NSDictionary *)obj;
            //NSLog(@"Result=%@",resultDic);
            NSString * value=[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"value"]];
            if (![value isEqualToString:@"0"]) {
                checkFlag=@"1";
                //loginBtn.enabled=YES;
            }else{
                checkFlag=@"0";
                [SVProgressHUD showSimpleText:@"该手机号尚未注册"];
                return;
            }
            
        } failed:^(NSObject *obj, BOOL isFinished) {
            NSLog(@"test register failed------");
            [SVProgressHUD showSimpleText:@"核对手机号是否注册网络请求失败"];
            return;
        } andKeyValuePairs:@"accountQuery.mobileNo",phoneNum,nil];
    }
}
#pragma mark -验证手机号码是否注册后,并且点击登陆按钮,请求登陆
-(void)requestLogin:(NSString *) pwd
{
    // NSLog(@"登陆uuid=%@",_dm.uuid);
    if (self.uuID.length==0) {
        self.uuID=@"";
    }
    __weak LoginViewController * weakSelf = self;
    [afn thirdRequestWithUrl:dUrl_ACC_1_1_3 succeed:^(NSObject *obj, BOOL isFinished) {
        NSDictionary * retDict = (NSDictionary *)obj;
        weakSelf.loginDict = [retDict objectForKey:@"value"];
        _dm.login_D_ID=[[retDict objectForKey:@"value"]objectForKey:@"d_ID"];
        NSDictionary * valueDic= [retDict objectForKey:@"value"];
        
        strD_ID=[NSString stringWithFormat:@"%@",[valueDic objectForKey:@"d_ID"]];
        [ud setObject:self.userIdText.text forKey:@"LoginSuccPhoneNum"];
        //使用userDefaults ,存储D_ID
        [ud setObject:strD_ID forKey:UD_LoginSucc_D_ID];
        //[ud objectForKey:@"pwd"];
        [ud setObject:@"" forKey:@"pwd"];
        _dm.login_D_ID=strD_ID;
        NSLog(@"strID===%@",strD_ID);
        NSLog(@"loginD_ID=%@",[ud objectForKey:@"login"]);
        //showVCTypeTab
        AppDelegate * app = [AppDelegate shareInstace];
        app.loginDict= weakSelf.loginDict;
        [app  showViewController:showVCTypeTab];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSimpleText:@"网络请求失败"];
    } andKeyValuePairs:@"accountQuery.userName", self.userIdText.text,@"accountQuery.password",pwd, @"accountQuery.deviceCode", self.uuID, nil];
}
-(void)initUIView
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(120, 44, kMainScreenWidth - 240, kMainScreenWidth - 240)];
    imageView.image = [UIImage imageNamed:@"userheard"];
    [self.view addSubview:imageView];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y + imageView.frame.size.height + 10, kMainScreenWidth, 44)];
    label.text = @"用户登录";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:label];
    self.userIdText = [[UITextField alloc]initWithFrame:CGRectMake(20, label.frame.size.height + label.frame.origin.y + 5, 280, 40)];
    
    self.userIdText.borderStyle = UITextBorderStyleNone;
    self.userIdText.textAlignment = NSTextAlignmentCenter;
    self.userIdText.placeholder = @"手机号/娃朋号";
    self.userIdText.background = [UIImage imageNamed:@"public_tf"];
    self.userIdText.keyboardType = UIKeyboardTypeNumberPad;
    
    self.userIdText.delegate = self;
    
    [self.view addSubview:self.userIdText];
    
    self.passwordText = [[UITextField alloc]initWithFrame:CGRectMake(20, self.userIdText.frame.origin.y + self.userIdText.frame.size.height + 15, 280, 40)];
    self.passwordText.textAlignment = NSTextAlignmentCenter;
    self.passwordText.borderStyle = UITextBorderStyleNone;
    self.passwordText.background = [UIImage imageNamed:@"public_tf"];
    //    self.passwordText.background  = [UIImage imageWithContentsOfFile:@"public_tf"];
    //    self.passwordText.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:@"public_tf"]];
    self.passwordText.secureTextEntry = YES;
    self.passwordText.placeholder = @"密码";
    
    self.passwordText.delegate = self;
    
    [self.view addSubview:self.passwordText];
    loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, self.passwordText.frame.size.height + self.passwordText.frame.origin.y + 15, 280, 44)];
    //loginBtn.enabled=NO;
    [loginBtn  setBackgroundImage:dPic_Public_redBtn forState:(UIControlStateNormal)];
    
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    loginBtn.tag = dTag_login;
    
    [loginBtn addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginBtn];
    
    UILabel * forgetLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, loginBtn.frame.origin.y + loginBtn.frame.size.height + 10, kMainScreenWidth - 200, 25)];
    forgetLabel.textAlignment = NSTextAlignmentCenter;
    forgetLabel.text = @"忘记密码?";
    forgetLabel.textColor = [UIColor blueColor];
    [self.view addSubview:forgetLabel];
    [forgetLabel whenTapped:^{
        FinderPasswordVC * finderVC = [[FinderPasswordVC alloc]init];
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:finderVC animated:YES];
    }];
    
    UILabel * registerLabel = [[UILabel alloc]initWithFrame:CGRectMake(80,self.view.frame.size.height - 100, kMainScreenWidth - 160, 40)];
    registerLabel.text = @"新用户注册";
    registerLabel.font = [UIFont systemFontOfSize:20];
    registerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:registerLabel];
    [registerLabel whenTapped:^{
//        RigisterVC02 * registerVC = [[RigisterVC02 alloc]initWithNibName:@"RigisterVC02" bundle:nil];
        RegVC02 * registerVC = [[RegVC02 alloc]initWithNibName:@"RegVC02" bundle:nil];
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:registerVC animated:YES];
    }];
}
#pragma mark ---点击登陆按钮  然后调用登陆接口
-(void)btnLoginClick:(UIButton *)sender
{
    NSString *str=[ud objectForKey:@"pwd"];
    // if(str.length!=0){
    //     self.modifyPwd=[ud objectForKey:@"pwd"];
    // }else{
    self.modifyPwd=self.passwordText.text;
    //}
    
    if ([checkFlag isEqualToString:@"1"]&&self.passwordText.text.length!=0) {
        [self requestLogin:self.modifyPwd];
    }else{
        [SVProgressHUD showSimpleText:@"请先输入用户名或密码"];
        return;
    }
}
#pragma mark-UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.userIdText) {
        [self checkMobileWithPhoneNum:textField.text];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)btnClick:(UIButton *)button
{
  
    NSString * password = nil;
    
    
    password = @"123";
    
    switch (button.tag) {
        case dTag_textBtn(0):
        {
            //机构用户
//            self.accountType = 0;
            self.account = @"10000000001";
//            pwd = @"123";
        }
            break;
        case dTag_textBtn(1):
        {
            //教师用户
//            self.accountType = 1;
            self.account = @"20000000001";
        }
            break;
        case dTag_textBtn(2):
        {
            //家长用户
            self.accountType  = 2;
            self.account = @"30000000001";
            password = @"1111";
        }
            //        case dTag_textBtn(3):
            //        {
            //            //家长用户
            //            self.accountType  = 3;
            //        }
            //            break;
            //        case dTag_textBtn(4):
            //        {
            //            //家长用户
            //            self.accountType  = 4;
            //        }
            //            break;
            //        case dTag_textBtn(5):
            //        {
            //             AppDelegate * app = [AppDelegate shareInstace];
            //            [app showViewController:3];
            //        }
            //            break;
        default:
            break;
    }
    
    
    
    NSString * uuid = [[NSUserDefaults standardUserDefaults]  objectForKey:UD_uuid];
    if (_dm.registerSuccPassword.length==0) {
        _dm.registerSuccPassword=@"";
    }
    __weak LoginViewController * weakSelf = self;
    
    NSLog(@"count:%@", self.account);
    NSLog(@"password:%@", password);
    [afn thirdRequestWithUrl:dUrl_ACC_1_1_3 succeed:^(NSObject *obj, BOOL isFinished) {
//        NSDictionary * retDict = (NSDictionary *)obj;
//        weakSelf.loginDict = [retDict objectForKey:@"value"];
//        _dm.login_D_ID=[[retDict objectForKey:@"value"]objectForKey:@"d_ID"];
//        NSLog(@" did   %@",_dm.login_D_ID);
//        NSString *strD_ID=[NSString stringWithFormat:@"%@",_dm.login_D_ID];
//        if ([strD_ID isEqualToString:@"(null)"]) {
//            NSLog(@"mei   you");
//            return ;
//        }
        

        NSDictionary * root = (NSDictionary *)obj;
        
        weakSelf.loginDict = [root objectForKey:@"value"];
        
        //保存登录返回的字典
        AppDelegate * app = [AppDelegate shareInstace];
        app.loginDict = weakSelf.loginDict;
        [app showViewController:showVCTypeTab];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSimpleText:@"手机号没有注册"];
    } andKeyValuePairs:@"accountQuery.userName", self.account,@"accountQuery.password",password, @"accountQuery.deviceCode", uuid, nil];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self checkMobileWithPhoneNum:self.userIdText.text];
    [self.userIdText resignFirstResponder];
    
    [self.passwordText resignFirstResponder];
}

#pragma mark -- 找回密码
-(void)findingPassword
{
    FinderPasswordVC * finderVC = [[FinderPasswordVC alloc]init];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:finderVC animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
