//
//  CheckDataTool.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-15.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "CheckDataTool.h"
//核对数据类
@implementation CheckDataTool
//输入框是否为空 为空给出提示
+(BOOL)checkInfo:(UITextField *) textFied msgContent:(NSString *) msg{
    if (textFied.text.length == 0) {
        [SVProgressHUD showSimpleText:msg];
        return NO;
    }
    return YES;
}
+(BOOL)checkInfoForString:(UITextView *) textView msgContent:(NSString *) msg{
    if (textView.text.length == 0) {
        [SVProgressHUD showSimpleText:msg];
        return NO;
    }
    return YES;
}
@end
