//
//  WaterfallView.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@protocol UIdidSelectRowAtIndexDelegate <NSObject>
@required
- (void)didSelectRowAtIndexPath;

@end


@interface WaterfallView : UIView<UITableViewDelegate , UITableViewDataSource>

@property(nonatomic , strong) UITableView * tableLeft;
@property(nonatomic , strong) UITableView * tableRight;
@property(nonatomic , strong) NSMutableArray * dataLeft;
@property(nonatomic , strong) NSMutableArray * dataRight;
@property(nonatomic , strong) id<UIdidSelectRowAtIndexDelegate> SelectRow;


-(void)createComponent:(NSMutableArray *) data;
-(void)reloadTableData:(NSMutableArray *) data;
@end
