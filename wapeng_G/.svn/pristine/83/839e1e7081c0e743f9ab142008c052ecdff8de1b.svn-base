//
//  TalkColumnVC.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-10.
//  Copyright (c) 2014年 funeral. All rights reserved.
//话题专栏

#import "TalkColumnVC.h"
#import "TalkColumnCell.h"
#import "Item_TalkColumn.h"
#import "HMSegmentedControl.h"
#import "Item_TalkColumnTableHeader.h"
#import "UIViewController+General.h"
#import "UIView+WhenTappedBlocks.h"
@interface TalkColumnVC ()
//header
@property(nonatomic , strong) UIImageView * header;
@property(nonatomic , strong) UILabel * nameL;
@property(nonatomic , strong) UILabel * content;
@property(nonatomic , strong) UITableView * tablView;
@property(nonatomic , strong) NSMutableArray * dataSource1;
@property(nonatomic , strong) NSMutableArray * dataSource2;

@property(nonatomic , strong) NSMutableArray * mainDataSource;
@property(nonatomic , strong) Item_TalkColumnTableHeader * tableHeader;

@end

@implementation TalkColumnVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"话题专版";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self  initLeftItem];
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    self.dataSource1 = [[NSMutableArray alloc] init];
    self.dataSource2 = [[NSMutableArray alloc] init];
    self.mainDataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        Item_TalkColumn * item = [[Item_TalkColumn alloc]  init];
        item.b = NO;
        item.headerPath = @"baby_m_r.png";
        item.headerName = @"中华老字号";
        item.reply = @"12";
        item.friends = @"1223";
        item.content = @"按时打算打算打算打算打算打算打算打算打算打算的";
        [self.dataSource1  addObject:item];
    }
    for (int i = 0; i < 10; i++) {
        Item_TalkColumn * item = [[Item_TalkColumn alloc]  init];
        item.b = NO;
        item.headerPath = @"baby_m_r.png";
        item.headerName = @"中华老字号";
        item.reply = @"12";
        item.friends = @"1223";
        item.content = @"按时打算打算打算打算打算打算打算打算打算打算的";
        [self.dataSource2  addObject:item];
    }
    [self.mainDataSource  addObject:self.dataSource1];
    [self.mainDataSource  addObject:self.dataSource2];
    self.tableHeader = [[Item_TalkColumnTableHeader alloc]  init];
    self.tableHeader.headerPath = @"baby_m_r.png";
    self.tableHeader.nameL = @"啊实打实的";
    self.tableHeader.content = @"啊实打实大师大师的啊实打实大师的按时打算打打S大蛇兜";
    self.tablView = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49 - 69)];
    [self.view  addSubview:self.tablView];
    [self  createTableviewHeader];
    self.tablView.delegate = self;
    self.tablView.dataSource = self;
    [self createComponent];
    
    
}
//系统的Item方法
-(void)navItemClick:(UIButton *)button
{
//    [self.navigationController popToRootViewControllerAnimated:YES];
    if (IOS7) {
        self.navigationController.navigationBar.translucent =YES;
//        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createTableviewHeader{
    UIView *tableViewHeader = [[UIView alloc]  initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,100)];
    self.header = [[UIImageView alloc]  initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.header.image = [UIImage imageNamed:self.tableHeader.headerPath];
    [tableViewHeader  addSubview:self.header];
    
    self.nameL = [[UILabel alloc]  initWithFrame:CGRectMake(self.header.frame.origin.x + self.header.frame.size.width + 10, 10, 100, 50)];
    self.nameL.lineBreakMode = NSLineBreakByWordWrapping;
    self.nameL.numberOfLines = 0;
    self.nameL.text = self.tableHeader.nameL;
    [tableViewHeader addSubview:self.nameL];
    self.content = [[UILabel alloc ]  initWithFrame:CGRectMake(10, self.header.frame.origin.y + self.header.frame.size.height + 10, tableViewHeader.frame.size.width - 20 , 50)];
    self.content.text = self.tableHeader.content;
    [tableViewHeader addSubview:self.content];
    self.tablView.tableHeaderView = tableViewHeader;

}
-(void) createComponent{
    

}


#pragma mark  tableview
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 60;
    }else{
    return 40;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
    return self.dataSource1.count;
    }else{
    return self.dataSource2.count;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mainDataSource.count;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView * v = [[UIView alloc]  initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 40)];
        UITextField * tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 40)];
        UIImageView * magnify = [[UIImageView alloc]  initWithFrame:CGRectMake(10, 10, 20, 20)];
        UIImage * image = [UIImage imageNamed:@"public_ magnify.png"];
        magnify.image = image;
        tf.placeholder = @"版内搜索";
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.clearButtonMode = UITextFieldViewModeAlways;
        tf.adjustsFontSizeToFitWidth = YES;
        tf.clearsOnBeginEditing = YES;
        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        tf.keyboardType = UIKeyboardTypeDefault;
        tf.leftView = magnify;
        tf.leftViewMode = UITextFieldViewModeAlways;
       
        [v  addSubview:tf];
        return v;
    }else{
        NSArray * array = @[@"按热度",@"按时间",@"按关系"];
        HMSegmentedControl * segmented = [[HMSegmentedControl alloc]  initWithSectionTitles:array];
        segmented.selectionIndicatorColor = [UIColor redColor];
        segmented.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        [segmented setSelectedTextColor:[UIColor redColor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ]];
        segmented.selectionStyle = HMSegmentedControlSelectionStyleBox;
        [segmented setFont:[UIFont systemFontOfSize:14]];
        [segmented setIndexChangeBlock:^(NSInteger index) {
            switch (index) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                 
                }
                    break;
                default:
                    break;
            }
        }];
        return segmented;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"talkCell";
    TalkColumnCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[TalkColumnCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    Item_TalkColumn * item;
    if (indexPath.section == 0) {
            item = [self.dataSource1  objectAtIndex:indexPath.row];
    }else{
            item = [self.dataSource2  objectAtIndex:indexPath.row];
    }
    cell.top.hidden = NO;
    if (item.b) {
        cell.top.hidden = YES;
    }else{
        cell.top.hidden = NO;
    }
    [cell.header  setImage:[UIImage imageNamed:item.headerPath]];
    cell.headerName.text = item.headerName;
    cell.content.text = item.content;
    NSString *replyS = [NSString stringWithFormat:@"%@%@" , @"回复 " , item.reply];
    NSString *friends = [NSString stringWithFormat:@"%@%@" , @"熟人 " , item.friends];
    cell.reply.text = replyS;
    cell.friends.text = friends;
    

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)creatrComponent{
    
}


@end
