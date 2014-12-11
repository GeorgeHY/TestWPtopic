//
//  DialogView.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
typedef void (^OperationBlock) (NSInteger index);//告诉cell进行了arr_title中的哪个操作
#import <UIKit/UIKit.h>

@interface DialogView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    CGRect _frame;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSDictionary * dict_data;
@property (nonatomic, strong) NSArray * arr_image;
@property (nonatomic, strong) NSArray * arr_title;
@property (nonatomic, copy) OperationBlock block;
@property(nonatomic , strong) UIControl * control;
@property(nonatomic , strong)     UIWindow *keywindow;
+(instancetype)shareInstance;
@end
