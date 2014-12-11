//
//  AnnouncementAllCell.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-6.
//  Copyright (c) 2014年 funeral. All rights reserved.
//瀑布流cell

#import "AnnAllWaterfalllCell.h"

@implementation AnnAllWaterfalllCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bg = [[UIImageView alloc]  initWithFrame:CGRectZero];
        self.bg.image = [UIImage imageNamed:@"cellBGView.png"];
        [self.contentView addSubview:self.bg ];
        self.title = [[UILabel alloc]  initWithFrame:CGRectMake(160/2 - 30, 10, 60, 20)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont boldSystemFontOfSize:12];
        self.title.adjustsFontSizeToFitWidth = YES;
//        self.title.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.title];
        self.time = [[UILabel alloc]  initWithFrame:CGRectMake(160 - 30-10, 10, 30, 20)];
//        self.time.backgroundColor = [UIColor greenColor];
        self.time.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.time];
        self.photo = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.photo.contentMode = UIViewContentModeScaleAspectFit;
//        self.photo.backgroundColor = [UIColor blueColor];
        [self.contentView  addSubview:self.photo];
        

        
        self.content = [[UILabel alloc] initWithFrame:CGRectZero];
        self.content.font = [UIFont systemFontOfSize:12];
        self.content.lineBreakMode = NSLineBreakByWordWrapping;
        self.content.numberOfLines = 0;
        [self.contentView addSubview:self.content];

        self.heartIv = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.heartIv  setImage:[UIImage imageNamed:@"reply.png"]];
        [self.contentView addSubview:self.heartIv];
        
        self.heartCount= [[UILabel alloc] initWithFrame:CGRectZero];
        self.heartCount.font = [UIFont boldSystemFontOfSize:10];
        [self.contentView addSubview:self.heartCount];
        
        
        self.msgIv = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.msgIv.image = [UIImage imageNamed:@"1.png"];
        [self.contentView addSubview:self.msgIv];
        self.msgCount= [[UILabel alloc]  initWithFrame:CGRectZero];
        self.msgCount.font = [UIFont boldSystemFontOfSize:10];
        [self.contentView addSubview:self.msgCount];
        
        
        
        self.line = [[UIImageView alloc]  initWithFrame:CGRectZero];
        self.line.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.line];
        
        self.image = [[UIImageView alloc]  initWithFrame:CGRectZero];
        
        [self.contentView addSubview:self.image];
        
        self.name =[[UILabel alloc]  initWithFrame:CGRectZero];
        self.name.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:self.name];
        
        
    }
    return self;
}

-(void) changeImageHight:(float) height changeTxtHighe:(float ) txtHight{
    
    self.photo.frame = CGRectMake(10, 30,140, height);
    self.photo.contentMode =
    UIViewContentModeScaleAspectFit;

    self.content.frame = CGRectMake(10,height+30, 140, txtHight);
    

    
    self.heartIv.frame = CGRectMake(10, height+txtHight+30,15, 15);
    self.heartCount.frame = CGRectMake(10+15+5, height+txtHight+30,60, 15);
    
    self.msgIv.frame = CGRectMake(160-60,height+txtHight+30,20, 20);
    self.msgCount.frame = CGRectMake (160 - 30,height+txtHight+30,20, 20);
    
    self.line.frame =  CGRectMake(5,height+txtHight+30+20,150, 0.5);
    
    self.image.frame = CGRectMake(5,height+txtHight+30+20+2,40, 40);
    self.name.frame = CGRectMake(45 ,height+txtHight+30+20+2,40, 40);


    self.bg.frame = CGRectMake(5,0,150, height+txtHight+30+20+10+40);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
