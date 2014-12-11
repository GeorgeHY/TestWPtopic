//
//  Cell_ShowRemark.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Cell_ShowRemark.h"

@implementation Cell_ShowRemark


-(void)createContentView
{
    self.remarkLbl = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(70, 5, kMainScreenWidth - 80, 35)];
    self.remarkLbl.numberOfLines = 0;
    self.remarkLbl.font = [UIFont systemFontOfSize:20];
//    self.remarkLbl.backgroundColor = [UIColor greenColor];
    
//    self.timeLbl = [UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.remarkLbl.firstLineIndent), <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    [self.contentView addSubview:self.remarkLbl];
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




@end
