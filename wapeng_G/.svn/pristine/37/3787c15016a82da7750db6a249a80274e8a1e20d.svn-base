//
//  RichLabelView.m
//  LabelText
//
//  Created by 心 猿 on 14-10-23.
//  Copyright (c) 2014年 心 猿. All rights reserved.
//
//#define kMaxX 280
//#define kSpaceX 5
#define kSpaceY 44
#import "RichLabelView.h"
#import "UIView+WhenTappedBlocks.h"
@implementation RichLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame nameArr:(NSArray *)arr
{
    if (self = [super initWithFrame:frame]) {
        
        _xSpace = 5;
        //获取坐标，x, y ,width 不变 height会变化
        mFrame = frame;
        maxWidth = mFrame.size.width;
        [self createRichLabel:arr];
    }
    
    return self;
}
/**

 **/
-(void)createRichLabel:(NSArray *)arr
{
    NSMutableArray * sizeArr = [[NSMutableArray alloc]init];
    
    CGFloat ySpace = [self getSizeWithString:arr[0]].height;
    
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0; i < arr.count; i++) {
        
        CGSize size = [self getSizeWithString:arr[i]];
        
        if (x + size.width + _xSpace > maxWidth ) {
            
            x = 0;
            
            y += ySpace;
        }
        
        NSValue * value = [NSValue valueWithCGRect:CGRectMake(x, y, size.width, size.height)];
        [sizeArr addObject:value];
        
        //计算label的横坐标
        x += (size.width + _xSpace);
        
    }
    
    for (int i = 0; i < sizeArr.count; i++) {
        
        UILabel * label = [[UILabel alloc]init];
        
        label.text = arr[i];
        
        label.font = [UIFont systemFontOfSize:15];

        
        label.textColor = [UIColor blueColor];
        
        CGRect frame = [[sizeArr objectAtIndex:i] CGRectValue];
        
        label.frame = frame;
        
        [label whenTouchedDown:^{
            
            NSLog(@"改变label颜色");
            label.backgroundColor  = [UIColor grayColor];
        }];
        
        [label whenTouchedUp:^{
            
            label.backgroundColor = [UIColor whiteColor];
            NSLog(@"颜色变回白色");
            
        }];
        
        
        [self addSubview:label];
    }
    
    CGRect frame = self.frame;
    frame.size.height = y + [self getSizeWithString:arr[0]].height;

    self.frame = frame;
}


-(CGSize)getSizeWithString:(NSString *)content
{
    CGSize size = [content boundingRectWithSize:CGSizeMake(280, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
    return size;
}

@end
