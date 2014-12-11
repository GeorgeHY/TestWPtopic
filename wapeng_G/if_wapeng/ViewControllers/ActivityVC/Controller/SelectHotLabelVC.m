//
//  SelectHotLabelVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-10-30.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define TAG_TOPICREQ   1 // 话题
#define TAG_ACTREQ     2 //活动
#define DTAG_TEXTFIELD 100
#define MAX_TAG 1000
#import "SelectHotLabelVC.h"
#import "Cell_ACTLabel.h"
#import "Item_ACT_Hot.h"
#import "UIButton+FlexSpace.h"
#import "UIViewController+MMDrawerController.h"
#import "AppDelegate.h"
#import "UIViewController+General.h"
#import "StringTool.h"
#import "TimeTool.h"
#import "HotWordVIew.h"
@interface SelectHotLabelVC ()
{
    AFN_HttpBase * http;
}
@end

@implementation SelectHotLabelVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"---------initWithNibName begin");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dataArray = [[NSMutableArray alloc]init];
        _imageIDArray = [[NSMutableArray alloc]init];
        http = [[AFN_HttpBase alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"---------viewWillAppear begin");
    AppDelegate * app  = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"---------viewWillDisappear begin");
    AppDelegate * app  = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = NO;
}

-(void)navItemClick:(UIButton *)button
{
    NSLog(@"---------navItemClick begin");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightItemClick
{
    NSLog(@"---------rightItemClick begin");
    switch (self.type) {
        case TAG_TOPICREQ:
        {
            [self publicTop];
        }
            break;
        case TAG_ACTREQ:
        {
            [self publishACT];
        }
            break;
        default:
            break;
    }
}
//**发布话题**//
-(void)publicTop
{
    NSLog(@"---------publicTop begin");
    _selectArray = [[NSMutableArray alloc]init];
    
    for (Item_ACT_Hot * item in _dataArray) {
        
        if (item.isSelected == YES) {
            
            [_selectArray addObject:item];
        }
    }
    
    if (_selectArray.count == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择标签"];
        return;
    }
    NSMutableString * searchText = [[NSMutableString alloc]init];
    for (Item_ACT_Hot * item in _selectArray) {
        
        //        [searchText stringByAppendingFormat:@"%@,", item.name];
        [searchText appendFormat:@"%@,", item.name];
    }
    //自定义标签
    UITextField * tf = (UITextField *)[self.view viewWithTag:DTAG_TEXTFIELD];
    
    NSString * DIYString = [StringTool replaceCommcomma:tf.text];
    
    [searchText appendString:DIYString];
    
    NSLog(@"%@", searchText);
    
    NSMutableArray * keys = [[NSMutableArray alloc]init];
    
    NSMutableArray * values = [[NSMutableArray alloc]init];
    
    int i = 0;
    
    for (Item_ACT_Hot * item in _selectArray) {
        
        NSString * mIDStr = [NSString stringWithFormat:@" topic.topTopicLabelList[%d].id", i];
        
        [keys addObject:mIDStr];
        
        [values addObject:item.mid];
        
        i++;
    }
    //组装标签
    NSMutableDictionary *  lblDict = [[NSMutableDictionary alloc]initWithObjects:values forKeys:keys];
    
    
    //组装图片id的array
    
    [keys removeAllObjects];
    [values removeAllObjects];
    
    i = 0;
    
    for (NSString * str in self.imageIDArray) {
        
        NSString * key = [NSString stringWithFormat:@"topic.topicAttachmentList[%d].attachment.id", i];
        
        [keys addObject:key];
        
        [values addObject:str];
        
        i++;
        
    }
    //盛放图片id的字典
    NSMutableDictionary * picDict = [[NSMutableDictionary alloc]initWithObjects:values forKeys:keys];
    NSLog(@"{PicDict}:%@", picDict);
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString *ddid = [d objectForKey:UD_ddid];
    
    NSDictionary * loginDict = [d objectForKey:UD_loginDict];
    
    NSString * lon = [loginDict objectForKey:@"longitude"];
    NSString * lat = [loginDict objectForKey:@"latitude"];
    
    NSString * newlimitTime = [TimeTool getmyLimitTime:self.limitTime];
    
    NSLog(@"searchText:%@", searchText);
    NSLog(@"lon:%@" ,lon);
    NSLog(@"lat:%@", lat);
    //    NSDictionary * commonDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", curPage, @"activityQuery.pageNum", nil];
    //    [postDict addEntriesFromDictionary:commonDict]
    
//    nss
    
    self.isAnonmity = 1;
    
    NSString * flag = [NSString stringWithFormat:@"%d", self.isAnonmity];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", self.mTitle, @"topic.title", self.content, @"topic.content", searchText, @"topic.searchWord", lon, @"topic.longitude", lat, @"topic.latitude", newlimitTime, @"topic.limitTime", flag,@"topic.anonymousFlag",nil];
    
    [postDict addEntriesFromDictionary:lblDict];
    [postDict addEntriesFromDictionary:picDict];
    NSLog(@"{postDict:%@}", postDict);
    
    [http fiveReuqestUrl:TOP_1_2_6 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"发布失败"];
    }];

}
/**发布活动**/
-(void)publishACT
{
        NSLog(@"---------publishACT begin");
    _selectArray = [[NSMutableArray alloc]init];
    
    for (Item_ACT_Hot * item in _dataArray) {
        
        if (item.isSelected == YES) {
            
            [_selectArray addObject:item];
        }
    }
    if (_selectArray.count == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择标签"];
        return;
    }
    NSMutableString * searchText = [[NSMutableString alloc]init];
    for (Item_ACT_Hot * item in _selectArray) {
        
        //        [searchText stringByAppendingFormat:@"%@,", item.name];
        [searchText appendFormat:@"%@,", item.name];
    }
    //自定义标签
    UITextField * tf = (UITextField *)[self.view viewWithTag:DTAG_TEXTFIELD];
    
    NSString * DIYString = [StringTool replaceCommcomma:tf.text];
    
    [searchText appendString:DIYString];
    
    NSLog(@"%@", searchText);
    
    NSMutableArray * keys = [[NSMutableArray alloc]init];
    
    NSMutableArray * values = [[NSMutableArray alloc]init];
    
    int i = 0;
    
    for (Item_ACT_Hot * item in _selectArray) {
        
        NSString * mIDStr = [NSString stringWithFormat:@" activity.actActivityLabel[%d].id", i];
        
        [keys addObject:mIDStr];
        
        [values addObject:item.mid];
        
        i++;
    }
    //组装标签
    NSMutableDictionary *  lblDict = [[NSMutableDictionary alloc]initWithObjects:values forKeys:keys];
    
    
    //组装图片id的array
    
    [keys removeAllObjects];
    [values removeAllObjects];
    
    i = 0;
    
    for (NSString * str in self.imageIDArray) {
        
        NSString * key = [NSString stringWithFormat:@"activity.activityAttachmentList[%d].attachment.id", i];
        
        [keys addObject:key];
        
        [values addObject:str];
        
        i++;
        
    }
    //盛放图片id的字典
    NSMutableDictionary * picDict = [[NSMutableDictionary alloc]initWithObjects:values forKeys:keys];
    NSLog(@"{PicDict}:%@", picDict);
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString *ddid = [d objectForKey:UD_ddid];
    
    NSDictionary * loginDict = [d objectForKey:UD_loginDict];
    
    NSString * lon = [loginDict objectForKey:@"longitude"];
    NSString * lat = [loginDict objectForKey:@"latitude"];
    
    NSString * newlimitTime = [TimeTool getmyLimitTime:self.limitTime];
    
    NSLog(@"searchText:%@", searchText);
    NSLog(@"lon:%@" ,lon);
    NSLog(@"lat:%@", lat);
    //    NSDictionary * commonDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", curPage, @"activityQuery.pageNum", nil];
    //    [postDict addEntriesFromDictionary:commonDict];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", self.mTitle, @"activity.title", self.content, @"activity.content", searchText, @"activity.searchWord", lon, @"activity.longitude", lat, @"activity.latitude", newlimitTime, @"activity.limitTime",nil];
    
    [postDict addEntriesFromDictionary:lblDict];
    [postDict addEntriesFromDictionary:picDict];
    NSLog(@"{postDict:%@}", postDict);
    
    [http fiveReuqestUrl:dUrl_ACT_1_2_7 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"发布失败"];
    }];

}
-(void)createRightItem
{
    NSLog(@"---------createRightItem begin");
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)viewDidLoad
{

        NSLog(@"---------viewDidLoad begin");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加标签";
    
    NSLog(@"%@", self.mTitle);
    NSLog(@"%@", self.content);
    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _frame = _tableView.frame;
    NSLog(@"_frame : %@", NSStringFromCGRect(_frame));
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [self createFooterView];
    
    [self setupRefresh:self.tableView];
    
    [self createRightItem];
    
    [self initLeftItem];
    
    
    switch (self.type) {
        case TAG_TOPICREQ:
        {
             [self getLabelListRequestTopic];
        }
            break;
        case TAG_ACTREQ:
        {
              [self getLabelListRequest];
        }
            break;
        default:
            break;
    }
  
    
   
    
        UITextField * tf = (UITextField *)[self.view viewWithTag:DTAG_TEXTFIELD];
    
        __weak UITextField * weakTf = tf;
    
        [self.mm_drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
            
            [weakTf resignFirstResponder];
            return 0;
        }];
}
#pragma mark - 获得所有标签
-(void)getLabelListRequest
{
    NSLog(@"---------getLabelListRequest begin");
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString *ddid = [d objectForKey:UD_ddid];
    
    NSDictionary * dict = @{@"D_ID": ddid , @"activityLabelQuery.userTypeID": @"1"};
    
    __weak SelectHotLabelVC * weakSelf = self;
    
    [http fiveReuqestUrl:dUrl_ACT_1_3_1 postDict:dict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [weakSelf.dataArray removeAllObjects];
        NSDictionary * root = (NSDictionary *)obj;
        
        NSArray * value = [root objectForKey:@"value"];
        
        for (NSDictionary * dict in value) {
            
            Item_ACT_Hot * item = [[Item_ACT_Hot alloc]init];
            
            item.name = [dict objectForKey:@"name"];
            item.mid = [dict objectForKey:@"id"];
            
            [_dataArray addObject:item];
        }
        
        [weakSelf.tableView headerEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
        [weakSelf.tableView reloadData];
        
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    }];
}

/**话题标签列表**/
-(void)getLabelListRequestTopic
{
    NSLog(@"---------getLabelListRequestTopic begin");
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString *ddid = [d objectForKey:UD_ddid];
    
    NSDictionary * dict = @{@"D_ID": ddid};
    
    __weak SelectHotLabelVC * weakSelf = self;
    
    [http fiveReuqestUrl:TOP_1_3_1
 postDict:dict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [weakSelf.dataArray removeAllObjects];
        NSDictionary * root = (NSDictionary *)obj;
        
        NSArray * value = [root objectForKey:@"value"];
        
        for (NSDictionary * dict in value) {
            
            Item_ACT_Hot * item = [[Item_ACT_Hot alloc]init];
            
            item.name = [dict objectForKey:@"name"];
            item.mid = [dict objectForKey:@"id"];
            
            [_dataArray addObject:item];
        }
        
        [weakSelf.tableView headerEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
        [weakSelf.tableView reloadData];
        
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    }];
}

#pragma mark - 下拉刷新

-(void)headerRereshing
{
    NSLog(@"---------headerRereshing begin");
    switch (self.type) {
        case TAG_TOPICREQ:
        {
            [self getLabelListRequestTopic];
        }
            break;
        case TAG_ACTREQ:
        {
            [self getLabelListRequest];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 上拉加载更多
-(void)footerRereshing
{
    NSLog(@"---------footerRereshing begin");
    switch (self.type) {
        case TAG_TOPICREQ:
        {
            [self getLabelListRequestTopic];
        }
            break;
        case TAG_ACTREQ:
        {
            [self getLabelListRequest];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 发送自定义标签

-(void)sendMsg:(UIButton *)button
{
    NSLog(@"---------sendMsg begin");
    UITextField * tf = (UITextField *)[self.view viewWithTag:DTAG_TEXTFIELD];
    [tf resignFirstResponder];
    
    switch (self.type) {
        case TAG_TOPICREQ:
        {
            [self publicTop];
        }
            break;
        case TAG_ACTREQ:
        {
            [self publishACT];
        }
            break;
        default:
            break;
    }

    
}
#pragma mark - 常用标签
-(void)btnClick:(UIButton *)button
{
    NSLog(@"---------btnClick begin");
    Item_ACT_Hot * item = _dataArray[button.tag - MAX_TAG];
    button.selected = !button.selected;
    item.isSelected = button.selected;
    [self.tableView reloadData];
}
#pragma mark - 最近热门标签
-(void)btnClick2:(UIButton *)button
{
    NSLog(@"---------btnClick2 begin");
    
//    Item_ACT_Hot * item = _dataArray[button.tag - MAX_TAG];
//    button.selected = !button.selected;
//    item.isSelected = button.selected;
//    [self.tableView reloadData];
}
#pragma mark - 创建表格视图的footer
-(UIView *)createFooterView
{
    NSLog(@"---------createFooterView begin");
    UIView * mainView = [[UIView alloc]init];
    mainView.frame = CGRectMake(0, 0, kMainScreenWidth, 160 );
    
    UIImageView * iView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 3, 10, 24)];
    iView.backgroundColor = [UIColor redColor];
    [mainView addSubview:iView];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iView.frame), 0, kMainScreenWidth - CGRectGetMaxX(iView.frame), 30)];
    lbl.text = @"自定义标签";
    [mainView addSubview:lbl];
    
    UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lbl.frame), kMainScreenWidth - 40, 35)];
    textField.tag = DTAG_TEXTFIELD;
    textField.placeholder = @"请输入";
    textField.delegate = self;
    [mainView addSubview:textField];
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(textField.frame), CGRectGetWidth(textField.frame), 1)];
    line.backgroundColor = [UIColor grayColor];
    [mainView addSubview:line];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"button-normal"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, CGRectGetMaxY(line.frame), kMainScreenWidth - 40, 30);
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(sendMsg:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:btn];
    
    UILabel * noticeLbl = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(btn.frame) + 5, kMainScreenWidth - 40, 30)];
    noticeLbl.text = @"合理的设置标签可以让你的帖子被更快的发现和回应";
    noticeLbl.font = [UIFont systemFontOfSize:12];
    noticeLbl.textColor = kRGB(174, 143, 112);
    [mainView addSubview:noticeLbl];
    
    return mainView;
}
#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"---------numberOfRowsInSection begin");
    if ([_dataArray count] % 2 == 0) {
        
        _isDouble = YES;
    }else{
        
        _isDouble = NO;
    }
    
    return [_dataArray count] % 2 == 0 ? _dataArray.count / 2: _dataArray.count / 2 + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---------cellForRowAtIndexPath begin");
    static NSString * strID = @"ID";
    
    Cell_ACTLabel * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (nil == cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell_ACTLabel" owner:self options:nil]lastObject];
    }
    
    UIColor * gray = [UIColor grayColor];
    UIColor * black = [UIColor blackColor];
    NSArray * arr = @[gray, black];
    
    Item_ACT_Hot * itemRight = nil;
    if (!(_isDouble == NO && (indexPath.row + 1) * 2 - 1 == [_dataArray count])) {
        
        itemRight = _dataArray[indexPath.row * 2 + 1];
        
        cell.lblRight.text = itemRight.name;
        cell.lblRight.textColor = arr[itemRight.isSelected];
        cell.btnRight.selected = itemRight.isSelected;
        //        cell.btnRight.backgroundColor = [UIColor redColor];
        [cell.btnRight setBackgroundImage:[UIImage imageNamed:@"register1_check0"] forState:UIControlStateNormal];
        [cell.btnRight setBackgroundImage:[UIImage imageNamed:@"register1_check1"] forState:UIControlStateSelected];
        
        cell.btnRight.tag = MAX_TAG + indexPath.row * 2 + 1;
        [cell.btnRight addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    Item_ACT_Hot * itemLeft = _dataArray[indexPath.row * 2] ;
    cell.lblLeft.text = itemLeft.name;
    cell.lblLeft.textColor = arr[itemLeft.isSelected];
    cell.btnLeft.selected = itemLeft.isSelected;
    //    cell.btnLeft.backgroundColor = [UIColor redColor];
    //    [cell.btnLeft setImage:[UIImage imageNamed:@"register1_check"] forState:UIControlStateNormal];
    [cell.btnLeft setBackgroundImage:[UIImage imageNamed:@"register1_check0"] forState:UIControlStateNormal];
    [cell.btnLeft setBackgroundImage:[UIImage imageNamed:@"register1_check1"] forState:UIControlStateSelected];
    cell.btnLeft.tag = MAX_TAG + indexPath.row * 2;
    [cell.btnLeft addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@"---------viewForHeaderInSection begin");
    UIView * mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 74)];
    mainView.backgroundColor = [UIColor whiteColor];
    UIImageView * iView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 3, 10, 24)];
    iView.backgroundColor = [UIColor redColor];
    [mainView addSubview:iView];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iView.frame), 0, kMainScreenWidth - CGRectGetMaxX(iView.frame), 30)];
    lbl.text = @"常用标签";
    [mainView addSubview:lbl];
    return mainView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSLog(@"---------heightForHeaderInSection begin");
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSLog(@"---------viewForFooterInSection begin");
    UIView * mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60)];
    mainView.backgroundColor = [UIColor whiteColor];
    UIImageView * iView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 3, 10, 24)];
    iView.backgroundColor = [UIColor redColor];
    [mainView addSubview:iView];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iView.frame), 0, kMainScreenWidth - CGRectGetMaxX(iView.frame), 30)];
    lbl.text = @"最近热门标签";
    [mainView addSubview:lbl];
    
    NSUserDefaults * d  = [NSUserDefaults standardUserDefaults];
     NSArray * name = [d objectForKey:UD_hotWord];
    
    if (name.count < 4) {
        
        for (int i = 0; i < name.count; i++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"register1_check0"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"register1_check1"] forState:UIControlStateSelected];
            //        [btn setImage:[UIImage imageNamed:@"register1_check0"] forState:UIControlStateNormal];
            //        [btn setImage:[UIImage imageNamed:@"register1_check1"] forState:UIControlStateSelected];
            btn.backgroundColor = [UIColor redColor];
            [btn setLayout:OTSImageLeftTitleRightStyle spacing:5];
            [btn setTitle:name[i] forState:UIControlStateNormal];
             btn.titleLabel.numberOfLines = 2;
            btn.frame = CGRectMake(20 + 70 * i, CGRectGetMaxY(lbl.frame), 60, 30);
            [mainView addSubview:btn];
            [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    else{
        
        for (int i = 0; i < 4; i++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"register1_check0"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"register1_check1"] forState:UIControlStateSelected];
            //        [btn setImage:[UIImage imageNamed:@"register1_check0"] forState:UIControlStateNormal];
            //        [btn setImage:[UIImage imageNamed:@"register1_check1"] forState:UIControlStateSelected];
        
            btn.backgroundColor = [UIColor redColor];
            [btn setLayout:OTSImageLeftTitleRightStyle spacing:5];
            [btn setTitle:name[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.titleLabel.numberOfLines = 2;
            btn.frame = CGRectMake(20 + 70 * i, CGRectGetMaxY(lbl.frame), 60, 30);
            [mainView addSubview:btn];
            [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return mainView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSLog(@"---------heightForFooterInSection begin");
    return 74;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---------heightForRowAtIndexPath begin");
    return 70;
}
#pragma mark - scrollViewDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"---------textFieldShouldReturn begin");
    UITextField * tf = (UITextField *)[self.view viewWithTag:DTAG_TEXTFIELD];
    [tf resignFirstResponder];
    return YES;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    UITextField * tf = (UITextField *)[self.view viewWithTag:DTAG_TEXTFIELD];
//    [tf resignFirstResponder];
//}
#pragma mark - textFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"---------textFieldShouldBeginEditing begin");
    NSLog(@"wwwwwwwwwww");
    
    //    int position = _dataArray.count / 2;
    //
    //    NSIndexPath * index = [NSIndexPath indexPathForRow:position inSection:0];
    //    [_tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    UIView * footer = self.tableView.tableFooterView;
    CGRect frame = footer.frame;
    frame.size.height += 232;
    footer.frame = frame;
    self.tableView.tableFooterView = footer;
    
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height -self.tableView.bounds.size.height) animated:YES];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"---------textFieldDidEndEditing begin");
    UIView * footer = self.tableView.tableFooterView;
    CGRect frame = footer.frame;
    frame.size.height -= 252 - 20;
    footer.frame = frame;
    self.tableView.tableFooterView = footer;
    
    ////当前显示区域顶点相对于frame顶点的偏移量
    //    _scrollView.contentOffset = CGPointMake(0, 0);
    /**让tableView滚动到底部**/
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height -self.tableView.bounds.size.height) animated:YES];
}

@end
