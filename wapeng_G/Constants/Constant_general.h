//
//  Constant_general.h
//  if_wapeng
//
//  Created by 心 猿 on 14-7-22.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

//在此处写一些通用的宏
#ifndef if_wapeng_Constant_general_h
#define if_wapeng_Constant_general_h




//appdeleate信息
#define showVCTypeLogin 1 //显示登录页面
#define showVCTypeTab   2 //显示tabbar

//适配
//屏幕高度加上状态栏
#define ScreenHegiht ([UIScreen mainScreen].bounds.size.height)
//屏幕高度
#define kMainScreenHeight ([UIScreen mainScreen].applicationFrame.size.height)
//屏幕宽度
#define kMainScreenWidth  ([UIScreen mainScreen].applicationFrame.size.width)
//是不是ios7
#define IOS7     ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) 
//是不是iphone5
#define kScreenIphone5    (([[UIScreen mainScreen] bounds].size.height)>=568)
#endif


#define kRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1];

/*这里写通知*/
#define dNoti_TabAnimation @"text"//收起或隐藏tabbar obj @"1"显示 @"2"隐藏
#define dNoti_willReceiveUIView @"willReceiveUIVIew" //接收UIView
#define dNoti_receiveUIView @"receiveUIVIew" //接收UIView

#define dNoti_isHideKeyBoard @"isHideKeyBoard"//隐藏显示tabbar




/*注册模块通知*/
#define dNOti_unique @"unique" //检验手机是否唯一