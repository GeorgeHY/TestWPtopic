//
//  RichLabelView.h
//  LabelText
//
//  Created by 心 猿 on 14-10-23.
//  Copyright (c) 2014年 心 猿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RichLabelView : UIView
{
    CGRect mFrame;
    CGFloat maxWidth;
}
@property (nonatomic, assign) int xSpace;//间距
/**自适应告诉可点击的控件,para:arr 是 字符串数组 **/
- (id)initWithFrame:(CGRect)frame nameArr:(NSArray *)arr;
@end
