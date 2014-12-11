//
//  LoginViewController.h
//  if_wapeng
//
//  Created by 永不死的圣斗士 on 14-6-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * userIdText;
@property (nonatomic, strong) UITextField * passwordText;
@property (nonatomic, assign) int accountType;
@property (nonatomic, strong) NSString * account;
@property (nonatomic, strong) NSMutableDictionary * loginDict;
@property (nonatomic, strong) NSString * uuID;
@property(nonatomic,strong)NSString * modifyPwd;
@end
