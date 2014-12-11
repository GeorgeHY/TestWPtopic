//
//  LeftDetailVC01.m
//  if_wapeng
//
//  Created by 永不死的圣斗士 on 14-6-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "LeftDetailVC01.h"
#import "LeftDetailVC02.h"
@interface LeftDetailVC01 ()

@end

@implementation LeftDetailVC01

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUIView];
    
    UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 220, 44)];
    textLabel.text = [NSString stringWithFormat:@"%d", self.index];
    [self.view addSubview:textLabel];
    
    UIButton * pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushBtn setTitle:@"push" forState:UIControlStateNormal];
    pushBtn.frame = CGRectMake(100, 220, 120, 44);
    pushBtn.backgroundColor = [UIColor redColor];
    [pushBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
}
-(void)push
{
    LeftDetailVC02 * leftDetailVC02 = [[LeftDetailVC02 alloc]init];
    [self.navigationController pushViewController:leftDetailVC02 animated:YES];
}
-(void)initUIView
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:dPic_Public_topmenu forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor redColor];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);

    [leftBtn addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:dPic_Public_toprelease forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);

    [rightBtn addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}
//-(void)btnClick:(UIButton *)button
//{
//    NSLog(@"btn was clicked!");
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
