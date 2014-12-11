//
//  AnnouncementAllCell.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-6.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnAllWaterfalllCell : UITableViewCell
@property(nonatomic , strong) UILabel * title;
@property(nonatomic , strong) UILabel * time;

@property(nonatomic , strong) UIImageView * photo;
@property(nonatomic , strong) UIImageView * bg;
@property(nonatomic , strong) UILabel * content;

@property(nonatomic , strong) UIImageView * heartIv;
@property(nonatomic , strong) UILabel * heartCount;
@property(nonatomic , strong) UIImageView * msgIv;

@property(nonatomic , strong) UILabel * msgCount;

@property(nonatomic , strong) UIImageView * line;
@property(nonatomic , strong) UIImageView * image;
@property(nonatomic , strong) UILabel * name;

-(void) changeImageHight:(float) height changeTxtHighe:(float ) txtHight;
@end
