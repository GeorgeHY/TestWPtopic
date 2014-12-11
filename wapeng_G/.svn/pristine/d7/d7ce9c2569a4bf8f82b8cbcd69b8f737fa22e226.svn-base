//
//  HotTopicTopTenCell.m
//  if_wapeng
//
//  Created by 符杰 on 14-10-21.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "HotTopicTopTenCell.h"

@implementation HotTopicTopTenCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        self.contentView.backgroundColor = [UIColor grayColor];
        self.contentView.backgroundColor = kRGB(237, 237, 237);
        UIImageView *bg = [[UIImageView alloc]  initWithFrame:CGRectMake(8, 0, self.contentView.frame.size.width - 16, 115)];
        bg.image = [UIImage imageNamed:@"cellBGView.png"];
        [self.contentView addSubview:bg];
        
        
//        self.v = [[UIView alloc]  initWithFrame:CGRectMake(5, 2, 100, 20)];
//        UILabel * top = [[UILabel alloc]  initWithFrame:CGRectMake(12, 0, 29, 20)];
//        top.text = @"TOP:";
//        top.font = [UIFont systemFontOfSize:15];
//        top.textColor = [UIColor yellowColor];
//        [self.v addSubview:top];

        self.topLable = [[UILabel alloc]  initWithFrame:CGRectMake(7, 2, 70, 20)];
        self.topLable.textColor = [UIColor yellowColor];
        self.topLable.font = [UIFont systemFontOfSize:15];
        [bg addSubview:self.topLable];
//        [bg  addSubview:self.v];

        CGFloat y = 3;
        UILabel * hui = [[UILabel alloc]  initWithFrame:CGRectMake(bg.frame.size.width * 0.5, y, 28, 20)];
        hui.text = @"回复:";
//        CGSize size = [hui.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 17) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:Nil].size;
        hui.font = [UIFont systemFontOfSize:12];
//        hui.backgroundColor = [UIColor redColor];
        [bg addSubview:hui];
        self.replyLable = [[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(hui.frame), y, 40, 20)];
        self.replyLable.font = [UIFont systemFontOfSize:12];
        [bg addSubview:self.replyLable];
        UILabel * ren = [[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(self.replyLable.frame), y, 28, 20)];
        ren.text = @"熟人:";
        ren.font = [UIFont systemFontOfSize:12];
        [bg  addSubview:ren];
        
        self.personLable = [[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(ren.frame), y, 40, 20)];
        self.personLable.font = [UIFont systemFontOfSize:12];
        [bg  addSubview:self.personLable];

//
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topLable.frame) + 4,bg.frame.size.width, 1)];
        image.image = [UIImage imageNamed:@"cutlinehot"];
        [bg  addSubview:image];
        
        self.contentLable = [[TQRichTextView alloc]  initWithFrame:CGRectMake(10, CGRectGetMaxY(image.frame) + 10, 90, 22)];
        self.contentLable.backgroundColor = [UIColor whiteColor];
        self.contentLable.font = [UIFont systemFontOfSize:18];
        //        self.contentLable.numberOfLines = 0;
        //        self.contentLable.lineBreakMode = NSLineBreakByCharWrapping;
        [bg  addSubview:self.contentLable];
        
        self.headImageView = [[UIImageView alloc]  initWithFrame:CGRectMake(bg.frame.size.width - 90, CGRectGetMaxY(image.frame), 60, 60)];
        self.headImageView.image = [UIImage imageNamed:@"2.png"];
        [bg addSubview:self.headImageView];
        
        self.nameLable = [[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 70, 20)];
        self.nameLable.center = CGPointMake(CGRectGetMaxX(self.headImageView.frame) - 30, CGRectGetMaxY(self.headImageView.frame) + 10);
        self.nameLable.textAlignment = NSTextAlignmentCenter;
        self.nameLable.font = [UIFont systemFontOfSize:15];
        [bg addSubview:self.nameLable];
        
        NSLog(@"frame  ---- %f",CGRectGetMaxY(self.nameLable.frame));
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}
@end

