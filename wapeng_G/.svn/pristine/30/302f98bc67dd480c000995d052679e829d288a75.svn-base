//
//  Constant_typedef.h
//
//
//  Created by Qian Kun on 13-7-8.
//  Copyright (c) 2013年 iwind. All rights reserved.
//


#define ResultTypeNum(type) [NSNumber numberWithInt:type]//类型的数值


typedef NS_ENUM(NSInteger, WP_USER_TYPE) {
	PARENT_USER = 1, //家长用户
	TEACHER_USER = 2,//教师用户
	AGENT_USER = 3,  //机构用户
};

typedef enum
{
    ResultType_normal = 0,//正常数据
    ResultType_connectionError,//网络连接错误
    ResultType_requestError,//请求错误
    ResultType_noData,//没有数据
    ResultType_errorMsg,//错误信息
    ResultType_picUploadfailed,//头像上传失败
}ResultType;


#define dConnectKeyType @"resultType"
#define dConnectKeyData @"jsonData"

#pragma mark -- public
//==================public====================
#define dTips_connectionError @"网络连接错误，请稍候重试~"
#define dTips_requestError @"请求错误"
#define dTips_timeOut @"请求超时"
#define dTips_stateFail @"操作失败，请稍候重试~"
#define dTips_noData @"数据为空~"
#define dTips_noMoreData @"没有更多数据了"
#define dTips_parseError @"解析错误"
#define dTips_uploadError @"头像上传失败"
#define dTips_uploadSuccess @"头像上传成功"
#define dTip_loading @"正在加载..."
#define dTips_changeSuccess @"修改成功"
#define dTips_changeFailed  @"修改失败"
#define dTips_quitSuccess   @"注销成功"
//当前版本号
#define dCurrentVersion_Num  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define kNullData    @"空"
#define kDefaultPic   [UIImage imageNamed:@"saga2.jpg"] //用户没有上传照片的头像