//
//  RigisterVC02.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-28.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RigisterVC02.h"
#import "UIViewController+General.h"
#import "RigisterWithBaiduVC02.h"
#import "AFN_HttpBase.h"
#import "CheckDataTool.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIViewController+General.h"
#import "UIColor+AddColor.h"
#import "UINavigationBar+FlatUI.h"
#import "RegisterDataManager.h"
#import "LoginViewController.h"
@interface RigisterVC02 ()<UIAlertViewDelegate>
{
    RegisterDataManager * _dataManager;
    AFN_HttpBase * http;
    NSString * codeS;//验证码
    NSUserDefaults *usedefaults;
    UILabel * label;
    NSString * btnStr;
    NSInteger timeCounter;
    NSTimer *timer;
    UIButton * myBtn;
    NSString * phoneNumStr;
    UIView * bagV;
    UILabel *msgL;
    UILabel *btnLB;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;//电话号码
@property (weak, nonatomic) IBOutlet UITextField *msgCheckText;//短信验证
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;//提交
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;//点击发送验证
@property (weak, nonatomic) IBOutlet UIButton *optionBtn;//同意使用协议按钮
@property (weak, nonatomic) IBOutlet UILabel *optionLable;//同意使用协议


@end

@implementation RigisterVC02
//@synthesize timer = _timer;
//@synthesize timeCounter = _timeCounter;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"注册";
        http = [[AFN_HttpBase alloc]init];
        
    }
    return self;
}
#pragma mark 视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (checkMoblie:) name:dNOti_unique object:nil];
    // self.btn.enabled=YES;
    [timer invalidate];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor=[UIColor colorWithHexString:@"#e9e9e9"];
    btnLB=[[UILabel alloc]init];
    btnLB.frame=CGRectMake(0, 30,65 , 40);
    btnLB.numberOfLines=0;
    btnLB.font=[UIFont systemFontOfSize:15];
    btnLB.text=@"获取短信验证码";
    [self.btn addSubview:btnLB];
    phoneNumStr=@"";
    self.checkFlag=@"";
    if(phoneNumStr.length==0){
        self.btn.enabled=NO;
        self.btn.backgroundColor=[UIColor lightGrayColor];
    }
    self.view.backgroundColor = [UIColor colorWithHexString:@"#d5d6db"];
    usedefaults=[NSUserDefaults standardUserDefaults];
    self.msgCheckText.delegate = self;
    self.phoneNumText.delegate = self;
    _dataManager = [RegisterDataManager shareInstance];
    self.btn.tag=1000;
    [self createComponent ];
    
    
    UIImage *backImage = [UIImage imageNamed:@"public_back"];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"public_back_hightLight"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = left;
    
    
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //返回一个BOOL值，指定是否循序文本字段开始编辑
    //    phoneNumStr=self.phoneNumText.text;
    //    if (phoneNumStr.length!=0) {
    //        self.btn.enabled=YES;
    //    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //    //开始编辑时触发，文本字段将成为first responder
    [self.phoneNumText becomeFirstResponder];
    
    self.btn.enabled=YES;
    self.btn.backgroundColor=[UIColor greenColor];
}

#pragma mark 定时器
-(void)startTimer
{
    UIButton *btn  = (UIButton*)[self.view viewWithTag:1000];
    //    self.myLabel1.hidden=YES;
    //    self.myLabel1.enabled=NO;
    //    self.myLabel2.hidden=YES;
    //    self.myLabel2.enabled=NO;
    //    self.myLabel3.hidden=YES;
    //    self.myLabel3.enabled=NO;
    CGRect frame = self.btn.frame;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    self.placeholderLabel = [[UILabel alloc]init];
    //self.placeholderLabel.frame=CGRectMake(0, 0, 80, 40);
    self.placeholderLabel.textAlignment = NSTextAlignmentCenter;
    self.placeholderLabel.numberOfLines=0;
    self.placeholderLabel.font = [UIFont systemFontOfSize:18];
    self.placeholderLabel.frame=self.btn.bounds;
    self.placeholderLabel.textColor = [UIColor whiteColor];
    
    self.placeholderLabel.backgroundColor = [UIColor darkGrayColor];
    //self.btn.enabled=NO;
    NSLog(@"startTimer-------------------");
    [self.btn addSubview:self.placeholderLabel];
    timeCounter = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(regetAuthCodeEnabled) userInfo:nil repeats:YES];
}
#pragma mark 计时器
- (void)regetAuthCodeEnabled
{
    NSLog(@"regetAuthCodeEnabled");
    timeCounter--;
    btnStr = [NSString stringWithFormat:@"%ld s后重新获取",timeCounter];
    NSLog(@"倒计时%@",btnStr);
    
    self.placeholderLabel.text = btnStr;
    // self.placeholderLabel.tintColor=[UIColor blackColor];
    
    //self.btn.hidden=YES;
    // self.btn.selected=NO;
    self.btn.enabled=NO;
    [self.btn setTitle:@"" forState:UIControlStateNormal];
    if (self.checkFlag.length==0) {
        [self requestHttpCodeData];
    }else{
        NSLog(@"可以点");
        // self.btn.selected=YES;
        self.msgCheckText.text=self.checkFlag;
        self.btn.enabled=YES;
        [self.btn setTitle:@"注册" forState:UIControlStateNormal];
        [self.btn addTarget:self action:@selector(submitBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.placeholderLabel removeFromSuperview];
        [timer invalidate];
        
    }
    if (timeCounter == 0) {
        NSLog(@"time end!!!!!!!");
        self.btn.enabled=YES;
        //        self.navigationItem.leftBarButtonItem.enabled = YES;
        [self.btn setTitle:@"重新获取" forState:UIControlStateNormal];
        timeCounter = 60;
        [timer invalidate];
        [self.btn addTarget:self action:@selector(codeBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        timer = nil;
        [self.placeholderLabel removeFromSuperview];
        
        //  [self requestHttpCodeData];
        
    }
}

//General
-(void)navItemClick:(UIButton *)button
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"您确定要放弃本次注册吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=1200;
    alert.delegate=self;
    [alert show];
    // [self.navigationController popViewControllerAnimated:YES];
}


-(void) createComponent{
    
    self.phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    
    //    [self.optionBtn setBackgroundImage:[UIImage imageNamed:@"register1_check1.png"] forState:UIControlStateSelected];
    //    [self.optionBtn addTarget:self action:@selector(changeBtn) forControlEvents:UIControlEventTouchUpInside];
    //    [self.optionBtn setBackgroundImage:[UIImage imageNamed:@"register1_check0.png"] forState:UIControlStateNormal];
    //    self.optionBtn.selected = NO;
    //    self.optionBtn.adjustsImageWhenHighlighted = NO;
    
    
}


-(void) checkMoblie:(NSNotification * )notification
{
    
}
//协议点击监听
- (IBAction)changeSelect:(UIButton *)sender {
    sender.selected = !sender.selected;
}

//验证码
-(IBAction)codeBtnOnClick:(id)sender
{
    NSLog(@"codeBtnOnClick====%d",self.btn.enabled);
    
    if (![CheckDataTool checkInfo:self.phoneNumText msgContent:@"请填写手机号"]) {
        return;
    }
    NSString *str=self.phoneNumText.text;
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        bagV=[[UIView alloc]init];
        bagV.frame=CGRectMake(0,0,self.view.frame.size.width ,50);
        bagV.backgroundColor=[[UIColor yellowColor]colorWithAlphaComponent:0.5];
        [self.view addSubview:bagV];
        msgL=[[UILabel alloc]init];
        msgL.frame=CGRectMake(20, 10, self.view.frame.size.width-40, 30);
        msgL.text=@"您输入的手机号码有误，请正确填写";
        msgL.textColor=[UIColor redColor];
        [bagV addSubview:msgL];
        timeCounter=2;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkBagV) userInfo:nil repeats:YES];
    }
    else{
        NSLog(@"phone=%@",self.phoneNumText.text);
        NSString * phoneNum=self.phoneNumText.text;
        [self checkMobileData:str];
        //获取手机号
        _dataManager.phoneNum = _phoneNumText.text;
        [self startTimer];
        
    }
}
#pragma mark 检查手机号是否已经注册
-(void)checkMobileData:(NSString *)str
{
    [http thirdRequestWithUrl:dUrl_ACC_1_1_1 succeed:^(NSObject *obj, BOOL isFinished) {
        NSDictionary * resultDic=(NSDictionary *)obj;
        //NSLog(@"Result=%@",resultDic);
        NSString * value=[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"value"]];
        if (![value isEqualToString:@"0"]) {
            // [SVProgressHUD showSimpleText:@"该手机号已经注册"];
            [timer invalidate];
            
            NSString * msg=[NSString stringWithFormat:@"您输入的号码%@已被注册，请直接输入密码登陆",self.phoneNumText.text];
            _dataManager.registerPhoneNum=self.phoneNumText.text;
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            alert.delegate=self;
            alert.tag=1100;
            [alert show];
        }else{
            [btnLB removeFromSuperview];
            //            self.submitBtn.enabled=YES;
            //[SVProgressHUD showSimpleText:@"恭喜您，该手机号可以注册"];
        }
    } failed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSimpleText:@"手机号验证网络请求失败!!"];
    } andKeyValuePairs:@"accountQuery.mobileNo", str,nil];
    
}
#pragma mark 手机号输入有误的UIView
-(void)checkBagV
{
    timeCounter--;
    if (timeCounter==0) {
        [bagV removeFromSuperview];
        [msgL removeFromSuperview];
    }
}
#pragma mark 获取验证码
-(void)requestHttpCodeData
{
    [http thirdRequestWithUrl:@"/wpa/wb/macc/regInfoAction_getCode.action" succeed:^(NSObject *obj, BOOL isFinished) {
        NSDictionary* dicResult  = (NSDictionary *)obj;
        NSLog(@"succ");
        NSDictionary* valueDic =[dicResult objectForKey:@"value"];
        _dataManager.regInfoID=[valueDic objectForKey:@"id"];
        _dataManager.regInfo=[valueDic objectForKey:@"code"];
        self.btn.enabled=YES;
        NSString * value=[NSString stringWithFormat:@"%@",valueDic];
        if (![value isEqualToString:@"null"]) {
            self.checkFlag=[valueDic objectForKey:@"code"];
            //   self.btn.enabled=YES;
            // self.msgCheckText.text=[valueDic objectForKey:@"code"];
            //            self.btn.enabled=YES;
            //            [self.btn setTitle:@"注册" forState:UIControlStateNormal];
            //            [self.btn addTarget:self action:@selector(submitBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
            //            [self.placeholderLabel removeFromSuperview];
        }
        else{
            [SVProgressHUD showSimpleText:@"没有数据"];
        }
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSimpleText:@"请求失败"];
        [timer invalidate];
        self.checkFlag=@"";
        [self.placeholderLabel removeFromSuperview];
        self.btn.enabled=YES;
        [self.btn setTitle:@"重新获取" forState:UIControlStateNormal];
        [self.btn addTarget:self action:@selector(codeBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    } andKeyValuePairs:@"regInfoQuery.actType",@"1",@"regInfoQuery.mobileNo",self.phoneNumText.text,nil];
}

#pragma mark -- UIAlertViewDelegate --
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // LoginViewController * logVC=[[LoginViewController alloc]init];
    
    if(alertView.tag==1100)
    {
        switch (buttonIndex) {
            case 0:
                [self.navigationController popViewControllerAnimated:YES];
                break;
                
            default:
                break;
        }
    }
    if (alertView.tag==1200) {
        switch (buttonIndex) {
            case 0:
                
                break;
            case 1:
                [self.navigationController popViewControllerAnimated:YES];
                break;
            default:
                break;
        }
    }
}
#pragma mark 视图控制器消失
-(void)viewDidDisappear:(BOOL)animated
{
    [self.placeholderLabel removeFromSuperview];
    timer=nil;
    [timer invalidate];

    
}
#pragma mark 注册  提交   下一步
-(void)submitBtnOnClick
{
    //  [timer invalidate];
    //    if (!self.optionBtn.selected) {
    //        [SVProgressHUD showSimpleText:@"请同意协议"];
    //        return;
    //    }
    //    if (![CheckDataTool checkInfo:self.msgCheckText msgContent:@"请填写验证码"]) {
    //        return;
    //    }
    [self.placeholderLabel removeFromSuperview];
    [_dataManager printfSelf];
    if (_dataManager.regInfoID.length==0||self.msgCheckText.text.length<4) {
        [SVProgressHUD showSimpleText:@"请输入正确的验证码"];
        NSLog(@"ld",self.msgCheckText.text.length);
        [timer invalidate];
        return;
    }
    [timer invalidate];
    //[self.btn removeFromSuperview];
    RigisterWithBaiduVC02 * rigisterVC02 = [[RigisterWithBaiduVC02 alloc]initWithNibName:@"RigisterWithBaiduVC02" bundle:nil];
    [self.navigationController pushViewController:rigisterVC02 animated:YES];
    //     [[NSNotificationCenter defaultCenter] removeObserver:self name:dNOti_unique object:nil];
    //}//else{
    //  [SVProgressHUD showSimpleText:@"验证码不对"];
    //}
}

-(void)checkMobileWithPhoneNum:(NSString *)phoneNum
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary * para = @{@"AccountQuery": phoneNum};
    
    NSString * url = [NSString stringWithFormat:@"%@/wpa/wb/mpub/zoneAreaAction_getList.action",dAPP_URL_STR];
    
    [manager POST:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", [responseObject class]);
        
        NSDictionary * dict = (NSDictionary *)responseObject;
        
        NSLog(@"dict:%@", dict);
        
        //        NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
        //
        //        //保存手机号
        //        [d setObject:_phoneNumText.text forKey:UD_account_mobileNo];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma  mark 文本框代理textfied delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //    [textField resignFirstResponder];
    //    if (textField.tag==100) {
    //        NSLog(@"testOk!!");
    //        NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    //        NSString *str=self.phoneNumText.text;
    //
    //        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //
    //        BOOL isMatch = [pred evaluateWithObject:str];
    //        if (!isMatch) {
    //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号格式" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    //            [alert show];
    //        }
    //        else{
    //            self.btn.enabled=YES;
    //        }
    //    }
    return YES;
    
}

- (IBAction)regetBtnClick:(id)sender {
    
    
}

- (IBAction)submitBtnClick:(id)sender {
    
    if (self.phoneNumText.text.length == 0) {
        
        [SVProgressHUD showSimpleText:@"请输入手机号"];
        return;
    }
    
}
#pragma mark 键盘消失，触摸到空白处
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    NSLog(@"touchEND....");
    [timer invalidate];
    [self.phoneNumText resignFirstResponder];
    [bagV removeFromSuperview];
    [msgL removeFromSuperview];
    //    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    //    NSString *str=self.phoneNumText.text;
    //
    //    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //
    //    BOOL isMatch = [pred evaluateWithObject:str];
    //    if (!isMatch) {
    //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号格式" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    //        [alert show];
    //    }
    //    else{
    //        self.btn.enabled=YES;
    //    }
    //
    [self.msgCheckText resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
