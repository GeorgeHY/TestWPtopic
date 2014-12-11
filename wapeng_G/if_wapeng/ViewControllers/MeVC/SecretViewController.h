//
//  SecretViewController.h
//  if_wapeng
//
//  Created by 心 猿 on 14-7-23.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecretViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * dataArray;
    
    UITableView * secretTableView;
}
@end
