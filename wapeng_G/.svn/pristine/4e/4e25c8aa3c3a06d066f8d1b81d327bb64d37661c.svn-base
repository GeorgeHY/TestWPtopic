//
//  AllMyWindowVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-15.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "AllMyWindowVC.h"
#import "Cell_AllMyShowWindow.h"
#import "InterfaceLibrary.h"
#import "UIView+WhenTappedBlocks.h"
#import "AFN_HttpBase.h"
@interface AllMyWindowVC ()
{
    
}
@end

@implementation AllMyWindowVC

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
    
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.title = @"橱窗全部";
    
    _dataArray = [[InterfaceLibrary shareInterfaceLibrary] interfaceOne];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    Cell_AllMyShowWindow * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (nil == cell) {
        
        cell = [[Cell_AllMyShowWindow alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    [cell.remarkLbl whenTapped:^{
        
        static BOOL isOpen;
        //加载请求数据
    }];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 420;
}
@end
