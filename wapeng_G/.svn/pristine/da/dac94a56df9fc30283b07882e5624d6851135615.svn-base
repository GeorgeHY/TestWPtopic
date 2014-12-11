//
//  HotWordVIew.h
//  if_wapeng
//
//  Created by 心 猿 on 14-10-24.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
@protocol HotWordDelegate <NSObject>

@required

-(void)hotWordName:(NSString *)hotWordName;

@end
#import <UIKit/UIKit.h>

@interface HotWordVIew : UIView
@property (nonatomic, assign) CGFloat fontSize;//大小
@property (nonatomic, strong) NSMutableArray * hotWordArr;
@property (nonatomic, assign) CGRect mframe;//坐标
@property (nonatomic, strong) NSMutableArray * frameArray;
@property (nonatomic, weak) id <HotWordDelegate> delegate;
@property (nonatomic, strong) NSString * hotWordString;
- (id)initWithFrame:(CGRect)frame andHotWordArray:(NSArray *)array fontSize:(CGFloat)fontSize;
@end
