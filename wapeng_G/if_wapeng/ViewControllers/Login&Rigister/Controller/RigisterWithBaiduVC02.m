//
//  RigisterWithBaiduVC02.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-28.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RigisterWithBaiduVC02.h"
//#import "RegisterWithBaiduVC03.h"
#import "CheckDataTool.h"
#import "UIViewController+General.h"
#import "UIColor+AddColor.h"
#import "RegisterDataManager.h"
@interface RigisterWithBaiduVC02 (){
    NSUserDefaults *saveDefaults;
    RegisterDataManager * _dataManager;
}

@property (weak, nonatomic) IBOutlet UIButton *man;

@property (weak, nonatomic) IBOutlet UIButton *wom;

@property (weak, nonatomic) IBOutlet UITextField *nickname;

@end

@implementation RigisterWithBaiduVC02

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"您的昵称和常住地";
    }
    return self;
}

//选择常住地
- (IBAction)nextBtnClick:(id)sender {
    if (![CheckDataTool checkInfo:self.nickname msgContent:@"请填写昵称"]) {
        return;
    }
   
    [saveDefaults setObject:self.nickname.text forKey:NICKNAME];
    NSLog(@"%@", self.nickname.text);
    _dataManager.parentNickName = self.nickname.text;
    if (self.man.selected) {
        [saveDefaults setObject:@"0" forKey:GENDER];
        _dataManager.parentGender = @"0";
        
    }else{
        [saveDefaults setObject:@"1" forKey:GENDER];
        _dataManager.parentGender = @"1";
    }
//    RegisterWithBaiduVC03 * vc03 = [[RegisterWithBaiduVC03 alloc]initWithNibName:@"RegisterWithBaiduVC03" bundle:nil];
//    
//    [self.navigationController pushViewController:vc03 animated:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
      self.view.backgroundColor = [UIColor colorWithHexString:@"#d5d6db"];
    
    _dataManager = [RegisterDataManager shareInstance];
    
    [self initLeftItem];
    [self createComponent];
    
    saveDefaults = [NSUserDefaults standardUserDefaults];
    
}

-(void) createComponent{

    [self.man setBackgroundImage:[UIImage imageNamed:@"register2_mw.png"] forState:UIControlStateNormal];
    [self.man  addTarget:self action:@selector(onClickMan:) forControlEvents:UIControlEventTouchUpInside];
    [self.man setBackgroundImage:[UIImage imageNamed:@"register2_man1.png"] forState:UIControlStateSelected];
    
    
    [self.wom setBackgroundImage:[UIImage imageNamed:@"register2_mw.png"] forState:UIControlStateNormal];
    [self.wom  addTarget:self action:@selector(onClickWom:) forControlEvents:UIControlEventTouchUpInside];
    [self.wom setBackgroundImage:[UIImage imageNamed:@"register2_wom1.png"] forState:UIControlStateSelected];
    self.man.selected = YES;
    self.wom.selected = NO;
    
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

-(void)onClickMan:(UIButton * ) b {
    b.selected = YES;
    self.wom.selected = NO;
}
-(void)onClickWom:(UIButton * ) b {
    b.selected = YES;
    self.man.selected = NO;
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //收键盘
    [self.nickname resignFirstResponder];
}
//系统的Item方法


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
