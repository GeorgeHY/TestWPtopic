//
//  WindowHeaderView.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-12.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "WindowHeaderView.h"

@implementation WindowHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}
+(instancetype)instanceView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WindowHeaderView" owner:nil options:nil]lastObject];
}
#pragma mark - 动态改变心情的高度
//-(void)layoutSubviews
//{
//    CGRect frame = self.momentCountLbl.frame;
//    
//    frame.origin.y = CGRectGetMaxY(self.emotionLbl.frame) + 20;
//    
//    self.momentCountLbl.frame = frame;
//    
//    frame = self.focusCountLbl.frame;
//    
//    frame.origin.y = CGRectGetMaxY(self.emotionLbl.frame) + 20;
//    
//    self.focusCountLbl.frame = frame;
//    
//    frame = self.fansLbl.frame;
//    
//    frame.origin.y = CGRectGetMaxY(self.emotionLbl.frame) + 20;
//    
//    self.fansLbl.frame = frame;
//    
//    frame = self.momentBtn.frame;
//    frame.origin.y = CGRectGetMaxY(self.momentCountLbl.frame) + 5;
//    self.momentBtn.frame = frame;
//    
//    frame = self.GoFansBtn.frame;
//    frame.origin.y = CGRectGetMaxY(self.momentCountLbl.frame) + 5;
//    self.momentBtn.frame = frame;
//    
//    frame = self.GoFocusBtn.frame;
//    
//     frame.origin.y = CGRectGetMaxY(self.momentCountLbl.frame) + 5;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
