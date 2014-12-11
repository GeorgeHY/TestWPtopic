//
//  RegisterVC06.h
//  if_wapeng
//
//  Created by 心 猿 on 14-7-29.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterVC06 : UIViewController
//所在班级的名称
@property(nonatomic,strong)NSString * class_Name;
//班级ID
@property(nonatomic,strong)NSString * class_Id;
//幼儿园ID
@property(nonatomic,strong)NSString * kindgarden_Id;
//kinggardenName
@property(nonatomic,strong)NSString * kinggarden_Name;
//城市ID
@property(nonatomic,strong)NSString * city_Id;
//医院ID
@property(nonatomic,strong)NSString * hospital_Id;
//上传成功返回的照片ID
@property(nonatomic,strong)NSString * pic_Id;
//孩子性别  1-男 2-女
@property(nonatomic,strong)NSString * gender_Id;

@property(nonatomic,strong)NSString * register_Id;
@end
