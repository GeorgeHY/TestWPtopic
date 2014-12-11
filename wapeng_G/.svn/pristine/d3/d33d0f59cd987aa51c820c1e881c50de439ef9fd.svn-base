//
//  RegisterVC5.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-16.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RegisterVC5.h"
#import "RegisterVC06.h"
#import "RegisterVC07.h"
#import "UIColor+AddColor.h"
#import "RegisterDataManager.h"
#import "UIViewController+General.h"
@interface RegisterVC5 (){
    RegisterDataManager * _dm;
}
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UIButton *yes;

@property (weak, nonatomic) IBOutlet UIButton *no;
@end

@implementation RegisterVC5

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"宝宝上幼儿园了吗";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#d5d6db"];

    _dm=[RegisterDataManager shareInstance];
    
    
    [self initLeftItem];
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * babyn = [ud objectForKey:BABYNICKNAME];
    if (babyn) {
        self.nickname.text = babyn;
    }else{
        self.nickname.text = @"宝宝";
    }
}

-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)confirmBtnOnClick:(id)sender{
    RegisterVC07 * registerVC07 = [[RegisterVC07 alloc]init];
    [self.navigationController pushViewController:registerVC07 animated:YES];
}
-(IBAction)denyBtnOnClick:(id)sender{
    RegisterVC06 * registerVC06 = [[RegisterVC06 alloc]  initWithNibName:@"RegisterVC06" bundle:nil];
    //如果没上幼儿园，就把这几个数据置空
    _dm.customKindergaten=@"";
    _dm.kindgardenID=@"";
    _dm.kindergaten=@"";
    _dm.classID=@"";
    [self.navigationController pushViewController:registerVC06 animated:YES];
}
@end

