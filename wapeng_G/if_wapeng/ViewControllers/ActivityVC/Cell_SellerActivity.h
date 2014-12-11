//
//  Cell_SellerActivity.h
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_SellerActivity : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shoppingCarIView;//i
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;//主标题
@property (weak, nonatomic) IBOutlet UILabel *mDetailLabel;//副标题
@property (weak, nonatomic) IBOutlet UILabel *loactionLabel;//距离标题
@property (weak, nonatomic) IBOutlet UILabel *joinLabel;//多少位熟人参与

@end
