//
//  MyTopicStores.m
//  if_wapeng
//
//  Created by 早上好 on 14-10-21.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
//我的话题收藏
#import "MyTopicStores.h"
#import "HotTopicEntity.h"
#import "HotTopicTVCell.h"
#import "DownloadImageManger.h"
#import "UIImageView+MJWebCache.h"

@implementation MyTopicStores


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
//    [self.tableView setupRefresh];
  
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)setLoadData:(NSMutableArray *)dataSource
{
    self.dataSource = dataSource;
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 102;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    HotTopicTVCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[HotTopicTVCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    HotTopicEntity * hotTopic = [self.dataSource objectAtIndex:indexPath.row];


    cell.topLable.text = hotTopic.createTime;
    cell.top.hidden = YES;
    cell.v.hidden = NO;
    cell.replyLable.text = hotTopic.reply;
    cell.personLable.text = hotTopic.person;
    cell.contentLable.text = hotTopic.content;
    cell.nameLable.text = hotTopic.name;
    [cell  setLableTopSize];
    NSString * url = @"http://115.100.250.35:8080/wpa/wb/wpub/imgAction_img.action?A_ID=11/8/8/3/29699304-da21-4038-9931-e419af712fa3_jpg";
    [DownloadImageManger downloadImageUrl:url setImageView:cell.headImageView];
    
    return cell;
}



@end
