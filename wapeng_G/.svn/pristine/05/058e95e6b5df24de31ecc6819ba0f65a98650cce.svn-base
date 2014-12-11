//
//  BabyAdView.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-15.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "BabyAdView.h"
#import "UIImageView+WebCache.h"
@implementation BabyAdView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _rect = frame;
    }
    return self;
}
-(void)imageUrlArray:(NSArray *)array
{
    _scrollView = [[UIScrollView alloc]init];
    
    CGRect frame = _rect;
    frame.origin.x = 0;
    frame.origin.y = 0;
    CGFloat height = frame.size.height;
    CGFloat width = frame.size.width;
    _scrollView.frame = frame;
    
    _scrollView.contentSize = CGSizeMake(array.count * width, height);
    
//    _scrollView.delegate = self;
    
    _scrollView.pagingEnabled = YES;
    
    [self addSubview:_scrollView];
    
    for (int i = 0; i < array.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc]init];
        
        imageView.frame = CGRectMake(i * width, 0, width, height);
        
        NSURL * url = [NSURL URLWithString:[array objectAtIndex:i ]];
        
        [imageView setImageWithURL:url placeholderImage:nil];
        
        [_scrollView addSubview:imageView];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
@end
