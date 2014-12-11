//
//  HotTopicDetailVC.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface HotTopicDetailVC : UIViewController<UITableViewDataSource , UITableViewDelegate , UITextViewDelegate ,MBProgressHUDDelegate>
@property(nonatomic , strong) NSString * _id;
@end
