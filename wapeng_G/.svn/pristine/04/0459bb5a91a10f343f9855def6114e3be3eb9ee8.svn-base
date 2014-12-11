//
//  SetVC.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-22.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "SetVC.h"
#import "UIView+WhenTappedBlocks.h"
#import "AppDelegate.h"
#import "AboutWaPengViewController.h"
#import "SetPasswordViewController.h"
#import "AFN_HttpBase.h"
#import "IQKeyBoardManager.h"
#import "IQSegmentedNextPrevious.h"
#import "ResertPasswordVC.h"
@interface SetVC ()<UIAlertViewDelegate>
{
    NSUserDefaults * ud;
    AFN_HttpBase * http;
}
@property (weak, nonatomic) IBOutlet UIView *passWordView;

@property (weak, nonatomic) IBOutlet UIView *about;
- (IBAction)clickAbout:(id)sender;

- (IBAction)setPassword:(id)sender;
- (IBAction)quit:(id)sender;

@end

@implementation SetVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"设置";
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated;
{
    
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = YES;
    //键盘自动布局
    [IQKeyBoardManager installKeyboardManager];
    [IQKeyBoardManager enableKeyboardManger];
}

-(void)viewWillDisappear:(BOOL)animated{
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = NO;
    //取消键盘自动布局
    [IQKeyBoardManager disableKeyboardManager];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ud=[NSUserDefaults standardUserDefaults];
    http=[[AFN_HttpBase alloc]init];
    self.view.backgroundColor = kRGB(237, 237, 237);
    [self createComponent];
    
}

-(void)createComponent{
    
    self.pushSwitch.arrange = CustomSwitchArrangeOFFLeftONRight;
    self.pushSwitch.onImage = [UIImage imageNamed:@"set_on"];
    self.pushSwitch.offImage = [UIImage imageNamed:@"set_off"];
    self.pushSwitch.status = CustomSwitchStatusOn;
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:dPic_Public_toprelease forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    //    [rightBtn addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIImage *backImage = [UIImage imageNamed:@"public_back"];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"public_back_hightLight"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = left;
}

-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - customSwitch delegate
-(void)customSwitchSetStatus:(CustomSwitchStatus)status
{
    switch (status) {
        case CustomSwitchStatusOn:
            NSLog(@"on");
            //todo
            break;
        case CustomSwitchStatusOff:
            //todo
            
            NSLog(@"off");
            break;
        default:
            break;
    }
    
    NSNumber * num = [NSNumber numberWithInt:status];
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    //重新设置是否接受推送消息
    [d setObject:num forKey:UD_remoteNoti];
}

- (IBAction)pushSwitch:(CustomSwitch *)sender {
}
#pragma mark 关于娃朋页面
- (IBAction)clickAbout:(id)sender {
    AboutWaPengViewController * aVC=[[AboutWaPengViewController alloc]init];
    [self.navigationController pushViewController:aVC animated:YES];
}

- (IBAction)setPassword:(id)sender {
    ResertPasswordVC * setVC=[[ResertPasswordVC alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}
#pragma mark 退出登录
- (IBAction)quit:(id)sender {
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * uuid = [d objectForKey:UD_uuid];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    __weak AppDelegate * app = (AppDelegate *)[AppDelegate shareInstace];
    
    [http thirdRequestWithUrl:dUrl_ACC_1_1_5 succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:dTips_quitSuccess];
        
        [app showViewController:showVCTypeLogin];
        
    }
                       failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"注销失败"];
        
    } andKeyValuePairs:@"D_ID", ddid, @"accountQuery.deviceCode", uuid,nil];
    
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
    NSLog(@"登出");
    
    [app  showViewController:showVCTypeLogin];
}


@end
