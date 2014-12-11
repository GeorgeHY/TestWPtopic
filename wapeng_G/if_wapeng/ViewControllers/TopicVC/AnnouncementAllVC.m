//
//  AnnouncementAllVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "AnnouncementAllVC.h"
#import "HotTopicEntity.h"
#import "HotTopicTVCell.h"
#import "WaterfallView.h"
#import "Item_AnnAllWaterfall.h"
#import "AnnAllWaterfalllCell.h"
@interface AnnouncementAllVC (){
    
    
}
@property(nonatomic , retain) UIButton * leftBtn;
@property(nonatomic , retain) UIButton * rightBtn;
@property(nonatomic , strong) UITextField * searchF;
@property(nonatomic , retain) UIScrollView * scroll;
@property(nonatomic , retain) UITableView * tableView;
@property(nonatomic , retain) NSMutableArray * dateArray;
@property(nonatomic , retain) NSMutableArray * dateFoot;
@property(nonatomic , retain) WaterfallView * waterfallView;
@end

@implementation AnnouncementAllVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dateArray = [[NSMutableArray alloc]  init];
    self.dateFoot = [[NSMutableArray alloc]  init];
    for (int i = 0; i<=10; i++) {
        Item_AnnAllWaterfall * annAll = [[Item_AnnAllWaterfall  alloc]  init];
        NSString * s = [NSString stringWithFormat:@"%@%d",@"名字名字",i];
        annAll.imageName = s;
        if (i%2 == 0) {
            annAll.imageParh = @"baby_w_r.png";
        }else{
            annAll.imageParh = @"1.png";
        }
        
        annAll.count = @"11";
        [self.dateFoot addObject:annAll];
    }
    for (int i = 0; i <= 5; i++) {
        HotTopicEntity * hotTop = [[HotTopicEntity alloc] init];
        NSString *s = [[NSString alloc] initWithFormat:@"%d",i];
        hotTop.top = s;
        hotTop.reply = s;
        hotTop.person = s;
        hotTop.content = @"水电费水电费水电费收水电费·水电费水电费水电费收水电费·水电费水电费水电费收水电费·水电费水电费水电费收水电费·水电费水电费水电费收水电费·水电费水电费水电费收水电费·水电费水电费水电费收水电费·";
        hotTop.name = @"大射手";
        hotTop.head = @"userheard.png";
        [self.dateArray addObject:hotTop];
    }
    
    [self  createComponent];
    
}
//初始化控件
-(void)createComponent{
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blueColor]];
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    self.leftBtn.backgroundColor = [UIColor redColor];
    self.leftBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    //    [self.leftBtn addTarget:self action:@selector(onTouchlistening:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setTitle:@"左面" forState:UIControlStateNormal];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem = left;
    
    self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    
    [self.rightBtn setTitle:@"笔" forState:UIControlStateNormal];
    self.rightBtn.backgroundColor = [UIColor redColor];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    self.searchF = [[UITextField alloc]  initWithFrame:CGRectMake(10, 5, self.view.frame.size.width - 20, 35)];
    self.searchF.placeholder = @"没找到？可以在这里搜索";
    self.searchF.borderStyle = UITextBorderStyleRoundedRect;
    self.searchF.clearButtonMode = UITextFieldViewModeAlways;
    self.searchF.adjustsFontSizeToFitWidth = YES;
    self.searchF.clearsOnBeginEditing = YES;
    self.searchF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.searchF.keyboardType = UIKeyboardTypeDefault;
    UIImageView * magnify = [[UIImageView alloc]  initWithFrame:CGRectMake(10, 10, 20, 20)];
    UIImage * image = [UIImage imageNamed:@"public_ magnify.png"];
    magnify.image = image;
    self.searchF.leftView = magnify;
    self.searchF.leftViewMode = UITextFieldViewModeAlways;
    [self.view  addSubview:self.searchF];
    
    [self.searchF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.scroll = [[UIScrollView alloc]  initWithFrame:CGRectMake(0, 0 + 44, self.view.frame.size.height, 20)];
    self.scroll.contentSize = CGSizeMake(630, 30);
    self.scroll.pagingEnabled = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.backgroundColor = [UIColor greenColor];
    float width = self.view.frame.size.width;
    NSArray * array = @[@"手足口",@"入托",@"舞蹈",@"预防针"];
    for (int i = 0; i<4; i++) {
        UIView * v = [[UIView alloc]  initWithFrame:CGRectMake(i * width/4, 0, width / 4 , 20)];
        UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        iv.image = [UIImage imageNamed:@"1.png"];
        UILabel * lable1 = [[UILabel alloc]  initWithFrame:
                            CGRectMake(10, 0, width/4-20 , 20)];
        lable1.text  = [array objectAtIndex:i];
        lable1.textAlignment = NSTextAlignmentCenter;
        lable1.textColor = [UIColor blackColor];
        lable1.font = [UIFont boldSystemFontOfSize:10];
        [v addSubview:lable1];
        [v addSubview:iv];
        [self.scroll addSubview:v];
    }
    
    [self.view  addSubview:self.scroll];
    
    UIImageView * im = [[UIImageView alloc]  initWithFrame:CGRectMake(10,  44 + 48, 20, 20)];
    im.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:im];
    UILabel * newlable = [[UILabel alloc]  initWithFrame:CGRectMake(40, 44 + 48, 100, 20)];
    newlable.text = @"身边热帖";
    
    
    [self.view  addSubview:newlable];
    self.tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, 44 + 40 + 40, self.view.frame.size.width, self.view.frame.size.height - (64 + 44 + 40 + 40 + 49))];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    self.waterfallView = [[WaterfallView alloc]  initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 500)];
    [self.waterfallView  createComponent:self.dateFoot];
    self.tableView.tableFooterView = self.waterfallView;
    [self.view  addSubview:self.tableView];
    
}




//监听textfiled的变化
- (void) textFieldDidChange:(id) sender {
    UITextField *_field = (UITextField *)sender;
    NSLog(@"%@",[_field text]);
}

#pragma mark tableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    HotTopicTVCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[HotTopicTVCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    HotTopicEntity * hotTopic = [self.dateArray objectAtIndex:indexPath.row];
    cell.topLable.text = hotTopic.top;
    cell.replyLable.text = hotTopic.reply;
    cell.personLable.text = hotTopic.person;
    cell.contentLable.text = hotTopic.content;
    cell.nameLable.text = hotTopic.name;
    
    return cell;
}




//
//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView * vMain;
//
//    if (tableView == self.tableViewRight) {
//        vMain = [[UIView alloc]  initWithFrame:CGRectMake(self.view.frame.size.width, 0, 0, 0)];
//    }else{
//        vMain = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120 * self.dateHeader.count)];
//        for (int i = 0; i<self.dateHeader.count; i++) {
//            NewTableView * nTable = [[NewTableView alloc]  initWithFrame:CGRectMake(0, 0 + (120*i), self.view.frame.size.width, 300)];
//            HotTopicEntity * entity = [self.dateHeader  objectAtIndex:i];
//            nTable.topLable.text = entity.top;
//            nTable.replyLable.text = entity.reply;
//            nTable.personLable.text = entity.person;
//            nTable.contentLable.text = entity.content;
//            nTable.headImageView.image =[UIImage imageNamed:                entity.head];
//            nTable.nameLable.text = entity.name;
//            //        [vSon  addSubview:nTable];
//            [vMain addSubview:nTable];
//        }
//
//    }
//
//
//    return vMain;
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
