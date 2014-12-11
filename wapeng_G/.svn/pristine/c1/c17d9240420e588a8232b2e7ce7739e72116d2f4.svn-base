//
//  MyMail.m
//  if_wapeng
//
//  Created by 早上好 on 14-10-22.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MyMail.h"
#import "Cell_SellerAciti2.h"
#import "Item_Common02.h"
#import "UIImageView+MJWebCache.h"
#import "Cell_MyMail.h"
#import "Item_MyMailEntity.h"
#import "Cell_Mail.h"
/**我的信件**/

@implementation MyMail

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createComponet];
    }
    return self;
}


-(void)createComponet{
    self.tableView = [[RefreshTableView alloc]  initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self  addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


-(void)setLoadData:(NSMutableArray *)dataSource
{
    self.dataSource = dataSource;
    [self.tableView reloadData];
    [self stopRefreshingTableview];
}

-(void)stopRefreshingTableview{
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"cell";
    Cell_Mail *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[Cell_Mail alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    Item_MyMailEntity * item = self.dataSource[indexPath.row];
    NSLog(@"0--------------- %ld",indexPath.row);
    cell.headerIV.image = [UIImage imageNamed:@"1.png"];
    
//    cell.name.text = item.name;
    cell.mailContent.text = item.content;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}





@end
