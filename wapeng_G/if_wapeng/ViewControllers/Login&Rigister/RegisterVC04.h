//
//  RegisterVC04.h
//  if_wapeng
//
//  Created by 心 猿 on 14-7-28.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPopoverListView.h"
@interface RegisterVC04 : UIViewController<UITextFieldDelegate , UIPopoverListViewDataSource, UIPopoverListViewDelegate,UISearchBarDelegate>

@property(nonatomic,strong)NSString * search_Name;
typedef enum
{
    ECity = 0,//城市
    EArea,//区域
    EHospital,//医院
} TableFlagEnum;

@end
