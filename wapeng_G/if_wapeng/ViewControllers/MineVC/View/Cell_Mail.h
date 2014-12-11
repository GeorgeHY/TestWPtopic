//
//  Cell_Mail.h
//  if_wapeng
//
//  Created by 早上好 on 14-10-23.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TQRichTextView;
@interface Cell_Mail : UITableViewCell
@property (strong, nonatomic) UIImageView *headerIV;
@property (strong, nonatomic)  UILabel *name;
@property (strong, nonatomic) TQRichTextView * mailContent;
@end
