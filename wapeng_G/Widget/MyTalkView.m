//
//  MyTalkView.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-16.
//  Copyright (c) 2014年 funeral. All rights reserved.
//我发起的 我参与的

#import "MyTalkView.h"
#import "Cell_MyTalkView.h"
#import "Item_MyTalkView.h"
#import "Confirm.h"
#import "AFN_HttpBase.h"
#import "AppDelegate.h"
#import "UIScrollView+MJRefresh.h"

@implementation MyTalkView
{

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createComponent];
        self.dataSource = [[NSMutableArray alloc]  init];
    }
    return self;
}
-(void)setTableViewData:(NSMutableArray * )dataSource
{
    self.dataSource = dataSource;
    [self.tableView  reloadData];
}
-(void) createComponent{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self setupRefresh];
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]  initWithTarget:self action:@selector(onLongClickListeren:)];
    [self.tableView  addGestureRecognizer:gesture];
    [self  addSubview:self.tableView];
    
    

}

-(void)onLongClickListeren:(UILongPressGestureRecognizer *) gestureRecognizer{
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];//获取响应的长按的indexpath
    

    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        Confirm * confirm = [[Confirm alloc]  initWithFrame:CGRectMake(20, ScreenHegiht/2 - 30, 320 - 40, 100)];
        [confirm showDialog];
        confirm.block = ^(TouchEventType type)
        {
            switch (type) {
                case TouchConfirm:
                    NSLog(@"######");
                    break;
                case TouchEnd:
                    NSLog(@"!!!!!!");
                    break;
                    
                default:
                    break;
            }
        };
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        NSLog(@"UIGestureRecognizerStateChanged");
        
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        NSLog(@"UIGestureRecognizerStateEnded");
        
    }
}
//刷新数据
-(void)reloadTableData{
    [self.tableView reloadData];
}
#pragma mark tableView
//返回是否将某一行的删除添加按钮隐藏  NO为隐藏 yes显示
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleInsert) {
         NSLog(@"-------  %ld",indexPath.row);
    }else if(editingStyle == UITableViewCellEditingStyleDelete){
        NSLog(@"!!!!!!!!!  %ld",indexPath.row);
    }
   
}
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------ %ld", indexPath.row);
    static NSString *identifier=@"Cell_MyTalkView";
    Cell_MyTalkView * cell = [tableView dequeueReusableCellWithIdentifier:
                                   identifier];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_MyTalkView" owner:self options:nil] lastObject];
    }
    
    Item_MyTalkView * item = [self.dataSource objectAtIndex:indexPath.row];
    cell.title.text =  item.title;
    cell.respond.text = item.respond;
    if (nil == item.friends) {
        cell.friends.text = @"-1";
    }else{
        cell.friends.text = @"2";
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


#pragma mark 开始进入刷新状态
- (void)stopRefresh
{
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
}
//上拉刷新
-(void)headerRereshing{
    //viewSupportFlag
    self.headerBlock();
}
//下拉加载
-(void)footerRereshing{
    self.footerBlock();
}
/**设置请求参数**/
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新数据";
    self.tableView.headerReleaseToRefreshText = @"松开刷新数据";
    self.tableView.headerRefreshingText = @"正在刷新数据，请稍等";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在加载数据，请稍等";
}




@end
