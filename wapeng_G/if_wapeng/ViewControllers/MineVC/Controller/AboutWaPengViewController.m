//
//  AboutWaPengViewController.m
//  if_wapeng
//
//  Created by iwind on 14-11-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "AboutWaPengViewController.h"

@interface AboutWaPengViewController ()

@end

@implementation AboutWaPengViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"关于娃朋";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(clickLeftButton)];
    self.navigationItem.leftBarButtonItem=leftButton;
}
-(void)clickLeftButton{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark 查看服务协议内容
- (IBAction)clickItem:(id)sender {
}
@end
