//
//  Cell_SellerAciti.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-3.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Cell_SellerAciti.h"
#import "UIColor+AddColor.h"
#import "UIImage+Stretch.h"
@implementation Cell_SellerAciti

-(void)createContentView
{
    self.backgroundColor = kRGB(242, 242, 242);
    self.mainView = [[UIImageView alloc]init];
    self.mainView.image = [UIImage resizedImage:@"figure1"];
    self.mainView.frame = CGRectMake(10, 4, kMainScreenWidth - 2 *10, 92);
    self.markImageView = [[UIImageView alloc]init];
    self.markImageView.frame = CGRectMake(275, 0, 25, 25);
    [self.mainView addSubview:self.markImageView];
    
    [self.contentView addSubview:self.mainView];
    _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 6;
    _headerImage.layer.borderWidth = 0.5;
    _headerImage.layer.borderColor = [UIColor grayColor].CGColor;
    [self.mainView addSubview:_headerImage];
    
    self.userLabel = [[UILabel alloc]init];
    self.userLabel.frame = CGRectMake(_headerImage.frame.origin.x + _headerImage.frame.size.width + 20, 15, 200, 25);
    self.userLabel.textAlignment = NSTextAlignmentLeft;
    self.userLabel.font = [UIFont systemFontOfSize:12];
    self.userLabel.textColor = [UIColor grayColor];
    [self.mainView addSubview:self.userLabel];
    
    self.mainLabel = [[TQRichTextView alloc]init];
    self.mainLabel.backgroundColor = [UIColor whiteColor];
    self.mainLabel.font = [UIFont systemFontOfSize:15];
    self.mainLabel.font = [UIFont systemFontOfSize:14];
    self.mainLabel.frame = CGRectMake(_headerImage.frame.origin.x + _headerImage.frame.size.width + 20, 40, 120, 70);
//    self.mainLabel.numberOfLines = 2;
//    [self.mainView addSubview:self.mainLabel];
//    self.mainLabel = [[FJFastTextView alloc]initWithFrame:CGRectMake(_headerImage.frame.origin.x + _headerImage.frame.size.width + 20, 40, kMainScreenWidth - 100, 60)];
//    self.mainLabel.backgroundColor = [UIColor whiteColor];
//    self.mainLabel.textColor = [UIColor blackColor];
//    self.mainLabel.textFont = [UIFont systemFontOfSize:14];
//    [self addSubview:self.mainLabel];
   
    self.positionIV = [[UIImageView alloc]init];
    self.positionIV.frame = CGRectMake(CGRectGetMaxX(self.mainLabel.frame) + 5, 20, 15, 15);
//    self.positionIV.center = CGPointMake(CGRectGetMaxX(self.mainLabel.frame) + 20, self.mainLabel.frame.origin.y + self.mainLabel.frame.size.height * 0.5);
    self.positionIV.image = dPic_Public_position;
    [self.mainView addSubview:self.positionIV];
    
    self.locationLabel = [[UILabel alloc]init];
    self.locationLabel.frame = CGRectMake(self.mainLabel.frame.origin.x + self.mainLabel.frame.size.width + 5 + 15, self.positionIV.frame.origin.y - 7, 75, 30);
//    self.locationLabel.backgroundColor = [UIColor redColor];
    //    self.locationLabel.backgroundColor = [UIColor redColor];
    self.locationLabel.textColor = [UIColor grayColor];
    //    self.locationLabel.text = @"100米";
    self.locationLabel.textAlignment = NSTextAlignmentCenter;
    self.locationLabel.font = [UIFont systemFontOfSize:12];
    [self.mainView addSubview:self.locationLabel];
    
    
    self.joinLabel = [[UILabel alloc]init];
//    self.joinLabel.backgroundColor = [UIColor greenColor];
    self.joinLabel.frame = CGRectMake(self.mainLabel.frame.origin.x + self.mainLabel.frame.size.width + 5, self.locationLabel.frame.origin.y + self.locationLabel.frame.size.height + 15, 90, 30);
    self.joinLabel.text = @"30位熟人参与";
    self.joinLabel.font = [UIFont systemFontOfSize:12];
    [self.mainView addSubview:self.joinLabel];
    
}

-(void)layoutSubviews
{
    
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
