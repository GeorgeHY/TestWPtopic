//
//  Cell_SellerAciti2.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Cell_SellerAciti2.h"
#import "UIColor+AddColor.h"
#import "UIImage+Stretch.h"

@implementation Cell_SellerAciti2
-(void)createContentView
{
//    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"waterfall_top"]];
    self.backgroundColor = kRGB(242, 242, 242);
    self.mainView = [[UIImageView alloc]init];
    self.mainView.image = [UIImage resizedImage:@"figure1"];
    self.mainView.layer.masksToBounds = YES;
////    self.mainView.layer.cornerRadius = 5;
//    self.mainView.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF"].CGColor;
    self.mainView.contentMode = UIViewContentModeScaleToFill;
    self.mainView.frame = CGRectMake(10, 5, kMainScreenWidth - 20, 120);
//    self.mainView.backgroundColor = [UIColor redColor];
    //    self.mainView.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:self.mainView];
    
    self.headerMainView = [[UIView alloc]init];
    self.headerMainView.frame = CGRectMake(0, 0, kMainScreenWidth - 20, 30);
    [self.mainView addSubview:self.headerMainView];
    self.topLabel = [[UILabel alloc]init];
    self.topLabel.text = @"TOP1";
    self.topLabel.textColor = [UIColor redColor];
    self.topLabel.frame = CGRectMake(15, 5, 70, 25);
    [self.headerMainView addSubview:self.topLabel];
    
    self.replayLabel = [[UILabel alloc]init];
    self.replayLabel.frame = CGRectMake(kMainScreenWidth / 4 + 10, 5, 100, 20);
    self.replayLabel.font = [UIFont systemFontOfSize:12];
    self.replayLabel.textColor = [UIColor grayColor];
    self.replayLabel.text = @"回复100";
    [self.headerMainView addSubview:self.replayLabel];
    
    self.firlabel = [[UILabel alloc]init];
    self.firlabel.frame = CGRectMake(kMainScreenWidth / 4 + 100, 5, 100, 20);
    self.firlabel.text = @"熟人100";
    self.firlabel.textColor = [UIColor grayColor];
    self.firlabel.font = [UIFont systemFontOfSize:12];
    [self.headerMainView addSubview:self.firlabel];
    
    [self.mainView addSubview:self.headerMainView];
    
    self.line = [[UIImageView alloc]init];
    self.line.frame = CGRectMake(0, 30, kMainScreenWidth - 20, 1);
    self.line.image = dPic_dot_line;
    [self.headerMainView addSubview:self.line];
    
    _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 50, 50)];
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 6;
    _headerImage.layer.borderWidth = 0.5;
    _headerImage.layer.borderColor = [UIColor grayColor].CGColor;
    [self.mainView addSubview:_headerImage];
    
    self.userLabel = [[UILabel alloc]init];
    self.userLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImage.frame) + 20, CGRectGetMidY(self.headerImage.frame) - 30, 200, 25);
    self.userLabel.textAlignment = NSTextAlignmentLeft;
    self.userLabel.font = [UIFont systemFontOfSize:12];
    self.userLabel.textColor = [UIColor grayColor];
    self.userLabel.text = @"user&name";
    //    self.userLabel.backgroundColor = [UIColor redColor];
    [self.mainView addSubview:self.userLabel];
    
    self.mainLabel = [[TQRichTextView alloc]init];
    self.mainLabel.backgroundColor = [UIColor whiteColor];
    self.mainLabel.font = [UIFont systemFontOfSize:15];
    self.mainLabel.frame = CGRectMake(_headerImage.frame.origin.x + _headerImage.frame.size.width + 20, CGRectGetMaxY(self.userLabel.frame) + 10, kMainScreenWidth - 100, 70);
    self.mainLabel.text = @"二手闲置物品";
//    self.mainLabel.numberOfLines = 2;
    [self.mainView addSubview:self.mainLabel];
//    self.mainLabel = [[FJFastTextView alloc]initWithFrame:CGRectMake(_headerImage.frame.origin.x + _headerImage.frame.size.width + 20, 40, kMainScreenWidth - 100, 60)];
//    self.mainLabel.backgroundColor = [UIColor whiteColor];
//    self.mainLabel.textColor = [UIColor blackColor];
//    self.mainLabel.textFont = [UIFont systemFontOfSize:14];
//    [self addSubview:self.mainLabel];
    self.detailLabel = [[UILabel alloc]init];
    self.detailLabel.frame = CGRectMake(self.mainLabel.frame.origin.x, self.mainLabel.frame.origin.y + self.mainLabel.frame.size.height + 5, 120, 30);
    self.detailLabel.textColor = [UIColor grayColor];
    self.detailLabel.font = [UIFont systemFontOfSize:12];
    self.detailLabel.text = @"[活动招募]xxxxxx";
//    [self.mainView addSubview:self.detailLabel];
    
    [self.contentView addSubview:self.mainView];
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
