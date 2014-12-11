//
//  ActivityDetailVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextKeyBoardVC.h"


@interface ActivityDetailVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate,UITextViewDelegate, TextKeyBoardDelegate>
{
    AFN_HttpBase * http;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSString * activityID;//活动主键
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * smallArr1;
@property (nonatomic, strong) NSMutableArray * smallArr2;
@property (nonatomic, assign) int isButtom;//是否有下一页
@property (nonatomic, assign) int operation;//下拉刷新还是上拉加载1，下拉2.上拉
@end
