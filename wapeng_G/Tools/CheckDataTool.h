//
//  CheckDataTool.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-15.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckDataTool : NSObject
+(BOOL)checkInfo:(UITextField *) textFied msgContent:(NSString *) msg;
+(BOOL)checkInfoForString:(UITextView *) textView msgContent:(NSString *) msg;

@end
