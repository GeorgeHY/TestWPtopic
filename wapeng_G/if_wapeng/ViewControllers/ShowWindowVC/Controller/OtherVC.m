//
//  OtherVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-17.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define PARENT  1
#define TEACHER 2
#define AGENT   3

#define MAN     1
#define WOMAN   2

#define ZAN     1
#define CANCLEZAN 2

#define MAX_TAG 1000
#define MAX_TAG_2 10000
#define MAX_TAG_3 20000
#define MAX_TAG_4 30000 //rtlabel的max
#define MAX_TAG_5 40000
#define DTAG_TABLEHEADER 100
#import "OtherVC.h"
#import "UIViewController+MMDrawerController.h"
#import "UIViewController+General.h"
#import "PublisWindowVC.h"
#import "Cell_MyWindow.h"
#import "Cell_Show.h"
#import "MyParserTool.h"
#import "RichLabelView.h"
#import "UIButton+FlexSpace.h"
#import "Cell_RemarkList.h"
#import "Item_RemarkList.h"
#import "StringTool.h"
#import "Item_MyWindow.h"
#import "TimeTool.h"
#import "UIImageView+WebCache.h"
#import "MyParserTool.h"
#import "RTLabel.h"
#import "NSString+URLEncoding.h"
#import "Item_zanList.h"
#import "Item_RemarkList.h"
#import "TTTAttributedLabel.h"
#import "Cell_ShowRemark.h"
#import "RDRStickyKeyboardView.h"
#import "WUDemoKeyboardBuilder.h"
#import "MyDatumVC.h"
#import "DataItem.h"
#import "WindowHeaderView.h"//头部视图
#import "MyAgentShowWindowView.h"//头部视图
#import "OtherPersonHeaderView.h"
#import "AgentShowWinowView.h"
#import "Item_userInfo.h"
#import "FocusVC.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "UIView+WhenTappedBlocks.h"
@interface OtherVC ()<TTTAttributedLabelDelegate>
{
    AFN_HttpBase * http;
    int pageIndex;
    BOOL isWorking1;//是否正在请求 点赞接口是否正在请求
    BOOL isWorking2;//评论列表接口是否正在请求
}
@property (nonatomic, assign) NSInteger isButtom;//是否有下一页
@property (nonatomic, assign) BOOL  isRefresh;//是否是下拉刷新操作
@property (nonatomic, strong) RDRStickyKeyboardView *contentWrapper;
@property (nonatomic, strong) DataItem * item;
@property (nonatomic, strong) MyDatumVC * myDatumVC;

@property (nonatomic, strong) NSString * petName;

@property (nonatomic, strong) Item_userInfo * item_userInfo;
@end

@implementation OtherVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        http = [[AFN_HttpBase alloc]init];
        _dataArray = [[NSMutableArray alloc]init];
        _momentDict = [[NSMutableDictionary alloc]init];
        _zanDict = [[NSMutableDictionary alloc]init];
        self.myDatumVC = [[MyDatumVC alloc]init];
        self.item = [[DataItem alloc]init];
        _item_userInfo = [[Item_userInfo alloc]init];
    }
    return self;
}


#pragma mark - 教师用户的头部视图请求

-(void)teacherUserHeaderWithRequestWithID:(NSString *)teachID
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    __weak OtherVC * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_DIA_1_6_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * dict = (NSDictionary *)obj;
        
        NSDictionary * tempDict = [dict objectForKey:@"value"];
        
        _item_userInfo.name =  [tempDict objectForKey:@"name"];
        
        //橱窗数
        _item_userInfo.momentCount = [[tempDict objectForKey:@"momentCount"]intValue];
        
        //粉丝数
        _item_userInfo.fansCount = [[[tempDict objectForKey:@"userInfo"] objectForKey:@"fansCount"]intValue];
        
        //关注数
        _item_userInfo.attentionsCount = [[[tempDict objectForKey:@"userInfo"] objectForKey:@"attentionsCount"] integerValue];
        NSDictionary * userInfoDict = [tempDict objectForKey:@"userInfo"];
        
        _item_userInfo.petName = [NSString stringWithFormat:@"%@", [userInfoDict objectForKey:@"petName"]];
        
        _item_userInfo.photoUrl = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion,[userInfoDict objectForKey:@"photoURL"]];
        
        NSLog(@"photoUrl:%@", _item_userInfo.photoUrl);
        
        _item_userInfo.loacted = [[[userInfoDict objectForKey:@"organization"] objectForKey:@"organizationExtension"] objectForKey:@"bizAddress"];
        
        _item_userInfo.personnelSignature = [[[userInfoDict objectForKey:@"organization"] objectForKey:@"organizationExtension"] objectForKey:@"description"];
        
        _item_userInfo.wpCode = [NSString stringWithFormat:@"%@", [userInfoDict objectForKey:@"wpCode"]];
        
        ;
        AgentShowWinowView * view = (AgentShowWinowView *)[weakSelf.view viewWithTag:DTAG_TABLEHEADER];
        
//        view.agentTotalNameLbl.hidden = YES;
        
        NSURL * url = [NSURL URLWithString:_item_userInfo.photoUrl];
        [view.headerIV setImageWithURL:url placeholderImage:[UIImage imageNamed:@"saga2.jpg"]];
        view.nickLbl.text = _item_userInfo.petName;
        
        view.locationLbl.text = [NSString stringWithFormat:@"任职机构:%@", _item_userInfo.loacted];
        view.wpCodeLbl.text = [NSString stringWithFormat:@"比邻号:%@",_item_userInfo.wpCode];
        
        view.momentCountLbl.text = [NSString stringWithFormat:@"%d", _item_userInfo.momentCount];
        view.fansLbl.text = [NSString stringWithFormat:@"%d", _item_userInfo.fansCount];
        view.focusCountLbl.text = [NSString stringWithFormat:@"%d", _item_userInfo.attentionsCount];
        //个性签名
        view.emotionLbl.text = [NSString stringWithFormat:@"%@", _item_userInfo.personnelSignature];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID", ddid, @"windowQuery.userInfoID", teachID, nil];
}

#pragma mark - 机构用户的头视图请求
-(void)agentUserHeaderWithReqeustWithID:(NSString *)agentID
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    __weak OtherVC * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_DIA_1_6_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * dict = (NSDictionary *)obj;
        
        NSDictionary * tempDict = [dict objectForKey:@"value"];
        
        _item_userInfo.name =  [tempDict objectForKey:@"name"];
        
        //橱窗数
        _item_userInfo.momentCount = [[tempDict objectForKey:@"momentCount"]intValue];
        
        //粉丝数
        _item_userInfo.fansCount = [[[tempDict objectForKey:@"userInfo"] objectForKey:@"fansCount"]intValue];
        
        //关注数
        _item_userInfo.attentionsCount = [[[tempDict objectForKey:@"userInfo"] objectForKey:@"attentionsCount"] integerValue];
        NSDictionary * userInfoDict = [tempDict objectForKey:@"userInfo"];
        
        _item_userInfo.petName = [NSString stringWithFormat:@"%@", [userInfoDict objectForKey:@"petName"]];
        
        _item_userInfo.photoUrl = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion,[userInfoDict objectForKey:@"photoURL"]];
        
        
        _item_userInfo.loacted = @"";
        if (isNotNull([userInfoDict objectForKey:@"organizationExtension"])) {
            if (isNotNull([[userInfoDict objectForKey:@"organizationExtension"] objectForKey:@"bizAddress"])) {
                 _item_userInfo.loacted = [[userInfoDict objectForKey:@"organizationExtension"] objectForKey:@"bizAddress"];
            }
        }
        
        _item_userInfo.wpCode = [NSString stringWithFormat:@"%@", [userInfoDict objectForKey:@"wpCode"]];
        
        _item_userInfo.personnelSignature = @"";
        if (isNotNull([userInfoDict objectForKey:@"organizationExtension"])) {
            if (isNotNull([[userInfoDict objectForKey:@"organizationExtension"] objectForKey:@"description"])) {
                 _item_userInfo.personnelSignature = [[userInfoDict objectForKey:@"organizationExtension"] objectForKey:@"description"];
            }
        }
       
        AgentShowWinowView * view = (AgentShowWinowView *)[weakSelf.view viewWithTag:DTAG_TABLEHEADER];
        
        NSURL * url = [NSURL URLWithString:_item_userInfo.photoUrl];
        [view.headerIV setImageWithURL:url placeholderImage:[UIImage imageNamed:@"saga2.jpg"]];
        view.nickLbl.text = _item_userInfo.petName;
        
        view.locationLbl.text = [NSString stringWithFormat:@"任职机构:%@", _item_userInfo.loacted];
        view.wpCodeLbl.text = [NSString stringWithFormat:@"比邻号:%@",_item_userInfo.wpCode];
        
        view.momentCountLbl.text = [NSString stringWithFormat:@"%d", _item_userInfo.momentCount];
        view.fansLbl.text = [NSString stringWithFormat:@"%d", _item_userInfo.fansCount];
        view.focusCountLbl.text = [NSString stringWithFormat:@"%d", _item_userInfo.attentionsCount];
        //个性签名
        view.emotionLbl.text = [NSString stringWithFormat:@"%@", _item_userInfo.personnelSignature];
        
        [view.sendPrivateMSgBtn addTarget:self action:@selector(sendMsgClick) forControlEvents:UIControlEventTouchUpInside];
        
        [view.alreadyFoucsBtn addTarget:self action:@selector(focusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID", ddid, @"windowQuery.userInfoID", agentID, nil];
}

#pragma mark - 家长用户的头部视图
-(void)startWindowTitleRequestWithUserID:(NSString *)userID
{
    
    //    _item_userInfo.item_userInfo = [[Item_userInfo alloc]init];
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    __weak OtherVC * weakSelf = self;
    
    [http thirdRequestWithUrl:dUrl_DIA_1_6_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * dict = (NSDictionary *)obj;
        
        NSDictionary * tempDict = [dict objectForKey:@"value"];
        
        _item_userInfo.name =  [tempDict objectForKey:@"name"];
        
        //橱窗数
        _item_userInfo.momentCount = [[tempDict objectForKey:@"momentCount"]intValue];
        
        //粉丝数
        _item_userInfo.fansCount = [[[tempDict objectForKey:@"userInfo"] objectForKey:@"fansCount"]intValue];
        
        //关注数
        _item_userInfo.attentionsCount = [[[tempDict objectForKey:@"userInfo"] objectForKey:@"attentionsCount"] integerValue];
        NSDictionary * userInfoDict = [tempDict objectForKey:@"userInfo"];
        
        _item_userInfo.petName = [NSString stringWithFormat:@"%@", [userInfoDict objectForKey:@"petName"]];
        
        _item_userInfo.photoUrl = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion,[userInfoDict objectForKey:@"photoURL"]];
        
        _item_userInfo.loacted = @"";
        if (![[userInfoDict objectForKey:@"userInfoExtension"] isKindOfClass:[NSNull class]]) {
            
            if (![[[userInfoDict objectForKey:@"userInfoExtension"] objectForKey:@"located"] isKindOfClass:[NSNull class]]) {
               _item_userInfo.loacted = [[userInfoDict objectForKey:@"userInfoExtension"] objectForKey:@"located"];
            }
        }
         NSLog(@"photoUrl:%@", _item_userInfo.photoUrl);
        _item_userInfo.wpCode = [NSString stringWithFormat:@"%@", [userInfoDict objectForKey:@"wpCode"]];
//        NSArray * arr = [[tempDict objectForKey:@"userInfo"] objectForKey:@"childInfoList"];
        _item_userInfo.birthday = [[[tempDict objectForKey:@"userinfo"] objectForKey:@"userInfoExtension"] objectForKey:@"birthday"];
        _item_userInfo.createTime = [[tempDict objectForKey:@"userInfo"] objectForKey:@"createTime"];//创建时间
//        _item_userInfo.gender = [[[tempDict objectForKey:@"userinfo"] objectForKey:@"userInfoExtension"] objectForKey:@"gender"];
        
        //        _item_userInfo.viewAttentionStatus =
        OtherPersonHeaderView * view = (OtherPersonHeaderView *)[weakSelf.view viewWithTag:DTAG_TABLEHEADER];
        
        NSURL * url = [NSURL URLWithString:_item_userInfo.photoUrl];
        [view.headerIV setImageWithURL:url placeholderImage:[UIImage imageNamed:@"saga2.jpg"]];
        view.nickLbl.text = _item_userInfo.petName;
        
        switch (_item_userInfo.gender) {
            case MAN:
            {
                [view.gender setImage:[UIImage imageNamed:@"boy-notselected30"] forState:UIControlStateNormal];
            }
                break;
            case WOMAN:
            {
                [view.gender setImage:[UIImage imageNamed:@"girl-notselected30"] forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
        
//        NSString * now = [TimeTool getTimeWithDate:[NSDate date]];
        view.ageLbl.text = [TimeTool getBabyAgeWithBirthday:_item_userInfo.birthday publicTime:_item_userInfo.createTime];
        view.locationLbl.text = _item_userInfo.loacted;
        view.wpCodeLbl.text = [NSString stringWithFormat:@"比邻号:%@",_item_userInfo.wpCode];
        
        view.momentCountLbl.text = [NSString stringWithFormat:@"%d", _item_userInfo.momentCount];
        view.fansLbl.text = [NSString stringWithFormat:@"%d", _item_userInfo.fansCount];
        view.focusCountLbl.text = [NSString stringWithFormat:@"%d", _item_userInfo.attentionsCount];
        //个性签名
        view.emotionLbl.text = [NSString stringWithFormat:@"个性签名:%@", _item_userInfo.personnelSignature];
        
        [view.sendPrivateMSgBtn addTarget:self action:@selector(sendMsgClick) forControlEvents:UIControlEventTouchUpInside];
        
        [view.alreadyFoucsBtn addTarget:self action:@selector(focusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID", ddid, @"windowQuery.userInfoID", userID, nil];
    
}


#pragma mark - 评论之后刷新列表，由于接口结构问题，所以只能这么写
-(void)singleRemarkRequestWithUrl:(NSString *)url index:(int)index
{
    Item_MyWindow * item = _dataArray[index];
    
    NSString * momentID = item.momentID;
    
    NSInteger mPageIndex = item.remakCount;
    
    if (_momentDict.count % 10 == 0 && _momentDict.count!= 0) {
        
        item.remakCount++;
    }
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSString * newPage = [NSString stringWithFormat:@"%ld", mPageIndex];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", momentID, @"momentReplyQuery.momentID", newPage, @"momentReplyQuery.pageNum", nil];
    
    __weak OtherVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"瞬间回复列表请求成功"];
        
        NSDictionary * root = (NSDictionary *)obj;
        
        NSMutableArray * temp = [[NSMutableArray alloc]init];
        
        
        if ([[root objectForKey:@"value"] isKindOfClass:[NSNull class]] || [[root objectForKey:[[root objectForKey:@"value"] objectForKey:@"list"]] isKindOfClass:[NSNull class]]) {
            
            
        }else{
            
            NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
            
            //只把最后一条数据放到数组中
            NSDictionary * dict = list[0];
            
            Item_RemarkList * item = [[Item_RemarkList alloc]init];
            item.petName = [[dict objectForKey:@"author"] objectForKey:@"petName"];
            item.content = [dict objectForKey:@"content"];
            item.createTime = [dict objectForKey:@"createTime"];
    
            //有点不合理 暂用
            item.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"] intValue];
            
            item.userType = [[[[dict objectForKey:@"author"] objectForKey:@"userType"] objectForKey:@"id"]intValue];
            
            item.mid = [[dict objectForKey:@"author"] objectForKey:@"id"];
            
            [temp addObject:item];
            
        
        }
        
        
        
        NSArray * keys = [weakSelf.momentDict allKeys];
        
        for (NSString * key in keys) {
            
            //判断有没有momentID的Array
            if ([key isEqualToString:momentID]) {
                
                //                [temp addObjectsFromArray:[weakSelf.momentDict objectForKey:momentID]];
                
                [[weakSelf.momentDict objectForKey:momentID] addObjectsFromArray:temp];
            }
        }
        
        //用momentID当做key
        [weakSelf.momentDict setObject:temp forKey:momentID];
        
        
        [weakSelf.tableView reloadData];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        
        [SVProgressHUD showErrorWithStatus:@"瞬间回复列表请求失败"];
    }];
    
}

#pragma mark - 评论成功

/**评论**/
-(void)remarkBtnClick2:(UIButton *)btn
{
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    Item_MyWindow * item = [_dataArray objectAtIndex:btn.tag - MAX_TAG];
    
    __weak OtherVC * weakSelf = self;
    
    
    NSString * time = [TimeTool getTimeWithDate:[NSDate date]];
    
    [http thirdRequestWithUrl:dUrl_DIA_1_4_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"评论成功"];
        
        //评论成功之后让电话那加1
        Item_MyWindow * item = [_dataArray objectAtIndex:btn.tag - MAX_TAG];
        item.replies++;
        
        [weakSelf.momentDict removeObjectForKey:item.momentID];
        
        item.remakCount = 1;
        
        [weakSelf.momentDict removeObjectForKey:item.momentID];
        //
        //        [weakSelf mReplayRequestWithUrl:dUrl_DIA_1_4_2 momentID:item.momentID PageIndex:item.remakCount];
//        [weakSelf singleRemarkRequestWithUrl:dUrl_DIA_1_4_2 index:btn.tag - MAX_TAG];
        
//        Item_RemarkList * item_remark = [weakSelf.momentDict objectForKey:item.momentID];
        
        [weakSelf mReplayRequestWithUrl:dUrl_DIA_1_4_2 momentID:item.momentID PageIndex:item.remakCount];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"评论失败"];
        
    } andKeyValuePairs:@"D_ID", ddid, @"momentReply.content", time, @"momentReply.moment.id", item.momentID,@"momentReplyQuery.pageNum", @"1", nil];
}

#pragma mark - 瞬间举报
/**举报**/
-(void)warnBtnClick:(UIButton *)btn
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    Item_MyWindow * item = [_dataArray objectAtIndex:btn.tag - MAX_TAG];
    
    [http thirdRequestWithUrl:dUrl_DIA_1_2_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"举报成功"];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"D_ID", ddid, @"momentReport.content", @"因为键盘原因呢，举报理由先写死", @"momentReport.moment.id", item.momentID, nil];
}

#pragma mark - 瞬间点赞
/**点赞**/

-(void)zanBtnClick:(UIButton *)btn
{
    static int count = 0;
    
    count++;
    
    int type = 0;
    
    if (count % 2 == 0) {
        //取消赞
        type = CANCLEZAN;
    }else{
        //点赞
        type = ZAN;
    }
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    Item_MyWindow * item = [_dataArray objectAtIndex:btn.tag - MAX_TAG];
    
    __weak OtherVC * weakSelf = self;
    
    
    __weak UIButton * weakBtn = btn;
    
    [http thirdRequestWithUrl:dUrl_DIA_1_3_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        if (type == ZAN) {
            [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
            [weakBtn setTitle:@"已赞" forState:UIControlStateNormal];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
            [weakBtn setTitle:@"赞" forState:UIControlStateNormal];
        }
        [weakSelf mHttpRequestWithUrl:dUrl_DIA_1_3_2 momentID:item.momentID];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        if (type == ZAN) {
            [SVProgressHUD showErrorWithStatus:@"点赞失败"];
            item.supports++;
        }else{
            [SVProgressHUD showErrorWithStatus:@"取消赞失败"];
            item.supports--;
        }
        
    } andKeyValuePairs:@"D_ID", ddid, @"momentSupport.moment.id", item.momentID, @"momentSupport.actType", [NSString stringWithFormat:@"%d", type], nil];
}
#pragma mark - 瞬间回复列表

-(void)mReplayRequestWithUrl:(NSString *)url momentID:(NSString *)momentID PageIndex:(int)mPageIndex
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSString * newPage = [NSString stringWithFormat:@"%d", mPageIndex];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", momentID, @"momentReplyQuery.momentID", newPage, @"momentReplyQuery.pageNum", nil];
    
    isWorking2 = YES;
    
    __weak OtherVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"瞬间回复列表请求成功"];
        
        NSDictionary * root = (NSDictionary *)obj;
        
        NSMutableArray * temp = [[NSMutableArray alloc]init];
        
        
        if ([[root objectForKey:@"value"] isKindOfClass:[NSNull class]] || [[root objectForKey:[[root objectForKey:@"value"] objectForKey:@"list"]] isKindOfClass:[NSNull class]]) {
            
            
        }else{
            
            NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
            
            for (NSDictionary * dict in list) {
                
                Item_RemarkList * item = [[Item_RemarkList alloc]init];
                item.petName = [[dict objectForKey:@"author"] objectForKey:@"petName"];
                item.content = [dict objectForKey:@"content"];
                
                //有点不合理 暂用
                item.isButtom = [[[root objectForKey:@"value"] objectForKey:@"isButtom"] intValue];
                
                item.userType = [[[[dict objectForKey:@"author"] objectForKey:@"userType"] objectForKey:@"id"]intValue];
                
                item.mid = [[dict objectForKey:@"author"] objectForKey:@"id"];
                
                //实际有多少条记录
                item.recordCount = [[[root objectForKey:@"value"] objectForKey:@"recordCount"]intValue];
                [temp addObject:item];
            }
            
            
            NSLog(@"temp:%@", temp);
        }
        
//        Item_RemarkList * ite = [temp lastObject];
        
        //多余的数据
//        int delta = ite.recordCount % 10;
        
        //为了点击加载提供的方法
        NSArray * keys = [weakSelf.momentDict allKeys];

        for (NSString * key in keys) {
            
            //判断有没有momentID的Array
            if ([key isEqualToString:momentID]) {
                
//                NSMutableArray * arr = [weakSelf.momentDict objectForKey:momentID];
                
//                [arr removeObjectAtIndex:((mPageIndex - 1) * 10 + (delta - 1))];
    
                [[weakSelf.momentDict objectForKey:momentID] addObjectsFromArray:temp];
            }
        }
        
        NSLog(@"arr:%@", [weakSelf.momentDict objectForKey:momentID]);
        
        //用momentID当做key
        
        if (![[weakSelf.momentDict objectForKey:momentID] isKindOfClass:[NSNull class]] && [weakSelf.momentDict objectForKey:momentID] != nil) {
            [weakSelf.momentDict setObject:[weakSelf.momentDict objectForKey:momentID] forKey:momentID];
        }else{
            [weakSelf.momentDict setObject:temp forKey:momentID];
        }
        
        isWorking2 = NO;
        
        if (isWorking1 == NO && isWorking2 == NO) {
            
            [weakSelf.tableView reloadData];
        }
        
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        isWorking2 = NO;
        [SVProgressHUD showErrorWithStatus:@"瞬间回复列表请求失败"];
    }];
}

#pragma mark - 获取点赞列表

-(void)mHttpRequestWithUrl:(NSString *)url momentID:(NSString *)momentID
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", @"1" ,@"momentSupportQuery.pageNum", momentID, @"momentSupportQuery.momentID",nil];
    
    isWorking1 = YES;
    
    __weak OtherVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSimpleText:@"请求成功"];
        
        NSDictionary * root = (NSDictionary *)obj;
        
        NSMutableArray * temp = [[NSMutableArray alloc]init];
        
        
        if ([[root objectForKey:@"value"] isKindOfClass:[NSNull class]]) {
            
            isWorking1 = NO;
            
        }else{
            
            NSArray * list = [[root objectForKey:@"value"] objectForKey:@"list"];
            
            for (NSDictionary * dict in list) {
                
                Item_zanList * item = [[Item_zanList alloc]init];
                item.mid = [[dict objectForKey:@"userInfo"] objectForKey:@"id"];
                item.petName = [[dict objectForKey:@"userInfo"] objectForKey:@"petName"];
                item.userType = [[[[dict objectForKey:@"userInfo"] objectForKey:@"userType"] objectForKey:@"id"]intValue];
                [temp addObject:item];
            }
            
            isWorking1 = NO;
            
        }
        [weakSelf.zanDict setObject:temp forKey:momentID];
        
        if (isWorking1 == NO && isWorking2 == NO) {
            
            [weakSelf.tableView reloadData];
        }
        
        
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        isWorking1 = NO;
        [SVProgressHUD showSimpleText:@"请求失败"];
    }];
    
    
}
#pragma mark - 下拉刷新
//必须被重写
-(void)headerRereshing
{
    self.isRefresh = YES;
    
    pageIndex = 1;
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", nil];
    [self mHttpRequestWithUrl:dUrl_DIA_1_1_3 postDict:dict page:pageIndex];
}

#pragma mark - 上拉加载更多

//必须被重写
-(void)footerRereshing
{
    self.isRefresh = NO;
    
    if (self.isButtom == NO) {
        
        pageIndex++;
        
        NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
        
        NSString * ddid = [d objectForKey:UD_ddid];
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", nil];
        [self mHttpRequestWithUrl:dUrl_DIA_1_1_3 postDict:dict page:pageIndex];
        
    }else{
        
        [SVProgressHUD showSuccessWithStatus:@"没有更多数据"];
        [self.tableView footerEndRefreshing];
    }
}

#pragma mark - 获得瞬间
-(void)mHttpRequestWithUrl:(NSString *)url  postDict:(NSMutableDictionary *)postDict page:(int)page
{
    
    NSString * pa = [NSString stringWithFormat:@"%d", page];
    
    NSDictionary * temp = @{@"momentQuery.pageNum": pa, @"momentQuery.orID": self.authorID};
    
    [postDict addEntriesFromDictionary:temp];
    
    OtherVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        
        [SVProgressHUD showSuccessWithStatus:@"瞬间列表请求成功"];
        
        //如果是下拉刷新 ，清空列表
        if (weakSelf.isRefresh == YES) {
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.momentDict removeAllObjects];
            [weakSelf.zanDict removeAllObjects];
        }
        
        
        NSDictionary * dict = (NSDictionary *)obj;
        NSMutableDictionary * tempDict = [dict objectForKey:@"value"];
        
        if ([[dict objectForKey:@"value"] isKindOfClass:[NSNull class]]) {
            [SVProgressHUD showErrorWithStatus:dTips_noMoreData];
            [weakSelf.tableView footerEndRefreshing];
            [weakSelf.tableView headerEndRefreshing];
            return;
        }
        weakSelf.isButtom = [[[dict objectForKey:@"value"] objectForKey:@"isButtom"]integerValue];
        
        NSMutableArray * list = [tempDict objectForKey:@"list"];
        
        //取出数据模型
        for (NSDictionary * dict in list) {
            
            Item_MyWindow * item = [[Item_MyWindow alloc]init];
            
            item.remakCount = 1;
            
            if (self.userType == PARENT_USER) {
                
                item.age = [NSString stringWithFormat:@"%@", [dict objectForKey:@"age"]];
                item.birthday = [[dict objectForKey:@"childInfo"] objectForKey:@"birthday"];
            }
            
            //瞬间id
            item.momentID = [NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]];
            //内容
            item.content = [NSString stringWithFormat:@"%@", [dict objectForKey:@"content"]];
            //创建时间
            item.time = [NSString stringWithFormat:@"%@", [dict objectForKey:@"createTime"]];
            
            NSDictionary * dict2 = [dict objectForKey:@"author"];
            item.petName = [NSString stringWithFormat:@"%@", [dict2 objectForKey:@"petName"]];
            
            if (![[dict2 objectForKey:@"photo"] isKindOfClass:[NSNull class]]) {
                
                item.photoUrl = [NSString stringWithFormat:@"%@%@",dUrl_PhotoPrefixion, [[dict2 objectForKey:@"photo"] objectForKey:@"relativePath"]];
                
            }else{
                item.photoUrl = @"";
            }
            
            item.replies = [[dict objectForKey:@"replies"]integerValue];
            item.supports = [[dict objectForKey:@"supports"]integerValue];
            item.isOpen = NO;
            NSArray * urlArray = [dict objectForKey:@"diaBodyAttachmentList"];
            
            if ([urlArray isKindOfClass:[NSNull class]] || urlArray.count == 0) {
                [weakSelf.dataArray addObject:item];
                
                continue;
            }
            for (NSDictionary * dic in urlArray) {
                
                NSString * url;
                
                if (!([[dic objectForKey:@"attachment"] isKindOfClass:[NSNull class]])) {
                    
                    NSLog(@"%@", dict);
                    
                    
                    if ([[[dic objectForKey:@"attachment"] objectForKey:@"relativePath"] isKindOfClass:[NSNull class]]) {
                        
                    }else{
                        url = [NSString stringWithFormat:@"%@%@",dUrl_PhotoPrefixion, [[dic objectForKey:@"attachment"] objectForKey:@"relativePath"]];
                        [item.urlArray addObject:url];
                    }
                }
            }
            
            [weakSelf.dataArray addObject:item];
        }
        
        [weakSelf.tableView headerEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
        [weakSelf.tableView reloadData];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"瞬间列表请求失败"];
        
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS7) {
        
        self.navigationController.navigationBar.translucent = NO;
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self createNavItem];
    
    [self createUIView];
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    self.petName = [[d objectForKey:UD_loginDict] objectForKey:@"petName"];
    //    [self createKeyBoard];
    
    pageIndex = 1;
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", nil];
    
    d = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * loginDict = [d objectForKey:UD_loginDict];
    
//    NSString * userInfoID = [loginDict objectForKey:@"userInfoID"];
    
    switch (self.userType) {
        case AGENT:
        {
            [self agentUserHeaderWithReqeustWithID:self.authorID];
        }
            break;
        case TEACHER:
        {
            [self teacherUserHeaderWithRequestWithID:self.authorID];
        }
            break;
        case PARENT:
        {
            [self startWindowTitleRequestWithUserID:self.authorID];
        }
            break;
        default:
            break;
    }
    
    
    [self mHttpRequestWithUrl:dUrl_DIA_1_1_3 postDict:dict page:pageIndex];
    
    
    __weak OtherVC * weakSelf = self;
    
    //双击导航条之后下拉刷新
    [self.navigationController.navigationBar whenDoubleTapped:^{
        
        [weakSelf.tableView headerBeginRefreshing];
        
    }];
}
#pragma mark - 电话按钮被点击
-(void)remarkBtnClick:(UIButton *)button
{
    Item_MyWindow * item = _dataArray[button.tag - MAX_TAG];
    item.isOpen = !item.isOpen;
    
    if (item.isOpen == YES) {
        
        [self mHttpRequestWithUrl:dUrl_DIA_1_3_2 momentID:item.momentID];
        
        [self mReplayRequestWithUrl:dUrl_DIA_1_4_2 momentID:item.momentID PageIndex:1];
        
    }
    //关闭分组
    if (item.isOpen == NO) {
        
        NSMutableArray * temp = [self.momentDict objectForKey:item.momentID];
        [temp removeAllObjects];
        
        [self.tableView reloadData];
    }
    
}

#pragma mark - 发布瞬间

-(void)rightItemClick
{
    PublisWindowVC * publishVC = [[PublisWindowVC alloc]init];
    [self.navigationController pushViewController:publishVC animated:YES];
}
-(void)leftItemClick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item_MyWindow * item = _dataArray[indexPath.section];
    
    NSArray * temp = [self.momentDict objectForKey:item.momentID];
    
    if (indexPath.row == temp.count + 1) {
        
        NSLog(@"%d", indexPath.row);
        
        NSLog(@"{momentDict:}%@", self.momentDict);
        
        NSLog(@"count:%d", self.momentDict.count);
        [SVProgressHUD showSimpleText:@"点击加载更多"];
        
        if (temp && temp.count!= 0) {
            Item_RemarkList * item2 = [temp lastObject];
            
            if (item2.isButtom == NO) {
                
                item.remakCount++;
                [self mReplayRequestWithUrl:dUrl_DIA_1_4_2 momentID:item.momentID PageIndex:item.remakCount];
                
            }else{
                
                [SVProgressHUD showSuccessWithStatus:@"没有更多数据"];
            }
        }else{
            
            
            
            return;
        }
        
    }else{
        
        [self.contentWrapper showKeyboard];
    }
}

#pragma mark - 返回

-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark - 创建 leftItem RightItem
-(void)createNavItem
{
    [self initLeftItem];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:dPic_Public_toprelease forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    [rightBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark - 创建tableView

-(void)createUIView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 49 - 44)
                                                 style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    //根据用户类型创建头部视图
    switch (self.userType) {
        case AGENT:
        {
            //分类创建头部视图
            self.tableView.tableHeaderView = [self myAgentHeaderView];
        }
            break;
        case TEACHER:
        {
            //分类创建头部视图
            self.tableView.tableHeaderView = [self myAgentHeaderView];
        }
            break;
        case PARENT:
        {
            //分类创建头部视图
            self.tableView.tableHeaderView = [self myHeaderView];
        }
            break;
        default:
            break;
    }
    
    //注册下拉刷新
    [self setupRefresh:self.tableView];
    
}

#pragma mark -创建普通用户的头部视图

-(OtherPersonHeaderView *)myHeaderView
{
    OtherPersonHeaderView * headerView = [OtherPersonHeaderView instanceView];
    
    headerView.tag = DTAG_TABLEHEADER;
    
    [headerView.GoFansBtn addTarget:self action:@selector(GoFansBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView.GoFocusBtn addTarget:self action:@selector(GoFocusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return headerView;
}

#pragma mark - 创建机构用户的头部视图

-(AgentShowWinowView *)myAgentHeaderView
{
    AgentShowWinowView * headerView = [AgentShowWinowView instanceView];
    headerView.tag = DTAG_TABLEHEADER;
    
    [headerView.GoFansBtn addTarget:self action:@selector(GoFansBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView.GoFocusBtn addTarget:self action:@selector(GoFocusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    return headerView;
}

#pragma mark - 跳转到关注列表
/**跳转到关注列表**/
-(void)GoFocusBtnClick
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary * loginDict = [d objectForKey:UD_loginDict];
    
    NSString * userInfoID = [loginDict objectForKey:@"userInfoID"];
    
    FocusVC * focusVC  = [[FocusVC alloc]init];
    
    focusVC.type = 2;
    
    focusVC.authorID = userInfoID;
    
    [self.navigationController pushViewController:focusVC animated:YES];
}
#pragma mark - 跳转到粉丝列表
/**跳转到粉丝列表**/
-(void)GoFansBtnClick
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary * loginDict = [d objectForKey:UD_loginDict];
    
    NSString * userInfoID = [loginDict objectForKey:@"userInfoID"];
    
    FocusVC * focusVC  = [[FocusVC alloc]init];
    
    focusVC.authorID = userInfoID;
    
    focusVC.type = 1;
    
    [self.navigationController pushViewController:focusVC animated:YES];
}

#pragma mark - 发私信
/**发私信按钮被点击**/
-(void)sendMsgClick
{
    [SVProgressHUD showSimpleText:@"发私信"];
}
#pragma mark - 已关注
/**已关注按钮被点击**/
-(void)focusBtnClick
{
    [SVProgressHUD showSimpleText:@"已关注"];
}

#pragma mark - tableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, kMainScreenWidth, 0.01);
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
#pragma mark - 除去tableViewGroup模式的黑色footer
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(Cell_MyWindow *)loadHeaderViewWithSection:(NSInteger)section
{
    Cell_MyWindow * cell = [[Cell_MyWindow alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    Item_MyWindow * item = _dataArray[section];
    
    cell.nickNameLbl.text = item.petName;
    
    NSString * replay = [NSString stringWithFormat:@"%d", item.replies + item.supports];
    [cell.remarkBtn setTitle:replay forState:UIControlStateNormal];
    CGSize size = [[MyParserTool shareInstance] sizeWithRawString:item.content constrainsToWidth:cell.contentLbl.frame.size.width Font:cell.contentLbl.font];
    CGRect frame = cell.contentLbl.frame;
    frame.size = size;
    
    cell.contentLbl.frame = frame;
    //    cell.contentLbl.backgroundColor = [UIColor greenColor];
    cell.contentLbl.text = item.content;
    cell.timeLbl.text = [TimeTool getUTCFormateDate:item.time];
    
    if (item.urlArray.count != 0) {
        
        frame = cell.showImageView.frame;
        
        frame.size.height = frame.size.width;
        frame.origin.y = CGRectGetMaxY(cell.contentLbl.frame);
        
        cell.showImageView.frame = frame;
        
        //用于集成照片浏览器
        cell.showImageView.tag = MAX_TAG_3 + section;
        
        NSURL * url = [NSURL URLWithString:item.urlArray[0]];
        
        [cell.showImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"saga2.jpg"]];
        
        
        UIButton * placeHoder = [[UIButton alloc]initWithFrame:cell.showImageView.frame];
        
        placeHoder.tag = MAX_TAG_2 + section;
        
        [cell addSubview:placeHoder];
        
        [placeHoder addTarget:self action:@selector(tapImageClick:) forControlEvents:UIControlEventTouchUpInside];
        
        frame = cell.remarkBtn.frame;
        
        frame.origin.y = CGRectGetMaxY(cell.showImageView.frame) + 5;
        cell.remarkBtn.frame = frame;
    }
    else{
        
        frame = cell.remarkBtn.frame;
        
        frame.origin.y = CGRectGetMaxY(cell.contentLbl.frame) + 5;
        cell.remarkBtn.frame = frame;
    }
    
    cell.remarkBtn.selected = item.isOpen;
    cell.remarkBtn.tag = MAX_TAG + section;
    [cell.remarkBtn addTarget:self action:@selector(remarkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}
#pragma mark - 每一条瞬间
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self loadHeaderViewWithSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    Item_MyWindow * item = _dataArray[section];
    
    CGSize size = [[MyParserTool shareInstance] sizeWithRawString:item.content constrainsToWidth:kMainScreenWidth - 80 Font:[UIFont systemFontOfSize:14]];
    
    if (item.urlArray && item.urlArray.count!= 0) {
        
        return  (kMainScreenWidth - 80) + 100  + size.height;
    }
    return 100 + size.height;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item_MyWindow * item = _dataArray[indexPath.section];
    
    NSArray * temp = [self.momentDict objectForKey:item.momentID];
    
    if (indexPath.row == 0) {
        
        Item_MyWindow * item = _dataArray[indexPath.section];
        
        NSArray * temp = [self.zanDict objectForKey:item.momentID];
        
        if (temp!=nil && temp.count!= 0) {
            
            NSString * html = [StringTool assmbleHtmlStringWithArray:temp];
            //用来计算高度
            RTLabel * rtlbl = [[RTLabel alloc]init];
            rtlbl.text = html;
            CGSize  size =  [rtlbl optimumSize];
            
            return size.height + 44;
        }
        
        return 44;
    }
    if (indexPath.row == temp.count + 1) {
        
        return 35;
    }
    
    Item_RemarkList * item2 =temp[indexPath.row - 1];
    
    return [item2 height]  + 20 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Item_MyWindow * item = _dataArray[section];
    if (!item.isOpen) {
        
        return 0;
    }
    
    NSMutableArray * temp = [self.momentDict objectForKey:item.momentID];
    
    return temp.count + 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Item_MyWindow * item = _dataArray[indexPath.section];
    
    NSArray * temp = [self.momentDict objectForKey:item.momentID];
    
    if (indexPath.row == 0) {
        return  [self createContentCell:indexPath];
    }
    if (indexPath.row == temp.count + 1) {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"点击加载更多";
        return cell;
    }
    NSString * strID = @"ID";
    Cell_ShowRemark * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        cell = [[Cell_ShowRemark alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    Item_RemarkList * item2 =temp[indexPath.row -1];
    
    
    cell.remarkLbl.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    
    [cell.remarkLbl setLinkAttributes:nil];
    NSMutableAttributedString * myStr = [StringTool assmbleTTTAttringStringWithString:item2.petName bString:item2.content];
    cell.remarkLbl.text = myStr;
    //    cell.remarkLbl.text = [NSString stringWithFormat:@"%@:%@", item2.petName, item2.content];
    //设置超文本格式
    
    NSRange range = NSMakeRange(0, item2.petName.length + 1);
    
    NSString * urlStr = [NSString stringWithFormat:@"file:///%@_%d", item2.mid, indexPath.section];
    NSLog(@"%@", item2.mid);
    NSLog(@"urlStr == %@", urlStr);
    [cell.remarkLbl addLinkToURL:[NSURL URLWithString:urlStr] withRange:range];
    //曲调超链接的下划线
    cell.remarkLbl.tag = MAX_TAG_5 + indexPath.row;
    cell.remarkLbl.delegate = self;
    CGRect frame = cell.remarkLbl.frame;
    frame.size.height = [item2 height] + 5;
    cell.remarkLbl.frame = frame;
    return cell;
}
#pragma mark - tttdleegate 点击进入该朋友的橱窗
- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    
    //获得相对路径
    NSString * str = [url relativeString];
    str = [str stringByReplacingOccurrencesOfString:@"file:///" withString:@""];
    NSLog(@"%@", str);
    
    //拿到section的range
    NSRange range = [str rangeOfString:@"_"];
    
    //拿到section
    NSString * sectionStr = [str substringFromIndex:range.location + 1];
    NSInteger section = sectionStr.integerValue;
    
    Item_MyWindow * item1 = self.dataArray[section];
    
    NSArray * temp = [self.momentDict objectForKey: item1.momentID];
    
    Item_RemarkList * item2 = temp[(label.tag - MAX_TAG_5) - 1];
    
    OtherVC * otherVC = [[OtherVC alloc]init];
    
    otherVC.userType = item2.userType;
    
    otherVC.title = [item2.petName stringByAppendingString:@"的橱窗"];
    
    otherVC.authorID = item2.mid;
    
    [self.navigationController pushViewController:otherVC animated:YES];
    
}
-(UITableViewCell *)createContentCell:(NSIndexPath *)index
{
    UIView * mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 80)];
    
    UIButton * infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    infoBtn.frame =  CGRectMake(50, 15, 25, 25);
    [infoBtn setBackgroundImage:[UIImage imageNamed:@"show_info"] forState:UIControlStateNormal];
    [infoBtn setBackgroundImage:[UIImage imageNamed:@"show_info_selected"] forState:UIControlStateHighlighted];
    infoBtn.tag = index.section + MAX_TAG;
    [infoBtn addTarget:self action:@selector(warnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:infoBtn];
    
    UIButton * zan = [UIButton buttonWithType:UIButtonTypeCustom];
    zan.frame = CGRectMake(infoBtn.frame.size.width + infoBtn.frame.origin.x + 50, 15, 50, 20);
    [zan setTitle:@"赞" forState:UIControlStateNormal];
    zan.titleLabel.font = [UIFont systemFontOfSize:13];
    [zan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [zan setImage:[UIImage imageNamed:@"show_item_zan"] forState:UIControlStateNormal];
    [zan setImage:[UIImage imageNamed:@"show_item_zan1"] forState:UIControlStateHighlighted];
    zan.layer.cornerRadius = 3;
    zan.layer.borderColor = [UIColor grayColor].CGColor;
    zan.layer.borderWidth = 1;
    [zan setLayout:OTSImageLeftTitleRightStyle spacing:10];
    zan.tag = index.section + MAX_TAG;
    [zan addTarget:self action:@selector(zanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:zan];
    
    UIButton * remarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = zan.frame;
    frame.origin.x = zan.frame.origin.x + zan.frame.size.width + 50;
    remarkBtn.frame = frame;
    remarkBtn.layer.masksToBounds = YES;
    remarkBtn.layer.borderWidth = 1;
    remarkBtn.layer.borderColor = [UIColor grayColor].CGColor;
    remarkBtn.layer.cornerRadius = 3;
    [remarkBtn setLayout:OTSImageLeftTitleRightStyle spacing:5];
    [remarkBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    remarkBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [remarkBtn setTitle:@"评论" forState:UIControlStateNormal];
    [remarkBtn setImage:[UIImage imageNamed:@"show_item_comment"] forState:UIControlStateNormal];
    [remarkBtn setImage:[UIImage imageNamed:@"show_item_comment1"] forState:UIControlStateHighlighted];
    remarkBtn.tag = index.section  + MAX_TAG;
    [remarkBtn addTarget:self action:@selector(remarkBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:remarkBtn];
    
    RTLabel * rtLabel = [[RTLabel alloc]initWithFrame:CGRectMake(70, remarkBtn.frame.origin.y + remarkBtn.frame.size.height + 10, kMainScreenWidth - 80, 40)];
    rtLabel.tag = index.section + MAX_TAG_4;
    rtLabel.font = [UIFont systemFontOfSize:14];
    Item_MyWindow * item = _dataArray[index.section];
    
    NSArray * temp = [self.zanDict objectForKey:item.momentID];
    
    if (temp!=nil && temp.count!= 0) {
        
        NSString * html = [StringTool assmbleHtmlStringWithArray:temp];
        
        rtLabel.text = html;
    }
    
    rtLabel.textColor = [UIColor blueColor];
    rtLabel.delegate = self;
    //    rtLabel.font = [UIFont systemFontOfSize:];
    
    //动态计算rtLabel的高度
    CGSize optimumSize = [rtLabel optimumSize];
    
    frame = rtLabel.frame;
    
    frame.size = optimumSize;
    
    rtLabel.frame = frame;
    
    rtLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    
    [mainView addSubview:rtLabel];
    
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:mainView];
    
    return cell;
}
#pragma mark - RTLabelDelegate
/**用于点击评论列表之后进入改朋友的主页**/
/**用于点击评论列表之后进入改朋友的主页**/
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    //    NSString * str = [url host];
    NSString * str = [url absoluteString];
    str = [str URLDecodedString];
    
    //这个str是评论人的id
    str = [str substringFromIndex:5];
    NSLog(@"%@", str);
    
#pragma mark - 先根据 tag值取出瞬间id,再用瞬间id当做key取出_zanlist中的点在列表，在点赞列表中找到 和 传过来的id相同的id对应的用户类型传值
    RTLabel * newRtLabel = (RTLabel *)rtLabel;
    
    Item_MyWindow * item = self.dataArray[newRtLabel.tag - MAX_TAG_4];
    
    NSArray * temp = _zanDict[item.momentID];
    
    //用户类型
    
    Item_zanList * tempItem = nil;
    
    for (Item_zanList * zanItem in temp) {
        
        if ([zanItem.mid isEqualToString:str]) {
            
            //            userType = zanItem.userType;
            tempItem = zanItem;
            break;
        }
    }
    
    //    [self httpRequestWithUrl:dUrl_OSM_1_1_13 mid:str uerType:userType];
    OtherVC * otherVC = [[OtherVC alloc]init];
    
    otherVC.userType = tempItem.userType;
    
    otherVC.title = [tempItem.petName stringByAppendingString:@"的橱窗"];
    
    otherVC.authorID = tempItem.mid;
    
    [self.navigationController pushViewController:otherVC animated:YES];
    
}

#pragma mark - 点击进入改朋友的资料
-(void)httpRequestWithUrl:(NSString *)url mid:(NSString *)mid
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", mid, @"userInfoQuery.orId",nil];
    
    __weak OtherVC * weakSelf = self;
    
    [http fiveReuqestUrl:url postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"请求成功"];
        
        NSDictionary * root = (NSDictionary *)obj;
        
        weakSelf.item.petName = [[root objectForKey:@"value"] objectForKey:@"petName"];
        weakSelf.item.relativePath = [NSString stringWithFormat:@"%@%@", dUrl_PhotoPrefixion, [[[root objectForKey:@"value"] objectForKey:@"photo"] objectForKey:@"relativePath"]];
        weakSelf.item.located = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"located"];
        weakSelf.item.personnelSignature = [[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"personnelSignature"];
        weakSelf.item.gender =[[[[root objectForKey:@"value"] objectForKey:@"userInfoExtension"] objectForKey:@"gender"]intValue];
        weakSelf.item.wpCode = [[root objectForKey:@"value"] objectForKey:@"wpCode"];
        
        weakSelf.myDatumVC.item = weakSelf.item;
        
        weakSelf.myDatumVC.type = 2;
        [weakSelf.navigationController pushViewController:weakSelf.myDatumVC animated:YES];
        
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
    
    
}

#pragma mark - 相册的方法

-(void)tapImageClick:(UIButton *)button
{
    
    Item_MyWindow * item = _dataArray[button.tag - MAX_TAG_2];
    NSArray * urls = item.urlArray;
    NSInteger count = urls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        if (i == 0) {
            //            photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
            photo.srcImageView = (UIImageView *)[self.view viewWithTag:button.tag - MAX_TAG_2 + MAX_TAG_3];
            
        }
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}
@end
