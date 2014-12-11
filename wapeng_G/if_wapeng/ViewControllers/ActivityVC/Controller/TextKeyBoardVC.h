//
//  TextKeyBoardVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-10-27.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
/**
 暂时代替键盘用的
 **/

@protocol TextKeyBoardDelegate <NSObject>

@required

-(void)sendText:(NSString *)string type:(int)pageType index:(int)index;

@end
#import <UIKit/UIKit.h>

@interface TextKeyBoardVC : UIViewController<UITextViewDelegate>
@property (nonatomic, weak) id <TextKeyBoardDelegate> delegate;
@property (nonatomic, assign) int pageType;//1活动回复举报 2.活动那个回复回复 3.活动回复 4.活动举报
@property (nonatomic, assign) int index;
@end
