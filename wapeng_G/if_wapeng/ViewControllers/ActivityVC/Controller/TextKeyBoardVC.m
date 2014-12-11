//
//  TextKeyBoardVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-10-27.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "TextKeyBoardVC.h"

@interface TextKeyBoardVC ()
{
    UITextView * _tView;
}
@end

@implementation TextKeyBoardVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor= [UIColor whiteColor];
    
    _tView = [[UITextView alloc]initWithFrame:CGRectMake(0, 150, kMainScreenWidth, 200)];
    _tView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tView];
    
    UIButton * generate = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, 100, 40)];
    generate.backgroundColor = [UIColor greenColor];
    [generate setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:generate];
    [generate addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendText:type:index:)]) {
        
        [self.delegate sendText:_tView.text type:self.pageType index:self.index];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
