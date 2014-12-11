//
//  ActivityDetailVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#define MAN     1 //男孩
#define WOMAN   2 //女孩
#define ZAN     1 //点赞
#define CANCEL_ZAN  2//取消赞
#define COLLECT     1//收藏
#define CANCEL_COLLECT 2//取消收藏
#define MAXTAG  10000
#define dTag_tf 100
#define dTag_lbl 101
#define dTag_tv 102
#define dTag_toolView 103
#define dTag_headerAction(i) 104 + i
#import "ActivityDetailVC.h"
#import "Cell_ActivityDetail.h"
#import "Cell_AcitivityDetail2.h"
#import "UIViewController+MMDrawerController.h"
#import "UIViewController+General.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "DialogView.h"
#import "UIImage+Stretch.h"
#import "Item_AcitivtyDetail.h"
#import "UIImageView+WebCache.h"
#import "TimeTool.h"
#import "Item_ACT_RemarkList.h"
#import "UIButton+FlexSpace.h"
#import "RDRStickyKeyboardView.h"
#import "WUDemoKeyboardBuilder.h"
#import "AppDelegate.h"
#import "MyParserTool.h"//解析
@interface ActivityDetailVC ()
{
    CGRect _tableFrame;
    UITextField * aTextField;
    int pageIndex;
}
@property (nonatomic, strong) Item_AcitivtyDetail * item;

@property (nonatomic, strong) RDRStickyKeyboardView *contentWrapper;

@property (nonatomic, strong) NSIndexPath * index;//记录哪一行点击回复叫出的键盘
@property (nonatomic, assign) int newIndex;
@end

@implementation ActivityDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dataArray = [[NSMutableArray alloc]init];
        _smallArr1 = [[NSMutableArray alloc]init];
        _smallArr2 = [[NSMutableArray alloc]init];
        http = [[AFN_HttpBase alloc]init];
    }
    return self;
}

-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)replayAction
{
    NSLog(@"回复");
}
/**收藏活动**/
-(void)collectAct
{
    static BOOL isConllect = NO;
    
    isConllect = !isConllect;
    
    int  a = 0;
    if (isConllect == YES) {
        
        a = COLLECT;
    }else{
        
        a = CANCEL_COLLECT;
    }
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString *  ddid = [d objectForKey:UD_ddid];
    
    NSString * store = [NSString stringWithFormat:@"%d", a];
    
        NSDictionary * postDict = [[NSDictionary alloc]initWithObjectsAndKeys:ddid,@"D_ID", @"1", @"activityStore.type", self.activityID , @"activityStore.activity.id" , store,@"activityStore.actType", nil];
    
    NSLog(@"{postDict:%@}", postDict);
    
    [http fiveReuqestUrl:dUrl_ACT_1_6_1 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        if (a == COLLECT) {
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        }
        
        if (a == CANCEL_COLLECT) {
            [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
        }
        
        
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"收藏失败"];
        
    }];

}
//活动回复收藏
-(void)collectAcitivityWithID:(NSString *)replayId
{
    static BOOL isConllect = NO;
    
    isConllect = !isConllect;
    
    int  a = 0;
    if (isConllect == YES) {
        
        a = COLLECT;
    }else{
        
        a = CANCEL_COLLECT;
    }
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString *  ddid = [d objectForKey:UD_ddid];
    
    NSString * store = [NSString stringWithFormat:@"%d", a];
    
//    Item_ACT_RemarkList * item = [_dataArray objectAtIndex:index];
    
    NSDictionary * postDict = [[NSDictionary alloc]initWithObjectsAndKeys:ddid,@"D_ID", @"2", @"activityStore.type", self.activityID , @"activityStore.activity.id" , store,@"activityStore.actType", replayId,@"activityStore.activityReply.id", nil];
    
    NSLog(@"{postDict:%@}", postDict);
    
    [http fiveReuqestUrl:dUrl_ACT_1_6_1 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        if (a == COLLECT) {
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        }
        
        if (a == CANCEL_COLLECT) {
            [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
        }
        
        
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"收藏失败"];
        
    }];
}
/**对活动回复进行回复**/

-(void)remarkRemarkListWithString:(NSString *)content aid:(NSString *)aid
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    
    __weak ActivityDetailVC * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_ACT_1_10_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"回复成功"];
         [weakSelf.tableView headerBeginRefreshing];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"回复失败"];
        
    } andKeyValuePairs:@"D_ID", ddid, @"activityReply.content", content, @"activityReply.activity.id", aid, nil];
    
}
/**活动回复举报**/
-(void)waringWithAString:(NSString *)string andAid:(NSString *)aId
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", string, @"activityReplyReport.content", aId,@"activityReplyReport.activityReply.id", nil];
    
    [http fiveReuqestUrl:dURl_ACT_1_8_2 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
         [SVProgressHUD showSuccessWithStatus:@"举报成功"];
    } failed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showErrorWithStatus:@"举报失败"];
    }];
}
/**活动举报**/
-(void)warningWithString:(NSString *)string
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", string, @"activityReport.content", self.activityID,@"activityReport.activity.id", nil];

    
    [http fiveReuqestUrl:dUrl_ACT_1_4_1 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"举报成功"];
        
       
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"举报失败"];
    }];
}

#pragma mark - 回复列表
-(void)httpRequestWithPageIndex:(int)newPageIndex
{
    NSString * page = [NSString stringWithFormat:@"%d", newPageIndex];
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid = [d objectForKey:UD_ddid];
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", page, @"activityReplyQuery.pageNum", self.activityID ,@"activityReplyQuery.activityID", nil];
    NSLog(@"postDict:%@", postDict);
    
    __weak ActivityDetailVC * weakSelf = self;
    
    [http fiveReuqestUrl:dUrl_ACT_1_10_2 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        if (self.operation == 1) {
            
            [_dataArray removeAllObjects];
            
        }
        NSDictionary * root = (NSDictionary *)obj;
        
        self.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"]integerValue];
        
        NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
        
        for (NSDictionary * dict in list) {
            
            Item_ACT_RemarkList * item = [[Item_ACT_RemarkList alloc]init];
            item.buttonSelected = NO;
            item.content = [NSString stringWithFormat:@"%@", [dict objectForKey:@"content"]];
            item.supports = [[dict objectForKey:@"supports"]integerValue];
            NSArray * temp = [[dict objectForKey:@"author"] objectForKey:@"childInfoList"];
            NSDictionary * child = temp[0];
            item.gender = [[child objectForKey:@"gender"]integerValue];
            item.photoUrl = [NSString stringWithFormat:@"%@%@",dUrl_PhotoPrefixion, [[[dict objectForKey:@"author"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
            item.name = [NSString stringWithFormat:@"%@", [[child objectForKey:@"kindergarten"] objectForKey:@"name"]];
            item.rid = [dict objectForKey:@"id"];
            
            item.createTime = [dict objectForKey:@"createTime"];
            NSArray * array = [[dict objectForKey:@"author"] objectForKey:@"childInfoList"];
            
            item.birthday = [NSString stringWithFormat:@"%@", [array[0] objectForKey:@"birthday"]];
            NSLog(@"%@", item.birthday);
            [_dataArray addObject:item];
        }
        
        NSLog(@"%@", weakSelf.dataArray);
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView footerEndRefreshing];
        [weakSelf.tableView headerEndRefreshing];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    }];
}

//请求第一个section的数据
-(void)httpRequest
{
//    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys, @"activityQuery.activityID" ,nil];
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:self.activityID, @"activityQuery.activityID", ddid , @"D_ID",nil];
    
    [self startHttpRequestWithUrl:dUrl_ACT_1_2_6 postDict:postDict];
}
#pragma mark -
-(void)startHttpRequestWithUrl:(NSString *)url  postDict:(NSMutableDictionary *)postDict
{
    
    NSLog(@"{postDict}%@", postDict);
    
    __weak ActivityDetailVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        //移除所有内容
        [weakSelf.smallArr1 removeAllObjects];
        
        NSMutableDictionary * dict = (NSMutableDictionary *)obj;
        //活动
        NSDictionary * value = [dict objectForKey:@"value"];
        
        Item_AcitivtyDetail * item  = [[Item_AcitivtyDetail alloc]init];
        item.age = [NSString stringWithFormat:@"%@", [value objectForKey:@"age"]];
        item.createTime = [value objectForKey:@"createTime"];
        item.petName = [[value objectForKey:@"author"] objectForKey:@"petName"];
        item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, [[[value objectForKey:@"author"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
        item.content = [value objectForKey:@"content"];
        item.isOpen = [[value objectForKey:@"open"]integerValue];

        item.limitTime = [value objectForKey:@"limitTime"];
        NSArray * childInfo = [[value objectForKey:@"author"] objectForKey:@"childInfoList" ];
        item.gender = [NSString stringWithFormat:@"%@", [[childInfo firstObject] objectForKey:@"gender"]];
        item.title = [value objectForKey:@"title"];
        item.replies = [[value objectForKey:@"replies"] intValue];
        item.placeName = [NSString stringWithFormat:@"%@", [value objectForKey:@"placeName"]];
        item.supports = [[value objectForKey:@"supports"] intValue];
        NSDictionary * d = [[value objectForKey:@"author"] objectForKey:@"childInfoList"][0];
        item.birthTime = [d objectForKey:@"birthday"];
        
        if (![[value objectForKey:@"activityAttachmentList"] isKindOfClass:[NSNull class]]) {
            
            NSArray * activityAttachmentList = [value objectForKey:@"activityAttachmentList"];
            for (NSDictionary * dict in activityAttachmentList) {
                
                
                if (![[dict objectForKey:@"attachment"] isKindOfClass:[NSNull class]]) {
                    
                    if (![[[dict objectForKey:@"attachment"] objectForKey:@"relativePath"] isKindOfClass:[NSNull class]]) {
                        NSString * url = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion,[[dict objectForKey:@"attachment"] objectForKey:@"relativePath"]];
                        
                        [item.urlArray addObject:url];

                    }
                }
            }
    
        }
        

        [weakSelf.smallArr1 addObject:item];
        
        NSLog(@"%@", weakSelf.smallArr1[0]);
//        [weakSelf.tableView reloadData];
        
        pageIndex = 1;
        
        [weakSelf httpRequestWithPageIndex:pageIndex];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"活动详情";
    
    NSLog(@"activityID:%@", self.activityID);
    //    _dataArray = [[InterfaceLibrary shareInterfaceLibrary] interfaceAcitityDetail];
    
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
    }
    [self initLeftItem];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self createKeyBoard];
    //盛放textView和回复按钮
    
    [self httpRequest];
   
    
    [self setupRefresh:self.tableView];
}


-(void)footerRereshing
{
    self.operation = 2;
    
    if (self.isButtom == 1) {
        
        [self.tableView footerEndRefreshing];
        
        [SVProgressHUD showSuccessWithStatus:@"没有更多数据"];
        
        return;
    }
    
    pageIndex++;
    
    [self httpRequestWithPageIndex:pageIndex];
}
-(void)headerRereshing
{
    self.operation = 1;
    
    [_dataArray removeAllObjects];
    
    pageIndex = 1;
    
    [self httpRequest];
    
}

#pragma mark - tableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else{
        return [_dataArray count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString * strID = @"ID";
        
        Cell_ActivityDetail * cell = [tableView dequeueReusableCellWithIdentifier:strID];
        
        if (nil == cell) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"Cell_ActivityDetail" owner:self options:nil]lastObject];
        }
        
        if (_smallArr1.count == 0) {
            return cell;
        }
        
        Item_AcitivtyDetail * item = _smallArr1[indexPath.row];
        
                [cell.headerImage setImageURL:[NSURL URLWithString:item.relativePath] placeholder:nil];
                cell.pNameLabel.text = item.petName;
                cell.contentLabel.text = item.title;
        
        NSMutableString * str = [TimeTool getBabyAgeWithBirthday:item.birthTime publicTime:item.createTime];
        
        if ([item.gender isEqualToString:@"1"]) {
            
            cell.cNameLabel.text = [NSString stringWithFormat:@"王子：%@", str];
            cell.cNameLabel.textColor = [UIColor blueColor];
            
        }else{
            
             cell.cNameLabel.text = [NSString stringWithFormat:@"公主：%@", str];
            cell.cNameLabel.textColor = [UIColor redColor];
        }
    
        CGRect frame = cell.detailLabel.frame;
        MyParserTool * parser = [MyParserTool shareInstance];
        CGSize size = [parser sizeWithRawString:item.content constrainsToWidth:frame.size.width Font:[UIFont systemFontOfSize:13]];
        frame.size = size;
        cell.detailLabel.frame = frame;
        cell.detailLabel.text = item.content;

        cell.locationBtn.titleLabel.text = item.placeName;
        [cell.praiseBtn setTitle:[NSString stringWithFormat:@"%d", item.supports] forState:UIControlStateNormal];
        
        
        if ( [TimeTool limitTime:item.limitTime] && item.isOpen) {
            
            cell.stateLabel.text = @"活动进行中";
            cell.stateLabel.textColor = [UIColor blueColor];
        }else{
            cell.stateLabel.text = @"活动已关闭";
            cell.stateLabel.textColor = [UIColor blueColor];
        }
        cell.upTImeLabel.text  =[TimeTool getUTCFormateDate:item.createTime];

        NSArray * imgArr = @[cell.imageView1, cell.imageView2, cell.imageView3, cell.imageView4,cell.imageView5, cell.imageView6, cell.imageView7, cell.imageView8, cell.imageView9];
        
        int i = 0;
        for (NSString * url in item.urlArray) {
            
            UIImageView * iv = imgArr[i];
            
            NSURL * newUrl = [NSURL URLWithString:url];
            
            [iv setImageWithURL:newUrl placeholderImage:[UIImage imageNamed:@"saga2.jpg"]];
            i++;
        }
        
        
        for (int j = 0; j < 9; i++) {
            
            UIImageView * iv = imgArr[j];
            
            if (j >= i) {
                
                iv.hidden = YES;
            }
        }
        
        //计算有几行
        int number = i  / 3;
        
        if (i % 3 != 0) {
            
            number++;
        }
        
        frame = cell.imgContentView.frame;
        frame.size.height = number / 3 * frame.size.height;
        cell.imgContentView.frame = frame;
        
        cell.praiseBtn.frame = frame;
        [cell.praiseBtn setLayout:OTSImageLeftTitleRightStyle spacing:5];
        [cell.praiseBtn setImage:[UIImage imageNamed:@"good_n"] forState:UIControlStateNormal];
        [cell.praiseBtn setImage:[UIImage imageNamed:@"good_d"] forState:UIControlStateSelected];
        [cell.praiseBtn addTarget:self action:@selector(praiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.discussLabel addTarget:self action:@selector(discussBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.discussLabel setTitle:[NSString stringWithFormat:@"%d", item.replies] forState:UIControlStateNormal];
        [cell.discussLabel setLayout:OTSImageLeftTitleRightStyle spacing:5];
        
        return cell;
    }else{
        static NSString * strID = @"ID2";
        
        Cell_AcitivityDetail2 * cell = [tableView dequeueReusableCellWithIdentifier:strID];
        
        if (nil == cell) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"Cell_AcitivityDetail2" owner:self options:nil]lastObject];
        }
        
        Item_ACT_RemarkList * item = _dataArray[indexPath.row];
        cell.contentLabel.text = item.content;
        cell.pNameLabel.text = item.petName;
        cell.cNameLabel.text = item.name;
        
        NSLog(@"photoUrl:%@", item.photoUrl);
        [cell.headerImageView setImageURLStr:item.photoUrl placeholder:[UIImage imageNamed:@"saga2.jpg"]];
        
        NSMutableString * age = [TimeTool getBabyAgeWithBirthday:item.birthday publicTime:item.createTime];
        if (item.gender == 2) {
            
            cell.cNameLabel.textColor = [UIColor redColor];
            cell.cNameLabel.text = [NSString stringWithFormat:@"公主/%@",age];
        }
        if (item.gender == 1) {
            
            cell.cNameLabel.textColor = [UIColor blueColor];
            cell.cNameLabel.text = [NSString stringWithFormat:@"王子/%@",age];
        }
        
        NSString * zanCount = [NSString stringWithFormat:@"%d", item.supports];
        
        [cell.zanBtn setTitle:zanCount forState:UIControlStateNormal];
        [cell.zanBtn addTarget:self action:@selector(praiseBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
        
        if (item.buttonSelected == NO) {
            [cell.zanBtn setImage:[UIImage imageNamed:@"good_n"] forState:UIControlStateNormal];
            [cell.zanBtn setLayout:OTSImageLeftTitleRightStyle spacing:5];
        }else{
            [cell.zanBtn setImage:[UIImage imageNamed:@"good_d"] forState:UIControlStateNormal];
            [cell.zanBtn setLayout:OTSImageLeftTitleRightStyle spacing:5];
        }
        
        cell.zanBtn.tag = MAXTAG + indexPath.row;
        return cell;
    }
}
-(void)headerViewAction:(UIButton *)btn
{
    NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:btn.tag - 104];
    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:    UITableViewScrollPositionTop animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray * name = @[@"发起人",@"回应"];
    
    UIView * mainView = [[UIView alloc]init];
    mainView.frame = CGRectMake(0, 0, kMainScreenWidth, 30);
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:[name objectAtIndex:section] forState:UIControlStateNormal];
    button.tag = dTag_headerAction(section);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(headerViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage resizedImage:@"活动详情--发起人.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 80, 30);
    [mainView addSubview:button];
    
    return mainView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(void)tes
{
    DialogView * dialog = [DialogView  shareInstance];
    
    dialog.transform = CGAffineTransformMakeScale(1.3, 1.3);
    dialog.alpha = 0.5;
    [UIView animateWithDuration:0.3 animations:^{
        
        dialog.transform = CGAffineTransformMakeScale(1, 1);
        dialog.alpha = 1;
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        DialogView * dialog = [DialogView  shareInstance];
        
        NSLog(@"%@", dialog);
        
        dialog.transform = CGAffineTransformMakeScale(1.3, 1.3);
        dialog.alpha = 0.5;
        [UIView animateWithDuration:0.3 animations:^{
            
            dialog.transform = CGAffineTransformMakeScale(1, 1);
            dialog.alpha = 1;
        }];
        
        __weak ActivityDetailVC * weakSelf = self;
        dialog.block = ^(NSInteger index)
        {
            switch (index) {
                case 0:
                {
                    NSLog(@"对活动进行回复");
   
                    [weakSelf.contentWrapper showKeyboard];
                    
                    self.index = indexPath;
                    self.newIndex = 0;
                    
                }
                    break;
                case 1:
                {
                    [self collectAct];
                }
                    break;
                case 2:
                {
                    NSLog(@"复制");
                     Item_AcitivtyDetail * item = _smallArr1[indexPath.row];
            
                    
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    pasteboard.string = item.content;
                    
                    
                }
                    break;
                case 3:
                {
                    [weakSelf.contentWrapper showKeyboard];
                    
                    self.index = indexPath;
                    self.newIndex = 3;
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

        
        return;
    }
    DialogView * dialog = [DialogView  shareInstance];
    
    NSLog(@"%@", dialog);
    
    dialog.transform = CGAffineTransformMakeScale(1.3, 1.3);
    dialog.alpha = 0.5;
    [UIView animateWithDuration:0.3 animations:^{
        
        dialog.transform = CGAffineTransformMakeScale(1, 1);
        dialog.alpha = 1;
    }];
    
    __weak ActivityDetailVC * weakSelf = self;
    dialog.block = ^(NSInteger index)
    {
        switch (index) {
            case 0:
            {
                NSLog(@"回复");
                //弹出键盘
                [weakSelf.contentWrapper showKeyboard];
                
                self.index = indexPath;
                self.newIndex= 0;
                

            }
                break;
            case 1:
            {
                NSLog(@"收藏");
                
                
                Item_ACT_RemarkList * item = _dataArray[indexPath.row];
                
                [weakSelf collectAcitivityWithID:item.rid ];
            }
                break;
            case 2:
            {
                NSLog(@"复制");
                
                Item_ACT_RemarkList * item = _dataArray[indexPath.row];
                
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = item.content;
                
                
            }
                break;
            case 3:
            {
                [weakSelf.contentWrapper showKeyboard];
                
                self.index = indexPath;
                self.newIndex = 3;
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
#pragma mark --暂时这么写,等有键盘了再把它替换掉

-(void)sendText:(NSString *)string type:(int)pageType index:(int)index
{
    if (pageType == 1) {
        
        NSLog(@"对回复举报");
        
        Item_ACT_RemarkList * item = _dataArray[index];
        
        [self waringWithAString:string andAid:item.rid];
    }
    if (pageType == 2) {
        //对回复回复
        [self remarkRemarkListWithString:string aid:self.activityID];
    }
    if (pageType == 3) {
        
        //对活动回复
        [self remarkRemarkListWithString:string aid:self.activityID];
     
    }
    if (pageType == 4) {
        
        //对活动举报
        [self warningWithString:string];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 460;
    }
    return 135;
}

#pragma mark  对发起人的内容进行评论
-(void)discussBtnClick{
    
}

#pragma mark  对活动内容点赞
-(void)praiseBtnClick:(UIButton *)sender{
    /**
     *  赞：改变sender的selected的属性为YES
     *  取消赞：改变sender的selected的属性为NO
     *  刷新该行
     */
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
     Item_AcitivtyDetail * item = _smallArr1[0];
    
    int a = 0;
    if (sender.selected == YES) {
        
        a = 2;
        
        item.supports--;
        
        NSString * str = [NSString stringWithFormat:@"%d", item.supports];
        [sender setTitle:str forState:UIControlStateNormal];
    
    }
    if (sender.isSelected == NO) {
        
        item.supports++;
        
        a = 1;
        
        NSString * str = [NSString stringWithFormat:@"%d", item.supports];
        [sender setTitle:str forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
    
    NSString * type = [NSString stringWithFormat:@"%d", a];
    
    [http thirdRequestWithUrl:dUrl_ACT_1_5_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        if ( a == 1) {
            [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
        }
        if (a == 2) {
             [SVProgressHUD showSuccessWithStatus:@"取消成功"];
        }
       
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"点赞失败"];
        
    } andKeyValuePairs:@"D_ID", ddid , @"activitySupport.activity.id", self.activityID, @"activitySupport.actType", type, nil];
}

#pragma mark  对回应内容点赞
-(void)praiseBtnClick1:(UIButton *)sender{
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    int a;
 
    NSString * type = [NSString stringWithFormat:@"%d", a];
    
    Item_ACT_RemarkList * item = [_dataArray objectAtIndex:sender.tag - MAXTAG];
     item.buttonSelected = !item.buttonSelected;
    if (item.buttonSelected == YES) {
        
        a = 1;
    }else{
        a = 2;
    }
    
    __weak ActivityDetailVC * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_ACT_1_8_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        if (a == 1) {
            
            item.supports++;
            [weakSelf.tableView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
        }
        if (a == 2) {
            item.supports--;
            [weakSelf.tableView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
        }
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"失败"];
        
    } andKeyValuePairs:@"D_ID", ddid, @"activityReplySupport.activityReply.id", item.rid, @"activityReplySupport.acttype", type , nil];
}

#pragma mark -集成微信键盘

-(void)createKeyBoard
{
    self.contentWrapper = [[RDRStickyKeyboardView alloc]initWithScrollView:self.tableView];
    self.contentWrapper.frame = self.view.bounds;
    self.contentWrapper.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.contentWrapper.placeholder = @"Message";
    [self.contentWrapper.inputView.rightButton addTarget:self action:@selector(didTapSend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.contentWrapper];
    
    [self.contentWrapper.inputView.leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 左边button点击
-(void)leftBtnClick
{
    
    if (self.contentWrapper.inputView.textView.isFirstResponder) {
        
        if (self.contentWrapper.inputView.textView.emoticonsKeyboard != nil) {
            [self.contentWrapper.inputView.textView switchToDefaultKeyboard];
            
        }else{
            [self.contentWrapper.inputView.textView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
        }
    }else{
        
        [self.contentWrapper.inputView.textView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
        [self.contentWrapper.inputView.textView becomeFirstResponder];
        
    }
}
#pragma mark - 右边button点击
- (void)didTapSend:(id)sender
{

    //对活动进行回复
    if (self.index.section == 0) {
        
        if (self.newIndex == 0) {
            [self remarkRemarkListWithString:self.contentWrapper.inputView.textView.text aid:self.activityID];
        }
        if (self.newIndex == 3) {
            ////活动举报
            [self warningWithString:self.contentWrapper.inputView.textView.text];
        }
        
    }else{
        
        if (self.newIndex == 0) {
            //对活动回复进行回复
            [self remarkRemarkListWithString:self.contentWrapper.inputView.textView.text aid:self.activityID];
        }
        if (self.newIndex == 3) {
            
            Item_ACT_RemarkList * item = _dataArray[self.index.row];
            
            [self waringWithAString:self.contentWrapper.inputView.textView.text andAid:item.rid];
        }
       
    }
    
    self.contentWrapper.inputView.textView.text = @" ";
    CGRect frame = self.contentWrapper.inputView.textView.frame;
    frame.size.height = 40;
    self.contentWrapper.inputView.textView.frame = frame;
    [self.contentWrapper hideKeyboard];
    
    [self.contentWrapper.inputView.textView switchToDefaultKeyboard];
    NSLog(@"%@", self.contentWrapper.inputView.textView.text);
}
-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = NO;
}
@end
