//
//  SelectHotLabelVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-10-30.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectHotLabelVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSMutableArray * _dataArray;
    NSMutableArray * _selectArray;//dadaArry中被选中的标签
    CGRect _frame;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) int isDouble;

@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * mTitle;
@property (nonatomic, strong) NSMutableArray * imageIDArray;
@property (nonatomic, strong) NSString* limitTime;
@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) int type; // type == 1 话题发布
@property (nonatomic, assign) int isAnonmity;//话题是否匿名
@end
