//
//  ShowWindowLeftVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "ShowWindowLeftVC.h"

@interface ShowWindowLeftVC ()
{
    float nav_Y;
}
@end

@implementation ShowWindowLeftVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"橱窗";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (IOS7) {
        
        nav_Y = 64;
        
    }else{
        
        nav_Y = 0;
    }
    
    NSArray * name = @[@"宝宝班", @"北一区"];
    
    [dataArray addObjectsFromArray:name];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, nav_Y, kMainScreenWidth, kMainScreenHeight - 64 - 49) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * strID = @"ID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    
    return cell;
}
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
