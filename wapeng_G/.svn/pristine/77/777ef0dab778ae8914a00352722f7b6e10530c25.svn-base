//
//  MineShowWindowVC.h
//  if_wapeng
//
//  Created by 心 猿 on 14-10-5.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FaceToolBar.h",FaceToolBarDelegate
@interface MineShowWindowVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    NSMutableArray * _dataArray;
    NSMutableArray * _momentArray;//所有瞬间回复的array
    NSMutableArray * _zanArray;//瞬间点赞分页列表
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, assign) int pageType;//页面类型
@property (nonatomic, strong) NSMutableArray * momentArray;
@property (nonatomic, strong) NSMutableArray * zanArray;
@property (nonatomic, strong) NSString * petName;

/**瞬间列表**/
-(void)startHttpRequestWithUrl:(NSString *)url  postDict:(NSMutableDictionary *)postDict page:(int)page;
@end
