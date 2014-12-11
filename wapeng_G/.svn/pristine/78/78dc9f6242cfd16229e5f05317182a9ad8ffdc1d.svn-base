//
//  Cell_SellerActi3.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-13.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Cell_SellerActi3.h"
#import "UIColor+AddColor.h"
@implementation Cell_SellerActi3
-(void)createContentView
{
    self.mainView = [[UIImageView alloc]init];
    self.mainView.image = dPic_CellBGView;
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 10;
    self.mainView.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF"].CGColor;
    self.mainView.contentMode = UIViewContentModeScaleToFill;
    self.mainView.frame = CGRectMake(10, 4, 300, 120);
    
    [self.contentView addSubview:self.mainView];
    _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 6;
    _headerImage.layer.borderWidth = 0.5;
    _headerImage.layer.borderColor = [UIColor grayColor].CGColor;
    [self.mainView addSubview:_headerImage];
    
    self.userLabel = [[UILabel alloc]init];
    self.userLabel.frame = CGRectMake(_headerImage.frame.size.width + 20, 5, 200, 25);
    self.userLabel.textAlignment = NSTextAlignmentLeft;
    self.userLabel.font = [UIFont systemFontOfSize:12];
    self.userLabel.textColor = [UIColor grayColor];
    self.userLabel.text = @"user&name";
    //    self.userLabel.backgroundColor = [UIColor redColor];
    [self.mainView addSubview:self.userLabel];
    
    self.mainLabel = [[TQRichTextView alloc]init];
    self.mainLabel.backgroundColor = [UIColor whiteColor];
    self.mainLabel.font = [UIFont systemFontOfSize:15];
    self.mainLabel.frame = CGRectMake(_headerImage.frame.origin.x + _headerImage.frame.size.width + 20, 30, 120, 70);
//    self.mainLabel.numberOfLines = 2;
    self.mainLabel.text = @"岁月是把杀猪刀";
    [self.mainView addSubview:self.mainLabel];
//    self.mainLabel = [[FJFastTextView alloc]initWithFrame:CGRectMake(_headerImage.frame.origin.x + _headerImage.frame.size.width + 20, 40, kMainScreenWidth - 100, 60)];
//    self.mainLabel.backgroundColor = [UIColor whiteColor];
//    self.mainLabel.textColor = [UIColor blackColor];
//    self.mainLabel.textFont = [UIFont systemFontOfSize:14];
//    [self addSubview:self.mainLabel];
//    
    self.locationLabel = [[UILabel alloc]init];
    self.locationLabel.frame = CGRectMake(self.mainLabel.frame.origin.x + self.mainLabel.frame.size.width + 5 , self.mainLabel.frame.origin.y, 75, 40);
    //    self.locationLabel.backgroundColor = [UIColor redColor];
    self.locationLabel.textColor = [UIColor grayColor];
    self.locationLabel.numberOfLines = 2;
    self.locationLabel.font = [UIFont systemFontOfSize:12];
    [self.mainView addSubview:self.locationLabel];
    
    self.joinLabel = [[UILabel alloc]init];
    //    self.joinLabel.backgroundColor = [UIColor greenColor];
    self.joinLabel.frame = CGRectMake(self.mainLabel.frame.origin.x + self.mainLabel.frame.size.width + 5, self.locationLabel.frame.origin.y + self.locationLabel.frame.size.height + 5, 90, 30);
    self.joinLabel.text = @"28条回复";
    self.joinLabel.font = [UIFont systemFontOfSize:12];
    [self.mainView addSubview:self.joinLabel];
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
