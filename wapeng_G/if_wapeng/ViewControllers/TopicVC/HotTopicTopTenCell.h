//
//  HotTopicTopTenCell.h
//  if_wapeng
//
//  Created by 符杰 on 14-10-21.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQRichTextView.h"

@interface HotTopicTopTenCell : UITableViewCell

@property(nonatomic , strong) UIView * v;
@property(nonatomic , retain) UILabel * topLable;
@property(nonatomic , retain) UILabel * replyLable;
@property(nonatomic , retain) UILabel * personLable;
@property(nonatomic , retain) TQRichTextView * contentLable;
@property(nonatomic , retain) UIImageView * headImageView;
@property(nonatomic , retain) UILabel * nameLable;
@end
