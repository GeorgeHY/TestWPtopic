//
//  FinderPasswordVC02.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-28.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "FinderPasswordVC02.h"
#import "UIViewController+General.h"
#import "AFN_HttpBase.h"
#import "UIColor+AddColor.h"
@interface FinderPasswordVC02 ()
{
    AFN_HttpBase * http;
    NSUserDefaults * ud;
}
@property (weak, nonatomic) IBOutlet UIButton *finishedBtn;

@property (weak, nonatomic) IBOutlet UITextField *nwePassword;

@property (weak, nonatomic) IBOutlet UITextField *comfirmNewPwd;
@end

@implementation FinderPasswordVC02

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"重置您的密码";
        
        http = [[AFN_HttpBase alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ud=[NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
    
    self.finishedBtn.backgroundColor = [UIColor redColor];
    
    [self initLeftItem];
  
    
}
-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)finishedBtnClick:(id)sender {
    
    if (_nwePassword.text.length == 0 || _comfirmNewPwd.text.length == 0) {
        [SVProgressHUD showSimpleText:@"请输入新密码"];
        return;
    }
    if ([_nwePassword.text isEqualToString:_comfirmNewPwd.text] ) {
        
        self.password = _nwePassword.text;
        
        NSDictionary * dict = [http asmmbleDic:@"RegInfoID",self.RegInfoID, @"RegInfoCode", self.RegInfoCode,@"account.userName", self.userName, @"account.password", self.password,  nil];
        
        NSLog(@"dict:%@", dict);
        
        [http thirdRequestWithUrl:dUrl_ACC_1_1_4 succeed:^(NSObject *obj, BOOL isFinished) {
            NSLog(@"success!");
            [SVProgressHUD showSimpleText:@"修改密码成功"];
            [ud setObject:self.password forKey:@"pwd"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } failed:^(NSObject *obj, BOOL isFinished) {
            NSLog(@"modify   pwd    failed!");
        } andKeyValuePairs:@"account.regInfo.id", self.RegInfoID, @"account.regInfo.code", self.RegInfoCode, @"account.userName", self.userName, @"account.password", self.password,nil];
        
        
    }else{
        [SVProgressHUD showSimpleText:@"两次输入密码不一致"];
        return;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_nwePassword resignFirstResponder];
    [_comfirmNewPwd resignFirstResponder];
}


@end
