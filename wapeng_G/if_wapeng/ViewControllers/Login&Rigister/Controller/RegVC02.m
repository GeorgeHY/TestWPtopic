//
//  RegVC02.m
//  if_wapeng
//
//  Created by 心 猿 on 14-12-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RegVC02.h"
#import "UIViewController+General.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIColor+AddColor.h"
#import "UINavigationBar+FlatUI.h"
#import "RegTools.h"
#import "RichLabelView.h"
#import "RegisterDataManager.h"
#import "CheckDataTool.h"
#import "TTTAttributedLabel.h"
#import "StringTool.h"
#import "RegVC03.h"
#import "RegisterMapViewController.h"
@interface RegVC02 ()<UITextFieldDelegate, TTTAttributedLabelDelegate>
{
    AFN_HttpBase * http;
    int num;
    NSTimer * timer;
    BOOL lock;//锁住whenTaps，防止60s倒计时被点击
    RegisterDataManager * _dataManager;//注册信息提取单例
    BOOL isVerify;//判断手机号是否合法或者是否被注册

}
@property (nonatomic, strong) NSString * regInfoId;//验证码id
@property (nonatomic, strong) NSString * reginfo;//验证码
@end

@implementation RegVC02


-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];
    timer = nil;
    self.msgCheckLbl.text = @"获取短信验证码";
    self.msgCheckLbl.textColor = [UIColor blackColor];
    lock = NO;
}


#pragma mark - 获取验证码
-(void)checkVerifyCode
{
    
    NSLog(@"helloworld");
    
    __weak RegVC02 * weakSelf = self;
    
//    __weak RegisterDataManager * weakDM = _dataManager;
    
    [http thirdRequestWithUrl:dUrl_ACC_1_2_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary* root  = (NSDictionary *)obj;
        NSDictionary* value =[root objectForKey:@"value"];
        //取值
//        weakDM.regInfoID=[value objectForKey:@"id"];
//        //取值
//        weakDM.regInfo= [value objectForKey:@"code"];
//
//        weakDM.phoneNum = self.phoneNumText.text;
        
        NSLog(@"%@", [value objectForKey:@"code"]);
        NSString * code = [value objectForKey:@"code"];
        weakSelf.msgCheckText.text = code;
        
        weakSelf.regInfoId = [value objectForKey:@"id"];
        weakSelf.reginfo = [value objectForKey:@"code"];
        
        NSLog(@"%@", weakSelf.reginfo);
        
    } failed:^(NSObject *obj, BOOL isFinished) {

    } andKeyValuePairs:@"regInfoQuery.actType",@"1",@"regInfoQuery.mobileNo",self.phoneNumText.text,nil];
}


#pragma mark 检查手机号是否已经注册
-(void)checkPhoneNum:(NSString *)phoneNum
{
    __weak RegVC02 * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_ACC_1_1_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * root = (NSDictionary *)obj;
        
        int result = [[root objectForKey:@"value"]intValue];
        
        if (! result == 0) {
            
            isVerify = NO;
            
            NSString * msg=[NSString stringWithFormat:@"您输入的号码%@已被注册，请直接输入密码登陆",self.phoneNumText.text];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }else{
            
            [SVProgressHUD showSuccessWithStatus:@"恭喜您，该手机号可以注册"];
            
            [weakSelf checkVerifyCode];
            
            [weakSelf startTimer];
            
        }
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        
    } andKeyValuePairs:@"accountQuery.mobileNo", phoneNum, nil];
}

#pragma mark - 开始倒计时
-(void)startTimer
{
    lock = YES;
    num = 60;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
    self.msgCheckLbl.textColor = [UIColor grayColor];
    
}
#pragma mark - 更新计时器
-(void)updateTimer
{
    num--;
    NSString * str = [NSString stringWithFormat:@"%d秒后重新获取", num];
    self.msgCheckLbl.text = str;
    
    if (num <= 0) {
        
        //释放定时器
        [timer invalidate];
        timer = nil;
        lock = NO;
        self.msgCheckLbl.text = @"获取短信验证码";
        self.msgCheckLbl.textColor = [UIColor blackColor];
    }
}

#pragma mark -  点击按钮之后先正则判断，如果过关然后再验证手机号是否被注册如果过关在发送验证码

-(void)regCheck
{
    BOOL isMatch =  [RegTools regResultWithString:self.phoneNumText.text];
    if (!isMatch) {
        
        [SVProgressHUD showErrorWithStatus:@"您输入的手机号码有误，请正确填写。"];
        
        return;
        
    }else{
        
        [self checkPhoneNum:self.phoneNumText.text];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新用户注册";
    
    http = [[AFN_HttpBase alloc]init];
    
    self.phoneNumText.delegate = self;
    self.msgCheckText.delegate = self;
    [self initLeftItem];
    
    //设置导航条颜色
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorWithHexString:@"#E9E9E9"]];

    self.msgCheckLbl.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
    
    self.navigationController.navigationBar.translucent = NO;
    
    lock = NO;
    
    __weak RegVC02 * weakSelf = self;
    
    [self.msgCheckLbl whenTapped:^{
        if (lock == NO) {

            [weakSelf regCheck];
        }
      
    }];
    
    [self loadTTTString];
    
    _dataManager = [RegisterDataManager shareInstance];
}
#pragma mark - 给tttstring 添加点击事件和颜色
-(void)loadTTTString
{
    NSString * aString =@"轻触右上的”注册“按钮，即表示您同意";
    
    NSString * bString = @"《比邻宝宝软件许可及服务协议》";
    
    self.protocolLbl.text = [StringTool assmbleRegisterTTTAttringStringWithString:aString bString:bString];
    
    NSRange range = NSMakeRange(aString.length, bString.length);
    NSString * urlStr = [NSString stringWithFormat:@"file:///wwwwwww"];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    
    [self.protocolLbl addLinkToURL:url withRange:range];
    
    self.protocolLbl.delegate = self;
}
#pragma mark - tttDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"协议的webView");
}
#pragma mark - 返回上一页
-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存数据

-(void)saveData
{
    
    _dataManager.phoneNum = self.phoneNumText.text;
    //默认密码为随机数，暂时这么写
    _dataManager.password = @"888888";
    _dataManager.regInfo = self.msgCheckText.text;
    _dataManager.regInfoID = self.regInfoId;
    
}

#pragma mark - 下一步

- (IBAction)nextBtnClick {
    
    NSLog(@"%@", self.reginfo);
    
    NSLog(@"%@", self.msgCheckText.text);
    if (![self.msgCheckText.text isEqualToString:self.reginfo]) {
        
        [SVProgressHUD showErrorWithStatus:@"验证码错误,请重新输入"];
        return;
    }
    
    [self saveData];
    
    
    RegVC03 * vc03 = [[RegVC03 alloc]initWithNibName:@"RegVC03" bundle:nil];
    
    [self.navigationController pushViewController:vc03 animated:YES];
}

#pragma mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.phoneNumText.text]) {

        isVerify = NO;
    }
}

#pragma mark - 取消键盘相应

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.msgCheckText resignFirstResponder];
    [self.phoneNumText resignFirstResponder];
}
@end
