//
//  HotTopicDetailVC.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//话题详情

#import "HotTopicDetailVC.h"
#import "Item_HotTopDetailRow.h"
#import "Item_HotTopicDetail.h"
#import "Cell_HotTopDetailRowTableViewCell.h"
#import "Cell_HotTopicDetail.h"
#import "UIViewController+General.h"
#import "HMSegmentedControl.h"
#import "UIView+WhenTappedBlocks.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "TimeTool.h"

#import "UIViewController+General.h"
#import "DialogView.h"
#import "SVProgressHUD.h"
#import "UIViewController+MMDrawerController.h"
#import "UIScrollView+MJExtension.h"
#import "MJRefresh.h"
#import "UIView+WhenTappedBlocks.h"
#import "AppDelegate.h"
#import "CheckDataTool.h"
#import "CreateTAopicVC.h"

@interface HotTopicDetailVC ()
@property(nonatomic , strong) NSMutableArray * dataSource1;
@property(nonatomic , strong) NSMutableArray * dataSource2;
@property(nonatomic , strong) UITableView * tableView;
@property(nonatomic , strong) UITextView * importText;
@property(nonatomic , strong)UIButton * optionBtn;
@property(nonatomic , strong)UIButton * sendMsg;
@property(nonatomic , strong)UIView * importView;
@property(nonatomic , strong)NSString *topicID;//某个话题回复的id
@property(nonatomic , assign)TopicDetailSendType topicSendType ;
@property(nonatomic , assign)TopicOperationTyoe operationType;
@end

@implementation HotTopicDetailVC
{
    AFN_HttpBase * http;
    MBProgressHUD * loading;
    NSString * sendName;//回复某人的名字
    AppDelegate * app;
    NSString * D_ID;
    TopicReplyQueryType trqType;//按照三种方式搜索
    //    NSString * url;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"话题详情";
        http = [[AFN_HttpBase alloc]  init];
    }
    return self;
}
-(void)showLoading{
	loading = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:loading];
	loading.labelText = @"Loading";
    [loading show:YES];
}
-(void)disMissLoading{
    if (nil != loading) {
        [loading  removeFromSuperview];
    }
}


//话题楼主键值对
-(NSDictionary *)setRequestParam{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]  init];
    [param setValue:self._id forKey:@"topicQuery.id"];
    [param setValue:D_ID forKey:@"D_ID"];
    return param;
}
//话题回复键值对
-(NSDictionary *)setRequestReplyParam:(NSString *)name{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]  init];
    [param setValue:D_ID forKey:@"D_ID"];
    [param  setValue:self._id forKey:@"topicReply.topic.id"];
    NSString * flag = self.optionBtn.selected == YES?@"1":@"2";
    [param setValue:flag forKey:@"topicReply.anonymousFlag"];
    NSString * content;
    NSString * textContent =  self.importText.text;
    if (name.length <= 0||nil == name) {
        content = textContent;
    }else{
        content = [NSString stringWithFormat:@"%@%@",name , textContent];
    }
    [param setValue:content forKey:@"topicReply.content"];
    return param;
}


//话题回复检索键值对
-(NSDictionary *)setRequestTalkReplyParam{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]  init];
    [param setValue:self._id forKey:@"topicReplyQuery.topicID"];
    [param setValue:D_ID forKey:@"D_ID"];
    [param setValue:@"1" forKey:@"topicReplyQuery.pageNum"];
    switch (trqType) {
        case TopicHot://热度
            [param setValue:@"1" forKey:@"topicReplyQuery.sort"];
            break;
        case TopicTime://时间
            [param setValue:@"2" forKey:@"topicReplyQuery.sort"];
            break;
        case TopicRelation://关系
            [param setValue:@"3" forKey:@"topicReplyQuery.sort"];
            break;
        default:
            break;
    }
    return param;
}
//话题 举报某个话题参数
-(NSDictionary *)setParamReportTopicID:(NSString *)topic_Id content:(NSString *)info{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]  init];
    [param setValue:D_ID forKey:@"D_ID"];
    [param setValue:info forKey:@"topicReport.content"];
    [param setValue:topic_Id forKey:@"topicReport.topic.id"];
    return param;
}

//话题 举报某个话题回复参数
-(NSDictionary *)setParamReplyReportTopicID:(NSString *)topic_Id content:(NSString *)info{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]  init];
    [param setValue:D_ID forKey:@"D_ID"];
    [param setValue:info forKey:@"topicReplyReport.content"];
    [param setValue:topic_Id forKey:@"topicReplyReport.topicReply.id"];
    return param;
}
//收藏某个话题或者话题回复的参数
-(NSDictionary *)setParamTopicStoreTopId:(NSString*)topic_Id topicReplyId:(NSString *)repleyId  topicStoreType:(NSString *)type actType:(NSString *)actType
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]  init];
    [param setValue:D_ID forKey:@"D_ID"];
    [param setValue:topic_Id forKey:@"topicStore.topic.id"];
    [param setValue:repleyId forKey:@"    topicStore.topicReply.id"];
    [param setValue:type forKey:@"topicStore.type"];
    [param setValue:actType forKey:@"topicStore.actType"];
    
    return param;
}


//请求话题详细--包括楼主信息和下面的话题回复搜索
-(void) requestData:(NSDictionary *)param
{
    __weak HotTopicDetailVC * weakSelf = self;
    [http  fiveReuqestUrl:TOP_1_2_4 postDict:param succeed:^(NSObject *obj, BOOL isFinished) {
        NSDictionary * value = [(NSDictionary*)obj objectForKey:@"value"];
        NSString * _id = [value  objectForKey:@"id"];
        NSString * time = [TimeTool dateToString:[value objectForKey:@"time"]];
        NSString * title = [value  objectForKey:@"title"];
        NSString * content = [value objectForKey:@"content"];
        NSString * imageId = [value objectForKey:@"photoURL"];
        
        NSDictionary * authorDic = [value objectForKey:@"author"];
        NSString * petName = [authorDic objectForKey:@"petName"];
        
        
        NSString * age = [value objectForKey:@"age"];
        NSString * viewSupportFlag = [value objectForKey:@"viewSupportFlag"];
        NSString * replies = [value objectForKey:@"replies"];
        NSString * supports = [NSString stringWithFormat:@"%@",[value objectForKey:@"supports"]];
        
        Item_HotTopicDetail * item1= [[Item_HotTopicDetail alloc]  init];
        item1._id = _id;
        item1.day = time;
        item1.title = title;
        item1.content = content;
        item1.headerPath = imageId;
        item1.headerName = petName;
        item1.age = age;
        item1.imagePath1 = @"baby_m_r.png";
        item1.imagePath2 = @"baby_m_r.png";
        item1.imagePath3 = @"baby_m_r.png";
        item1.imagePath4 = @"baby_m_r.png";
        item1.imagePath5 = @"baby_m_r.png";
        item1.imagePath6 = @"baby_m_r.png";
        item1.imagePath7 = @"baby_m_r.png";
        item1.imagePath8 = @"baby_m_r.png";
        item1.imagePath9 = @"baby_m_r.png";
        item1.viewReportFlag = [NSString stringWithFormat:@"%@",viewSupportFlag];
        item1.good = supports;
        item1.msg = replies;
        [weakSelf.dataSource1  addObject:item1];
        [weakSelf requestTalkReplyData:[weakSelf setRequestTalkReplyParam]];
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    }];
}
//TOP_1_4_2  话题回复搜索
-(void)requestTalkReplyData:(NSDictionary *)param{
    NSLog(@"-------  param %@",param);
    __weak HotTopicDetailVC * weakSelf = self;
    [http sixReuqestUrl:TOP_1_4_2 postDict:param succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        NSDictionary * dic = [(NSDictionary*)obj objectForKey:@"value"];
        NSArray * array = [dic  objectForKey:@"list"];
        
        for (int i = 0; i < array.count; i++) {
            NSDictionary * dic = [array  objectAtIndex:i];
            NSString * content = [dic  objectForKey:@"content"];
            NSLog(@"---内容  -- %@",content);
            NSString * _id = [dic objectForKey:@"id"];
            NSDictionary * dicAuthor = [dic  objectForKey:@"author"];
            NSString * viewReportFlag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"viewReportFlag"]];
            NSString * petName = [dicAuthor objectForKey:@"petName"];
            NSString * name = [dicAuthor objectForKey:@"name"];
            NSString * supports = [NSString stringWithFormat:@"%@",[dic objectForKey:@"supports"]];
            
            Item_HotTopDetailRow * item2 = [[Item_HotTopDetailRow alloc]  init];
            item2._id = _id;
            item2.headerPath = @"baby_m_r.png";
            item2.good = supports;
            item2.content = content;
            item2.name = petName;
            item2.age = @"122";
            item2.viewReportFlag = viewReportFlag;
            [weakSelf.dataSource2  addObject:item2];
        }
        [weakSelf.tableView reloadData];
        [weakSelf stopRefresh];
        [weakSelf disMissLoading];
        
    } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        
    }];
}

//话题回复请求
-(void)requestTopicReply:(NSString *) replyUrl setParam:(NSDictionary *)param
{
    __weak HotTopicDetailVC *weakSelf = self;
    [http sixReuqestUrl:replyUrl postDict:param succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        NSString * value = [(NSDictionary *)obj objectForKey:@"value"];
        NSString * valueS = [NSString stringWithFormat:@"%@",value];
        if ([valueS  isEqualToString:@"1"]) {
            [SVProgressHUD showSimpleText:@"提交信息成功"];
            trqType = TopicHot;
            sendName = nil;
            weakSelf.importText.text = @"";
            [weakSelf.dataSource2  removeAllObjects];
            [NSThread sleepForTimeInterval:4]; //延时3秒钟
            [weakSelf requestTalkReplyData:[weakSelf setRequestTalkReplyParam]];
        }else{
            [SVProgressHUD showSimpleText:@"提交信息失败"];
        }
    } failed:
     ^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
         weakSelf.importText.text = @"";
         [self disMissLoading];
     }];
}
//举报某个话题回复的请求
-(void)requestReportData:(NSDictionary *)param setUrl:(NSString *)reportUrl{
    [http  sixReuqestUrl:reportUrl postDict:param succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        NSDictionary * dic = (NSDictionary *)obj;
        NSString *value = [NSString stringWithFormat:@"%@",[dic  objectForKey:@"value"]];
        if ([value isEqualToString:@"1"]) {
            [SVProgressHUD showSimpleText:@"举报成功"];
        }else{
            
        }
        [self disMissLoading];
    } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        [SVProgressHUD showSimpleText:@"举报失败"];
        [self disMissLoading];
    }];
}
//收藏某个话题或者话题回复的请求
-(void) requestTopicStoreDataURl:(NSString *)url setParam:(NSDictionary *)param
{
    [http  sixReuqestUrl:url postDict:param succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        NSDictionary * dic = (NSDictionary *)obj;
        NSString * value = [NSString stringWithFormat:@"%@",[dic objectForKey:@"value"]];
        if ([value isEqualToString:@"1"]) {
            [SVProgressHUD showSimpleText:@"收藏成功"];
        }else{
            [SVProgressHUD showSimpleText:@"收藏失败"];
        }
        [self disMissLoading];
    } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        [SVProgressHUD showSimpleText:@"收藏失败"];
        [self disMissLoading];
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    trqType = TopicHot;
    app = [AppDelegate shareInstace];
    D_ID = [app.loginDict  objectForKey:@"d_ID"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource1 = [[NSMutableArray alloc]  init];
    self.dataSource2 = [[NSMutableArray alloc]  init];
    [self createComponent];
    [self setupRefresh];
}


-(void)viewWillAppear:(BOOL)animated
{
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:dNoti_isHideKeyBoard object:nil];
}

-(void)createComponent
{
    [self initLeftItem];
    
    [self keyboardNotification];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 44)];
    [self.view  addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource  =self;
    //    [self.tableView setEditing:YES animated:NO];
    [self createImportView];
}
-(void) createImportView{
    
    self.importView = [[UIView alloc]  initWithFrame:CGRectMake(0, self.view.frame.size.height - 49 - 64 - 44 , self.view.frame.size.width, 44)];
    UIImageView * importBg = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    importBg.backgroundColor = [UIColor redColor];
    [importBg setImage:[UIImage imageNamed:@"回复底图.png"]];
    [self.importView  addSubview:importBg];
    
    self.optionBtn = [[UIButton alloc]  initWithFrame:CGRectMake(5,10, 30, 30)];
    [self.optionBtn setBackgroundImage:[UIImage imageNamed:@"register1_check1.png"] forState:UIControlStateSelected];
    [self.optionBtn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.optionBtn setBackgroundImage:[UIImage imageNamed:@"register1_check0.png"] forState:UIControlStateNormal];
    self.optionBtn.selected = NO;
    self.optionBtn.adjustsImageWhenHighlighted = NO;
    [self.importView  addSubview:self.optionBtn];
    
    int distance = 2;
    UILabel * lable = [[UILabel alloc]  initWithFrame:CGRectMake(self.optionBtn.frame.origin.x+self.optionBtn.frame.size.width + distance, 10, 40, 30)];
    lable.text = @"匿名";
    
    [self.importView addSubview:lable];
    
    self.importText = [[UITextView alloc]  initWithFrame:CGRectMake(self.optionBtn.frame.origin.x+self.optionBtn.frame.size.width + distance + lable.frame.size.width+2,10 , 320-(self.optionBtn.frame.origin.x+self.optionBtn.frame.size.width+distance+lable.frame.size.width+distance+2+5)-40, 30)];
    self.importText.backgroundColor = [UIColor whiteColor];
    self.importText.font = [UIFont boldSystemFontOfSize:14];
    //    UIImageView * imgView = [[UIImageView alloc]init];
    //    self.importText.delegate = self;
    //    CGRect frame = self.importText.frame;
    //    frame.origin = CGPointMake(0, 0);
    //    imgView.frame = frame;
    //    imgView.image = [UIImage imageNamed:@"回应输入框.png"];
    __weak HotTopicDetailVC * weakSelf = self;
    [self.mm_drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        [weakSelf.importText resignFirstResponder];
        return 0;
    }];
    //    [self.importText addSubview:imgView];
    self.importText.delegate = self;
    [self.importView addSubview:self.importText];
    self.sendMsg = [[UIButton alloc]  initWithFrame:CGRectMake(self.view.frame.size.width - 40, 10, 38, 30)];
    self.sendMsg.backgroundColor = [UIColor redColor];
    [self.sendMsg  setTitle:@"发送" forState:UIControlStateNormal];
    self.sendMsg.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.sendMsg  addTarget:self action:@selector(onTouchClick) forControlEvents:UIControlEventTouchUpInside];
    self.sendMsg.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.importView addSubview:self.sendMsg];
    
    [self.view addSubview:self.importView];
}
//对话题的发送信息和对话题回复帖子的发送各种信息(举报，删除，回复等)
-(void)onTouchClick{
    if (![CheckDataTool checkInfoForString:self.importText msgContent:@"请您输入信息"]){
        return;
    }
    [self showLoading ];
    switch (self.topicSendType) {
        case TopicDetailReply:
            if (self.operationType == TopicOperationAuthor) {
                [self requestTopicReply:TOP_1_4_1 setParam:[self setRequestReplyParam:nil]];
            }else{
                [self requestTopicReply:TOP_1_4_1 setParam:[self setRequestReplyParam:sendName]];
            }
            break;
        case TopicDetailCollect:
            
            break;
        case TopicDetailCopy:
            
            break;
        case TopicDetailReport:
            if (self.operationType == TopicOperationAuthor) {//判断是给楼主举报还是回帖
                [self requestReportData:[self setParamReportTopicID:self.topicID content:self.importText.text] setUrl:TOP_1_6_1];
            }else{
                [self requestReportData:[self setParamReplyReportTopicID:self.topicID content:self.importText.text] setUrl:TOP_1_10_1];
            }
            break;
        case TopicDetailDelete:
            
            break;
            
        default:
            break;
    }
    
    
    
}
-(void)changeBtn:(UIButton *)b
{
    b.selected = !b.selected;
}

//键盘出现
-(void) keyboardWillShow:(NSNotification*)aNotification
{
    [[NSNotificationCenter defaultCenter]  postNotificationName:dNoti_isHideKeyBoard object:@"0"];
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGRect frame = self.importView.frame;
    frame.origin.y = (ScreenHegiht-64)-(kbSize.height+self.importView.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.importView.frame = frame;
    }];
    
    
}
//键盘隐藏
-(void)keyboardWillHide:(NSNotification*)aNotification
{
    [[NSNotificationCenter defaultCenter]  postNotificationName:dNoti_isHideKeyBoard object:@"1"];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        self.importView.frame = CGRectMake(0,self.view.frame.size.height - 49  - 44 , self.view.frame.size.width, 44);
    }];
    
    
}
//系统的Item方法
-(void)navItemClick:(UIButton *)button
{
    if (IOS7) {
        self.navigationController.navigationBar.translucent = YES;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    [self.navigationController  popViewControllerAnimated:YES];
}



#pragma mark tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 26;
    }else{
        return 26;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *v = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 26)];
        v.backgroundColor = [UIColor whiteColor];
        UIButton * iv2 = [[UIButton alloc]  initWithFrame:CGRectMake(0, 0, 60, 25)];
        [iv2 setTitle:@"楼主" forState:UIControlStateNormal];
        iv2.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        [iv2 setBackgroundImage:[UIImage imageNamed:@"header.png"] forState:UIControlStateNormal];
        [iv2  whenTapped:^{
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }];
        [v addSubview:iv2];
        UIImageView * line = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 25, self.view.frame.size.width , 1)];
        [line  setImage:[UIImage imageNamed:@"line"]];
        [v addSubview:line];
        
        return v;
    }else{
        UIView *v = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 26)];
        v.backgroundColor = [UIColor whiteColor];
        
        UIImageView * line = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 2)];
        [line  setImage:[UIImage imageNamed:@"line"]];
        [v addSubview:line];
        
        UIButton * iv2 = [[UIButton alloc]  initWithFrame:CGRectMake(0, 2, 60, 25)];
        [iv2 setTitle:@"跟帖" forState:UIControlStateNormal];
        [iv2 setBackgroundImage:[UIImage imageNamed:@"header.png"] forState:UIControlStateNormal];
        iv2.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        [v addSubview:iv2];
        [iv2  whenTapped:^{
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }];
        NSArray * array = @[@"按热度",@"按时间",@"按关系"];
        HMSegmentedControl *segmented = [[HMSegmentedControl alloc]  initWithSectionTitles:array];
        [segmented setSelectedSegmentIndex:trqType];
        segmented.selectionIndicatorColor = [UIColor redColor];
        segmented.frame = CGRectMake(65, 2, self.view.frame.size.width - 65, 22);
        [segmented setSelectedTextColor:[UIColor redColor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ]];
        segmented.selectionStyle = HMSegmentedControlSelectionStyleBox;
        [segmented setFont:[UIFont systemFontOfSize:14]];
        [segmented setIndexChangeBlock:^(NSInteger index) {
            [self showLoading];
            switch (index) {
                case 0:
                {
                    trqType = TopicHot;
                    [self requestTalkReplyData:[self setRequestTalkReplyParam]];
                }
                    break;
                case 1:
                {
                    trqType = TopicTime;
                    [self requestTalkReplyData:[self setRequestTalkReplyParam]];
                }
                    break;
                case 2:
                {
                    trqType = TopicRelation;
                    [self requestTalkReplyData:[self setRequestTalkReplyParam]];
                }
                    break;
                default:
                    break;
            }
        }];
        
        [v addSubview:segmented];
        UIImageView * line2 = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 25, self.view.frame.size.width , 1)];
        [line2  setImage:[UIImage imageNamed:@"line"]];
        [v addSubview:line2];
        return v;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 480;
    }else{
        return 139;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataSource1.count;
    }else{
        return self.dataSource2.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        static NSString *identifier=@"ID";
        Cell_HotTopicDetail * cell1 = [tableView dequeueReusableCellWithIdentifier:
                                       identifier];
        if (nil == cell1) {
            cell1 = [[[NSBundle mainBundle] loadNibNamed:@"Cell_HotTopicDetail" owner:self options:nil] lastObject];
        }
        Item_HotTopicDetail * item = [self.dataSource1  objectAtIndex:indexPath.row];
        cell1.day.text = item.day;
        cell1.title.text = item.title;
        
        cell1.content.text = item.content;
        
        if (item.headerPath == nil){
            cell1.header.image = [UIImage imageNamed:@"2.png"];
        }else{
            cell1.header.image = [UIImage imageNamed:item.headerPath];
        }
        
        
        cell1.headerNmae.text = item.headerName;
        cell1.age.text = [NSString stringWithFormat:@"%@",item.age];
        [cell1.imageGroup whenTapped:^{
            NSLog(@"tap");
            cell1.image1.tag = 1001;
            [self createPhotoBrowser:1 image:cell1.image1.image];
        }];
        
        cell1.image1.image = [UIImage imageNamed:item.imagePath1];
        cell1.image2.image = [UIImage imageNamed:item.imagePath2];
        cell1.image3.image = [UIImage imageNamed:item.imagePath3];
        cell1.image4.image = [UIImage imageNamed:item.imagePath4];
        cell1.image5.image = [UIImage imageNamed:item.imagePath5];
        cell1.image6.image = [UIImage imageNamed:item.imagePath6];
        cell1.image7.image = [UIImage imageNamed:item.imagePath7];
        cell1.image8.image = [UIImage imageNamed:item.imagePath8];
        cell1.image9.image = [UIImage imageNamed:item.imagePath9];
        cell1.good.text = [NSString stringWithFormat:@"%@",item.good];
        cell1.msg.text = [NSString stringWithFormat:@"%@",item.msg];
        cell1.contentView.backgroundColor = [UIColor clearColor];
        if ([item.viewReportFlag isEqualToString:@"1"]) {
            [cell1.clickGood setImage:[UIImage imageNamed:@"good_1.png"]];
        }else{
            [cell1.clickGood setImage:[UIImage imageNamed:@"good_2.png"]];
        }
        [cell1.clickGood  whenTapped:^{
            NSString * flag =  item.viewReportFlag;
            [self requestClickGoodData:item._id setActtype:flag isAuthor:0 indexPath:indexPath.row];
        }];
        
        
        UIView *aView = [[UIView alloc] initWithFrame:cell1.contentView.frame];
        
        aView.backgroundColor = [UIColor whiteColor];
        
        cell1.selectedBackgroundView = aView;
        return cell1;
    }else{
        static NSString *identifier=@"ID2";
        Cell_HotTopDetailRowTableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell2) {
            cell2 = [[[NSBundle mainBundle] loadNibNamed:@"Cell_HotTopDetailRowTableViewCell" owner:self options:nil] lastObject];
        }
        Item_HotTopDetailRow * item2 = [self.dataSource2 objectAtIndex:indexPath.row];
        
        cell2.header.image = [UIImage imageNamed:item2.headerPath];
        
        cell2.good.text = item2.good;
        
        
        cell2.content.text = item2.content;
        cell2.name.text = item2.name;
        
        cell2.age.text = item2.age;
        
        if ([item2.viewReportFlag  isEqualToString:@"1"]) {
            cell2.goodIv.image = [UIImage imageNamed:@"good_1.png"];
        }else{
            cell2.goodIv.image = [UIImage imageNamed:@"good_2.png"];
        }
        
        cell2.contentView.backgroundColor = [UIColor clearColor];
        
        UIView *aView = [[UIView alloc] initWithFrame:cell2.contentView.frame];
        
        aView.backgroundColor = [UIColor whiteColor];
        
        cell2.selectedBackgroundView = aView;
        
        
        
        [cell2.goodIv whenTapped:^{
            NSString * flag =  item2.viewReportFlag;
            [self requestClickGoodData:item2._id setActtype:flag isAuthor:1 indexPath:indexPath.row];
            
        }];
        return cell2;
        
        
        
    }
    
}
//设置话题回复点赞的设置
-(NSMutableDictionary*)setParamTopicReplySupportWith:(NSString *)topId setActtype:(NSString *)type{
    NSMutableDictionary * paramGood = [[NSMutableDictionary alloc]  init];
    [paramGood  setValue:D_ID forKey:@"D_ID"];
    [paramGood  setValue:topId forKey:@"topicReplySupport.topicReply.id"];
    [paramGood setValue:type forKey:@"topicReplySupport.acttype"];
    return paramGood;
}
//设置话题点赞的设置
-(NSMutableDictionary*)setParamTopicSupportWith:(NSString *)topId setActtype:(NSString *)type{
    NSMutableDictionary * paramGood = [[NSMutableDictionary alloc]  init];
    [paramGood  setValue:D_ID forKey:@"D_ID"];
    [paramGood  setValue:topId forKey:@"topicSupport.topic.id"];
    [paramGood setValue:type forKey:@"topicSupport.acttype"];
    return paramGood;
}


//为某个话题点赞
-(void)requestClickGoodData:(NSString *)topId setActtype:(NSString *)type isAuthor:(int)isAuthor indexPath:(NSInteger )index
{
    NSLog(@"--^^^^^^^^^^^^^^-- %@",type);
    NSMutableDictionary * paramGood = [[NSMutableDictionary alloc]  init];
    NSString * url;
    if (isAuthor == 0) {
        paramGood = [self setParamTopicSupportWith:topId setActtype:type];
        url = TOP_1_5_1;
    }else{
        paramGood = [self setParamTopicReplySupportWith:topId setActtype:type];
        url = TOP_1_9_1;
    }
    __weak HotTopicDetailVC * weakSelfG = self;
    [http sixReuqestUrl:url postDict:paramGood succeed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        NSString * value = [(NSDictionary*)obj objectForKey:@"value"];
        value = [NSString stringWithFormat:@"%@",value];
        
        if ([value isEqualToString:@"1"]){
            if ([type  isEqualToString:@"2"]) {
                [SVProgressHUD showSimpleText:@"点赞成功"];
            }else{
                [SVProgressHUD showSimpleText:@"取消点赞成功"];
            }
            
            if (isAuthor == 0) {//楼主
                Item_HotTopicDetail * item = [weakSelfG.dataSource1 objectAtIndex:index];
                NSString *good =  item.good;
                int goodI;
                if ([type  isEqualToString:@"1"]) {
                    goodI = [good intValue];
                    goodI -= 1;
                    item.viewReportFlag = @"2";
                }else{
                    goodI = [good intValue];
                    goodI += 1;
                    item.viewReportFlag = @"1";
                }
                item.good = [NSString stringWithFormat:@"%d",goodI];
            }else{ //跟帖
                Item_HotTopDetailRow * item =  [weakSelfG.dataSource2 objectAtIndex:index];
                NSString *good =  item.good;
                int goodI;
                if ([type  isEqualToString:@"1"]) {
                    goodI = [good intValue];
                    goodI -= 1;
                    item.viewReportFlag = @"2";
                }else{
                    goodI = [good intValue];
                    goodI += 1;
                    item.viewReportFlag = @"1";
                }
                item.good = [NSString stringWithFormat:@"%d",goodI];
            }
            
            
            [self.tableView reloadData];
        }else{
            if ([type  isEqualToString:@"0"]) {
                [SVProgressHUD showSimpleText:@"点赞失败"];
            }else{
                [SVProgressHUD showSimpleText:@"取消点赞失败"];
            }
            
        }
    } failed:^(AFHTTPRequestOperation *operation, NSObject *obj, BOOL succeed) {
        if ([type  isEqualToString:@"2"]) {
            [SVProgressHUD showSimpleText:@"点赞失败"];
        }else{
            [SVProgressHUD showSimpleText:@"取消点赞失败"];
        }
        
    }];
}


-(void)createPhotoBrowser:(int)tag image:(UIImage *)image
{
    tag = 1;
    int count = 9;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        //        NSString *url = [_urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:nil]; // 图片路径
        photo.srcImageView = (UIImageView *)[self.view viewWithTag:1001]; // 来源于哪个UIImageView
        //        photo.placeholder = image;
        [photos addObject:photo];
    }
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self topicOperationShowDialog:indexPath];
}

//show出 对话题操作的 dialog
-(void)topicOperationShowDialog:(NSIndexPath *)indexPath
{
    
    
    DialogView * dialog = [DialogView  shareInstance];
    
    dialog.transform = CGAffineTransformMakeScale(1.3, 1.3);
    dialog.alpha = 0.5;
    [UIView animateWithDuration:0.3 animations:^{
        
        dialog.transform = CGAffineTransformMakeScale(1, 1);
        dialog.alpha = 1;
    }];
    __weak HotTopicDetailVC * weakSelf = self;
    dialog.block = ^(NSInteger index)
    {
        //弹出键盘
        Item_HotTopicDetail * detailItem1 = [self.dataSource1 objectAtIndex:0];
        
        Item_HotTopDetailRow * detailItem2 =  [self.dataSource2 objectAtIndex:indexPath.row];
        
        switch (index) {
            case 0:
            {
                weakSelf.topicSendType = TopicDetailReply;
                [weakSelf.importText  becomeFirstResponder];
                sendName = detailItem2.name;
                
            }
                break;
            case 1://收藏
            {
                if (indexPath.section == 0) {//枚举 区分是对楼主还是某个回帖
                    [self requestTopicStoreDataURl:TOP_1_7_1 setParam:[self setParamTopicStoreTopId:detailItem1._id topicReplyId:detailItem2._id topicStoreType:@"1" actType:@"1"]];
                }else{
                    [self requestTopicStoreDataURl:TOP_1_7_1 setParam:[self setParamTopicStoreTopId:detailItem1._id topicReplyId:detailItem2._id topicStoreType:@"2" actType:@"1"]];
                    
                    //                       [self requestTopicStoreDataURl:TOP_1_7_1 setParam:[self setParamTopicStoreTopId:@"15a445c3-64e2-4969-8933-d11ee9755034" topicReplyId:@"a2023312-a0ef-44fe-8021-32af432a08cb" topicStoreType:@"2" actType:@"1"]];
                }
            }
                break;
            case 2:
            {
                NSLog(@"复制");
                if (indexPath.section == 0) {//枚举 区分是对楼主还是某个回帖
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    pasteboard.string = detailItem1.content;
                }else{
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    pasteboard.string = detailItem2.content;
                }
                
            }
                break;
            case 3://举报
            {
                if (indexPath.section == 0) {//枚举 区分是对楼主还是某个回帖
                    self.operationType = TopicOperationAuthor;
                    weakSelf.topicSendType = TopicDetailReport;
                    weakSelf.topicID = detailItem1._id;
                    [weakSelf.importText  becomeFirstResponder];
                }else{
                    self.operationType = TopicOperationReply;
                    weakSelf.topicSendType = TopicDetailReport;
                    weakSelf.topicID = detailItem2._id;
                    [weakSelf.importText  becomeFirstResponder];
                }
                
            }
                break;
            case 4:
            {
                NSLog(@"删除");
            }
                break;
            default:
                break;
        }
    };
    
}

//屏幕出现的tableview的item的indexPath
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"----   indexpath - --- %ld---  分割    ---%ld" , indexPath.section , indexPath.row);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

//#pragma mark textviewdelegouet
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
//{
//    NSString * text = textView.text;
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}





-(void)keyboardNotification
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillShow:)
     
                                                 name:UIKeyboardWillShowNotification
     
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillHide:)
     
                                                 name:UIKeyboardWillHideNotification
     
                                               object:nil];
}

#pragma mark 开始进入刷新状态
- (void)stopRefresh
{
    [self.tableView reloadData];
    [self.tableView footerEndRefreshing];
    [self.tableView headerEndRefreshing];
}
//上拉刷新
-(void)headerRereshing{
    [self.dataSource1 removeAllObjects];
    [self.dataSource2 removeAllObjects];
    [self requestData:[self setRequestParam]];
}
//下拉加载
-(void)footerRereshing{
    [self requestTalkReplyData:[self setRequestTalkReplyParam]];
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //    NSLog(@"****");
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    //    NSLog(@"****");
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //    NSLog(@"****");
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    //    NSLog(@"****");
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //    NSLog(@"****");
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    //    NSLog(@"****");
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    //    NSLog(@"****");
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    //    NSLog(@"****");
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    //    NSLog(@"****");
    return YES;
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
