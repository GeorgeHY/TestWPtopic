//
//  FinderPasswordVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-28.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define dTag_phoneNum  300
#define dTag_addtion   301
#define dTag_msgText   302
#import "FinderPasswordVC.h"
#import "FinderPasswordVC02.h"
#import "AFN_HttpBase.h"
#import "UIColor+AddColor.h"
#import "UIViewController+General.h"
#import "UINavigationBar+FlatUI.h"
#import "RegTools.h"
@interface FinderPasswordVC ()
{
    AFN_HttpBase * http;
    
    UITextField * msgCheckText;
    
    BOOL isRegister;//手机号码是否被注册
}
@property (nonatomic, strong)UITextField * msgCheckText;
@end

@implementation FinderPasswordVC
@synthesize msgCheckText;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
        http = [[AFN_HttpBase alloc]init];
        _msgID = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLeftItem];
    
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.title = @"找回密码";

    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
   
    UITextField * phoneNumText = [[UITextField alloc]initWithFrame:CGRectMake(20,  20, kMainScreenWidth - 40, 35)];
    phoneNumText.placeholder = @"请输入手机号码";
    phoneNumText.tag = dTag_phoneNum;
    phoneNumText.borderStyle = UITextBorderStyleRoundedRect;
    phoneNumText.background = dPic_Public_textField;
    phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneNumText];
    
    UITextField * addtionNum = [[UITextField alloc]initWithFrame:CGRectMake(20, phoneNumText.frame.size.height + phoneNumText.frame.origin.y + 30, 100, 35)];
    addtionNum.background = dPic_Public_textField;
    addtionNum.tag = dTag_addtion;
    //    addtionNum.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:addtionNum];
    
    CGRect frame = addtionNum.frame;
    frame.origin.x = frame.origin.x + frame.size.width + 20;
    frame.size.width = 80;
    
    self.checkCodeNumberLabel = [[UILabel alloc]initWithFrame:frame];
    [self.view addSubview:self.checkCodeNumberLabel];
    
    //生成附加码
    [self onTapToGenerateCode];
    
    UIButton * changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeButton setTitle:@"换一张" forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changeButton.titleLabel.textColor = [UIColor blackColor];
    frame.origin.x = frame.origin.x + frame.size.width + 10;
    frame.size.width = 60;
    changeButton.frame = frame;
    
    [changeButton addTarget:self action:@selector(changeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:changeButton];
    
    
    msgCheckText = [[UITextField alloc]initWithFrame:CGRectMake(20, addtionNum.frame.size.height + addtionNum.frame.origin.y + 20, 100, 40)];
    msgCheckText.background = dPic_Public_textField;
    msgCheckText.tag = dTag_msgText;
    //    msgCheckText.borderStyle = UITextBorderStyleRoundedRect;
    msgCheckText.placeholder = @"短信验证";
    [self.view addSubview:msgCheckText];
    
    UIButton * getMesgCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getMesgCheckBtn setTitle:@"点击重新发送" forState:UIControlStateNormal];
    [getMesgCheckBtn setBackgroundImage:[UIImage imageNamed:@"guanzhu.png"] forState:UIControlStateNormal];
    [getMesgCheckBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    frame= msgCheckText.frame;
    frame.origin.x = frame.origin.x + frame.size.width + 20;
    frame.size.width = 150;
    getMesgCheckBtn.frame = frame;
    
    [getMesgCheckBtn addTarget:self action:@selector(getMsgClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:getMesgCheckBtn];
    
    UIButton * netxStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    netxStepButton.frame = CGRectMake(20, getMesgCheckBtn.frame.origin.y + getMesgCheckBtn.frame.size.height + 40, 280, 40);
    [netxStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [netxStepButton setBackgroundImage:dPic_Public_redBtn forState:UIControlStateNormal];
    [netxStepButton addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:netxStepButton];
    
    UIImage *backImage = [UIImage imageNamed:@"public_back"];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"public_back_hightLight"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = left;
}
//General
-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
//换一张的按钮被点击
-(void)changeButtonClick
{
    [self onTapToGenerateCode];
}

#pragma mark - 先判断手机号是否被注册过

-(void)getMsgClick
{
    UITextField * phoneNumText = (UITextField *)[self.view viewWithTag:dTag_phoneNum];
    //正则判断手机号是否合法
    BOOL isMatch = [RegTools regResultWithString:phoneNumText.text];
    
    if (!isMatch) {
        
        [SVProgressHUD showErrorWithStatus:@"手机号格式有误，请重新输入"];
    }
    
    
    __weak FinderPasswordVC * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_ACC_1_1_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * dict = (NSDictionary *)obj;
        NSString * value = [NSString stringWithFormat:@"%@", [dict objectForKey:@"value"]];
        
        if ([value isEqualToString:@"0"]){
            [SVProgressHUD showSimpleText:@"手机号码没有被注册"];
            isRegister = NO;
        }else{
            //手机号码被注册过
            isRegister = YES;
            [weakSelf startGetMsgRequest];
        }
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"accountQuery.mobileNo",phoneNumText.text,nil];

}
#pragma - mark -如果手机号被注册过，就返回短信验证码
-(void)startGetMsgRequest
{

    __weak FinderPasswordVC * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_ACC_1_2_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * dict = (NSDictionary *)obj;
        
        
        NSDictionary * valueDict = [dict objectForKey:@"value"];
        weakSelf.code = [valueDict objectForKey:@"code"];
        weakSelf.msgID = [NSString stringWithFormat:@"%@", [valueDict objectForKey:@"id"]];
        
#warning - 暂时回显在tf上
        weakSelf.msgCheckText.text = weakSelf.code;
      
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        
        
    } andKeyValuePairs:@"regInfoQuery.actType", @"2", @"regInfoQuery.mobileNo", _phoneNum , nil];
    
}
-(void)nextStepClick
{
    NSLog(@"下一步");
    
    UITextField * tf1 = (UITextField *)[self.view viewWithTag:dTag_phoneNum];//手机号
    UITextField * tf2 = (UITextField *)[self.view viewWithTag:dTag_addtion];//验证码
    UITextField * tf3 = (UITextField *)[self.view viewWithTag:dTag_msgText];//
    
    if (tf1.text.length == 0 || tf1.text.length != 11) {
        
        [SVProgressHUD showSimpleText:@"手机号输入有误"];
        
                return;
    }
    if (tf2.text.length != 0 && [tf2.text isEqualToString:self.code]) {
        
                [SVProgressHUD showSimpleText:@"附加码输入正确"];
        return;
        
    }
    if (tf3.text.length == 0) {
        
        [SVProgressHUD showSimpleText:@"请输入短信验证码"];
        
        return;
    }
    if (![tf3.text isEqualToString:self.code]) {
        
        [SVProgressHUD showErrorWithStatus:@"短信验证码输入错误，请重新输入"];
        return;
    }
    
    FinderPasswordVC02 * fvc02 = [[FinderPasswordVC02 alloc]initWithNibName:@"FinderPasswordVC02" bundle:nil];
    
    fvc02.userName = tf1.text;
    
    fvc02.RegInfoCode = tf3.text;
    
    fvc02.RegInfoID = _msgID;
    
    [self.navigationController pushViewController:fvc02 animated:YES];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITextField * tf1 = (UITextField *)[self.view viewWithTag:dTag_phoneNum];
    
    UITextField * tf2 = (UITextField *)[self.view viewWithTag:dTag_addtion];
    
    UITextField * tf3 = (UITextField *)[self.view viewWithTag:dTag_msgText];
    
    [tf1 resignFirstResponder];
    
    [tf2 resignFirstResponder];
    
    [tf3 resignFirstResponder];
}
#pragma mark-- 生成本地附加码
- (void)onTapToGenerateCode {
    for (UIView *view in self.checkCodeNumberLabel.subviews) {
        [view removeFromSuperview];
    }
    // @{
    // @name 生成背景色
    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.2];
    [self.checkCodeNumberLabel setBackgroundColor:color];
    // @} end 生成背景色
    
    // @{
    // @name 生成文字
    const int count = 5;
    char data[count];
    for (int x = 0; x < count; x++) {
        int j = '0' + (arc4random_uniform(75));
        if((j >= 58 && j <= 64) || (j >= 91 && j <= 96)){
            --x;
        }else{
            data[x] = (char)j;
        }
    }
    NSString *text = [[NSString alloc] initWithBytes:data
                                              length:count encoding:NSUTF8StringEncoding];
    self.code = text;
    
    NSLog(@"%@", self.code);
    // @} end 生成文字
    
    CGSize cSize = [@"S" sizeWithFont:[UIFont systemFontOfSize:16]];
    int width = self.checkCodeNumberLabel.frame.size.width / text.length - cSize.width;
    int height = self.checkCodeNumberLabel.frame.size.height - cSize.height;
    CGPoint point;
    float pX, pY;
    for (int i = 0, count = text.length; i < count; i++) {
        pX = arc4random() % width + self.checkCodeNumberLabel.frame.size.width / text.length * i - 1;
        pY = arc4random() % height ;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        UILabel *tempLabel = [[UILabel alloc]
                              initWithFrame:CGRectMake(pX, pY,
                                                       self.checkCodeNumberLabel.frame.size.width / 4,
                                                       self.checkCodeNumberLabel.frame.size.height-5)];
        tempLabel.backgroundColor = [UIColor clearColor];
        
        // 字体颜色
        float red = arc4random() % 100 / 100.0;
        float green = arc4random() % 100 / 100.0;
        float blue = arc4random() % 100 / 100.0;
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        tempLabel.textColor = color;
        tempLabel.text = textC;
        [self.checkCodeNumberLabel addSubview:tempLabel];
    }
    
    // 干扰线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    for(int i = 0; i < count; i++) {
        red = arc4random() % 100 / 100.0;
        green = arc4random() % 100 / 100.0;
        blue = arc4random() % 100 / 100.0;
        color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        pX = arc4random() % (int)self.checkCodeNumberLabel.frame.size.width;
        pY = arc4random() % (int)self.checkCodeNumberLabel.frame.size.height - 8;
        CGContextMoveToPoint(context, pX, pY);
        pX = arc4random() % (int)self.checkCodeNumberLabel.frame.size.width;
        pY = arc4random() % (int)self.checkCodeNumberLabel.frame.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        CGContextStrokePath(context);
    }
    return;
}

@end
