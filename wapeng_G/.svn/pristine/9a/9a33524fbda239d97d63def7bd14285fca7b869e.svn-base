//
//  MessageVC.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MessageVC.h"
#import "AFN_HttpBase.h"
#import "UIViewController+MMDrawerController.h"
#import "IQSegmentedNextPrevious.h"
#import "RegisterMapViewController.h"
#import "AppDelegate.h"
#import "IQKeyBoardManager.h"
#import "IQSegmentedNextPrevious.h"
@interface MessageVC ()<UITextFieldDelegate>
{
    UIButton    *_selectBtn;
    UIButton    *_rightBtn;
    UIView      *_tempView;
    CGRect      _oldFrame;
    NSString    *_sex;
    AFN_HttpBase * http;
    int pageIndex;
}
@property (weak, nonatomic) IBOutlet UITextField *babyNick;
@property (weak, nonatomic) IBOutlet UIButton *man;

@property (weak, nonatomic) IBOutlet UIButton *women;

@property (weak, nonatomic) IBOutlet UITextField *birthday;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *hospital;
@property (weak, nonatomic) IBOutlet UITextField *kindergarten;
@property (weak, nonatomic) IBOutlet UITextField *babyClass;

@end

@implementation MessageVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"宝宝信息";
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
    http=[[AFN_HttpBase alloc]init];
    self.item = [[Item_BabyInfo alloc]init];
    
    self.view.backgroundColor = kRGB(237,237,237);
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 25)];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(savaInfo) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.hidden = YES;
    UIColor *titleColor = kRGB(38, 138, 247);
    [rightBtn setTitleColor:titleColor forState:UIControlStateNormal];
    _rightBtn = rightBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    _sex = [NSString string];
    _sex = @"男";
    self.man.selected = YES;
    _selectBtn = self.man;
    
//
    self.birthday.text = @"2月11日";
//
//    
    self.city.text = @"成都";
//
    self.hospital.text =@"协和";
//
//    
    self.kindergarten.text = @"无忧小学";
//
//    
    self.babyClass.text = @"五年二班";

    UIImage *backImage = [UIImage imageNamed:@"public_back"];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"public_back_hightLight"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = left;
    
    [self headHttpPage];

}
-(void)headHttpPage
{
    self.operation=@"1";
    pageIndex=1;
    NSString * page=[NSString stringWithFormat:@"%d",pageIndex];
    [self httpRequestData:page];
}
#pragma mark 请求数据
-(void)httpRequestData:(NSString *)page
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    
    __weak MessageVC * weakSelf = self;
    [http thirdRequestWithUrl:dUrl_OSM_1_3_1 succeed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSuccessWithStatus:@"请求成功"];
        
        NSDictionary * root = (NSDictionary *)obj;
        
        if (isNotNull([root objectForKey:@"value"])) {
            
            if (isNotNull([[root objectForKey:@"value"] objectForKey:@"list"] )) {
                 NSArray * list =[[root objectForKey:@"value"] objectForKey:@"list"];
                if (list.count != 0) {
                    NSDictionary * value0 = list[0];
                    
                    weakSelf.item.birthday = [value0 objectForKey:@"birthday"];
                    weakSelf.item.gender = [[value0 objectForKey:@"gender"] integerValue];
                    weakSelf.item.hospitalName = [NSString stringWithFormat:@"%@", [[value0 objectForKey:@"hospital"] objectForKey:@"name"]];
                    weakSelf.item.babyName = [NSString stringWithFormat:@"%@", [value0 objectForKey:@"name"]];
                    weakSelf.item.className = [[value0 objectForKey:@"organizationBranch"] objectForKey:@"name"];
                    weakSelf.item.zoneName = [[value0 objectForKey:@"zoneArea"] objectForKey:@"name"];
                    weakSelf.item.petName = [[value0 objectForKey:@"childkindergarten"] objectForKey:@"petName"];
                    
                    switch (weakSelf.item.gender) {
                        case 1:
                        {
                            weakSelf.man.selected = YES;
                        }
                            break;
                        case 2:
                        {
                            weakSelf.women.selected = YES;
                        }
                            break;
                        default:
                            break;
                    }
                    weakSelf.babyNick.text = weakSelf.item.babyName;
                    weakSelf.birthday.text = weakSelf.item.birthday;
                    weakSelf.city.text = weakSelf.item.zoneName;
                    weakSelf.hospital.text = weakSelf.item.hospitalName;
                    weakSelf.kindergarten.text = weakSelf.item.petName;
                    
                    NSLog(@"%@", weakSelf.item.petName);
                    weakSelf.babyClass.text = weakSelf.item.className;
                }else{
                    
                    [SVProgressHUD showSuccessWithStatus:dTips_noMoreData];
                }
               
               
            }
             [SVProgressHUD showSuccessWithStatus:dTips_noMoreData];
        }else{
             [SVProgressHUD showSuccessWithStatus:dTips_noMoreData];
        }
    
    } failed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSimpleText:@"请求失败"];
    } andKeyValuePairs:@"D_ID",ddid,@"childInfoQuery.pageNum",page,nil];
}

//General
-(void)navItemClick:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter]postNotificationName:dNoti_isHideKeyBoard object:@"1"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  -保存信息
-(void)savaInfo{
    _rightBtn.hidden = YES;
}

- (IBAction)selectSex:(UIButton *)sender {
    _rightBtn.hidden = NO;
    _selectBtn.selected = NO;
    sender.selected = YES;
    _selectBtn = sender;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _rightBtn.hidden = NO;
    _tempView = textField.superview;
    _oldFrame = _tempView.frame;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.babyNick resignFirstResponder];
    [self.birthday resignFirstResponder];
    [self.city resignFirstResponder];
    [self.hospital resignFirstResponder];
    [self.kindergarten resignFirstResponder];
    [self.babyClass resignFirstResponder];
}


- (IBAction)endEdit:(id)sender {
}



@end
