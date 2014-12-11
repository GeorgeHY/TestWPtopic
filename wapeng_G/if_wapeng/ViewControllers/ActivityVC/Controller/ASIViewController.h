//
//  ASIViewController.h
//  if_wapeng
//
//  Created by 心 猿 on 14-10-10.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceToolBar.h"
#import "HotWordVIew.h"
@interface ASIViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, HotWordDelegate>
{
    
}
@property(nonatomic, assign) int tt;
@property (nonatomic ,assign) int ttt;
@property (nonatomic, strong) UITableView * tableView;
@end
