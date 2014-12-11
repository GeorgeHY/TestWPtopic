//
//  MyActivity.m
//  if_wapeng
//
//  Created by 早上好 on 14-10-22.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MyActivity.h"
#import "Cell_SellerAciti2.h"
#import "Item_Common02.h"
#import "UIImageView+MJWebCache.h"
/**我的活动**/
@implementation MyActivity

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
    static NSString * strID = @"ID0";
    Cell_SellerAciti2 * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (nil == cell) {
        cell = [[Cell_SellerAciti2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    //    cell.headerImage.image = [UIImage imageNamed:@"saga.jpg"];
    //    cell.topLabel.text = [NSString stringWithFormat:@"Top%d", (int)indexPath.row];
    Item_Common02 * item = self.dataSource[indexPath.row];
    
    cell.mainLabel.text = item.content;
    cell.userLabel.text = item.petName;
    cell.replayLabel.text = item.replies;
    cell.firlabel.text = item.viewFriendPartInCount;
    [cell.headerImage setImageWithURL:[NSURL URLWithString:item.relativePath] placeholderImage:nil];
    
    if (!(indexPath.row < 3)) {
        cell.topLabel.hidden = YES;
    }else{
        cell.topLabel.text = [NSString stringWithFormat:@"TOP%ld", indexPath.row + 1];
    }
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
