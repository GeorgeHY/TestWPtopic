//
//  HotTopicTVCell.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "HotTopicTVCell.h"

@implementation HotTopicTVCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        self.contentView.backgroundColor = [UIColor grayColor];
        self.contentView.backgroundColor = kRGB(237, 237, 237);
        //        self.contentView.backgroundColor = [UIColor clearColor];
        
        UIImageView *bg = [[UIImageView alloc]  initWithFrame:CGRectMake(8, 0, self.contentView.frame.size.width - 16, 100)];
        bg.image = [UIImage imageNamed:@"cellBGView.png"];
        [self.contentView addSubview:bg];
        
        //        self.v = [[UIView alloc]  initWithFrame:CGRectMake(10, 5, 100, 20)];
        //        UILabel * top = [[UILabel alloc]  initWithFrame:CGRectMake(12, 0, 29, 20)];
        //        top.text = @"TOP ";
        //        top.font = [UIFont systemFontOfSize:14];
        //        top.textColor = [UIColor redColor];
        //        [self.v addSubview:top];
        //
        //        self.topLable = [[UILabel alloc]  initWithFrame:CGRectMake(42, 0, 60, 20)];
        //        self.topLable.textColor = [UIColor redColor];
        //        self.topLable.font = [UIFont systemFontOfSize:14];
        //        [self.v addSubview:self.topLable];
        //        [self.contentView  addSubview:self.v];
        
        
        
        //
        //        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30,self.contentView.frame.size.width - 20, 1 )];
        //        image.image = [UIImage imageNamed:@"line.png"];
        //        [self.contentView  addSubview:image];
        
        self.contentLable = [[TQRichTextView alloc]  initWithFrame:CGRectMake(10, 20, 90, 20)];
        self.contentLable.backgroundColor = [UIColor whiteColor];
        self.contentLable.font = [UIFont systemFontOfSize:18];
        //        self.contentLable.numberOfLines = 0;
        //        self.contentLable.lineBreakMode = NSLineBreakByCharWrapping;
        [bg  addSubview:self.contentLable];
        
        self.headImageView = [[UIImageView alloc]  initWithFrame:CGRectMake(bg.frame.size.width - 90, 10 , 60, 60)];
        self.headImageView.image = [UIImage imageNamed:@"2.png"];
        [bg addSubview:self.headImageView];
        
        self.nameLable = [[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 70, 20)];
        self.nameLable.center = CGPointMake(CGRectGetMaxX(self.headImageView.frame) - 30, CGRectGetMaxY(self.headImageView.frame) + 10);
        self.nameLable.font = [UIFont systemFontOfSize:15];
        self.nameLable.textAlignment = NSTextAlignmentCenter;
        [bg addSubview:self.nameLable];
        
        
        CGFloat y = CGRectGetMaxY(self.contentLable.frame) + 30;
        UILabel * hui = [[UILabel alloc]  initWithFrame:CGRectMake(10, y, 28, 20)];
        hui.text = @"回复:";
        //        CGSize size = [hui.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 17) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:Nil].size;
        hui.font = [UIFont systemFontOfSize:12];
        //        hui.backgroundColor = [UIColor redColor];
        [bg addSubview:hui];
        self.replyLable = [[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(hui.frame), y, 50, 20)];
        self.replyLable.font = [UIFont systemFontOfSize:12];
        [bg addSubview:self.replyLable];
        UILabel * ren = [[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(self.replyLable.frame), y, 28, 20)];
        ren.text = @"熟人:";
        ren.font = [UIFont systemFontOfSize:12];
        [bg  addSubview:ren];
        
        self.personLable = [[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(ren.frame), y, 30, 20)];
        self.personLable.font = [UIFont systemFontOfSize:12];
        [bg  addSubview:self.personLable];
        
    }
    return self;
}

-(void)setLableTopSize{
    self.topLable.frame = CGRectMake(7, 0, 100, 20);
    [self.topLable  setTextColor:[
                                  UIColor blackColor]];
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
