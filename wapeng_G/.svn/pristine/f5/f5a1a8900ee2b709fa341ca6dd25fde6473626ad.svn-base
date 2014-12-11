//
//  MyMailVC.h
//  if_wapeng
//
//  Created by 早上好 on 14-10-27.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableView.h"
typedef NS_ENUM(NSInteger, LetterStyle) {
	letterLeftStyle = 0, //熟人私信
	letterRightStyle = 1, //陌生人私信
    
};
@interface MyMailVC : UIViewController

@property(nonatomic , strong) UITableView * leftTableView;
@property (nonatomic, strong) UITableView * rightTableView;
@property(nonatomic , strong) NSMutableArray * leftDataArray;
@property (nonatomic, strong) NSMutableArray * rightDataArray;
@property(nonatomic)LetterStyle letterStyle;
@end
