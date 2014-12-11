//
//  ChangeCityVC01.h
//  if_wapeng
//
//  Created by 心 猿 on 14-7-30.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeCityVC01 : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * provinceTableView;
    
    NSMutableArray * provinceArray;
    
    NSMutableArray * cityArray;
}
@property (nonatomic, strong) UITableView * provinceTableView;
@property (nonatomic, strong) NSMutableArray * provinceArray;

@end
