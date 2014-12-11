//
//  RigisterVC02.h
//  if_wapeng
//
//  Created by 心 猿 on 14-7-28.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RigisterVC02 : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) UILabel * placeholderLabel;
@property(nonatomic,strong)NSString * checkFlag;//网络请求成功标志位

-(IBAction)codeBtnOnClick:(id)sender;//点击发送
@end
