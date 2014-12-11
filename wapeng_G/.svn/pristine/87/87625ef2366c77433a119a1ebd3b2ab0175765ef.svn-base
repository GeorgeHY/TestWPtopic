//
//  Cell_WaterFlow.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Cell_WaterFlow.h"
#import "UIColor+AddColor.h"
@implementation Cell_WaterFlow
-(void)createContentView
{
    self.headerView = [[UIView alloc]init];
    self.headerView.backgroundColor = [UIColor greenColor];
    self.headerView.frame = CGRectMake(10, 5, kMainScreenWidth / 2.0 - 10, 20);
    [self.contentView addSubview:self.headerView];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.backgroundColor = [UIColor purpleColor];
    self.titleLabel.frame = CGRectMake(0, 0, kMainScreenWidth / 2 - 60, 20);

    
    [self.headerView addSubview:self.titleLabel];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.frame = CGRectMake(self.titleLabel.frame.size.width + self.titleLabel.frame.origin.x, 0, 80, 20);
//    self.timeLabel.text = @"0分钟前";
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self.headerView addSubview:self.timeLabel];
    
    self.headerIView = [[UIImageView alloc]init];
    self.headerIView.frame = CGRectMake(10, 25, kMainScreenWidth / 2.0 - 20, 100);
    self.headerIView.layer.masksToBounds = YES;
    self.headerIView.layer.cornerRadius = 4;
    self.headerIView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headerIView.layer.borderWidth = 1;
    [self.contentView addSubview:self.headerIView];
    self.mainLabel = [[UILabel alloc]init];
    self.mainLabel.frame = CGRectMake(10, self.headerIView.frame.size.height + self.headerIView.frame.origin.y + 5, kMainScreenWidth / 2 - 20, 40);
    self.mainLabel.numberOfLines = 0;
    self.mainLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
//    self.mainLabel.backgroundColor = [UIColor yellowColor];
//    self.mainLabel.textColor = [UIColor blueColor];
    self.mainLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.mainLabel];
    
    self.centerView = [[UIView alloc]init];
    self.centerView.frame = CGRectMake(5, self.mainLabel.frame.origin.y + self.mainLabel.frame.size.height + 5, kMainScreenWidth / 2 - 20, 20);
//    self.centerView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.centerView];
    
    self.goodIV = [[UIImageView alloc]init];
    self.goodIV.frame = CGRectMake(5, 5, 10, 10);
    self.goodIV.image = dPic_public_good;
    [self.centerView addSubview:self.goodIV];
    
    self.goodCountLbl = [[UILabel alloc]init];
    self.goodCountLbl.frame = CGRectMake(self.goodIV.frame.origin.x + self.goodIV.frame.size.width, 0, 100, 20);
    self.goodCountLbl.textAlignment = NSTextAlignmentLeft;
    self.goodCountLbl.text = @"100";
    self.goodCountLbl.font = [UIFont systemFontOfSize:12];
    self.goodCountLbl.textColor = [UIColor grayColor];
    [self.centerView addSubview:self.goodCountLbl];
    
    self.remarkLabel =[[UILabel alloc]init];
    self.remarkLabel.frame = CGRectMake(kMainScreenWidth/2 - 90, 0, 70, 20);
    self.remarkLabel.textAlignment = NSTextAlignmentRight;
//    self.remarkLabel.backgroundColor = [UIColor redColor];
    self.remarkLabel.text = @"评论:100";
    self.remarkLabel.font = [UIFont systemFontOfSize:12];
    self.remarkLabel.textColor = [UIColor grayColor];
    [self.centerView addSubview:self.remarkLabel];
    
    self.footerMainView = [[UIView alloc]init];
    self.footerMainView.frame = CGRectMake(0, self.mainLabel.frame.origin.y + self.mainLabel.frame.size.height + 5, kMainScreenWidth / 2 - 20, 40);
    [self.contentView addSubview:self.footerMainView];
    self.line = [[UIImageView alloc]init];
    self.line.image = dPic_waterfall_line;
    self.line.frame = CGRectMake(0, 0, kMainScreenWidth / 2 - 20, 1);
    [self.footerMainView addSubview:self.line];
    self.postMsgView = [[UIImageView alloc]init];
    self.postMsgView.image = [UIImage imageNamed:@"saga2.jpg"];
    self.postMsgView.frame = CGRectMake(5, 10, 20, 20);
    self.postMsgView.layer.masksToBounds = YES;
    self.postMsgView.layer.borderWidth = 1;
    self.postMsgView.layer.borderColor = [UIColor grayColor].CGColor;
    self.postMsgView.layer.cornerRadius = 2;
    [self.footerMainView addSubview:self.postMsgView];
    
    self.postMsgLabel = [[UILabel alloc]init];
    self.postMsgLabel.frame = CGRectMake(40, 5, 120, 30);
    self.postMsgLabel.text = @"晚睡姐姐";
    self.postMsgLabel.font = [UIFont systemFontOfSize:12];
    [self.footerMainView addSubview:self.postMsgLabel];
    
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
//    self.layer.cornerRadius = 6;
    self.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createContentView];
    }
    return self;
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
