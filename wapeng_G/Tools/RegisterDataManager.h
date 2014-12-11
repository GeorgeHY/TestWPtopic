//
//  RegisterDataManager.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-13.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
/*
 
 保存最后提交的所有数据
 
 */
#import <Foundation/Foundation.h>

@interface RegisterDataManager : NSObject

@property (nonatomic, strong) NSString * phoneNum;//手机号码
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * uuid;
//@property (nonatomic, strong) NSString * regInfo;//这个参数暂时不明
@property (nonatomic, strong) NSString * regInfo;//验证码
@property (nonatomic, strong) NSString * regInfoID;//验证码主键
@property (nonatomic, strong) NSString * parentNickName;//家长昵称
@property (nonatomic, strong) NSString * parentGender;//父母性别
@property (nonatomic, strong) NSString * latitude;//纬度
@property (nonatomic, strong) NSString * longtitude;//经度
@property (nonatomic, strong) NSString * picID;//头像id
@property (nonatomic, strong) NSString * childNickName;//孩子昵称
@property (nonatomic, strong) NSString * childBrith;//孩子生日
@property (nonatomic, strong) NSString * childGender;//孩子性别
@property (nonatomic, strong) NSString * isUnique;//是否独生 1是独生 2不是独生
@property (nonatomic, strong) NSString * brithHospital;//出生医院
@property (nonatomic, strong) NSString * kindergaten;//幼儿园
@property (nonatomic, strong) NSString * customKindergaten;//自定义幼儿园
@property (nonatomic, strong) NSString * city;//
@property (nonatomic, strong) NSString * branchAgent;//分支机构
@property (nonatomic, strong) NSString * localPlace;//常住地
@property (nonatomic, strong) NSString * classID;//班级ID
@property (nonatomic, strong) NSString * kindgardenID;//头像id

@property (nonatomic, strong) NSString * hospitalID;
//d_ID
@property (nonatomic, strong) NSString * d_ID;
@property (nonatomic, strong) NSString * registerPhoneNum;//已经被注册的手机号
//login  d_id
@property (nonatomic, strong) NSString * login_D_ID;
@property (nonatomic, strong) NSString * registerSuccPassword;

+(instancetype)shareInstance;
-(void)printfSelf;
@end
