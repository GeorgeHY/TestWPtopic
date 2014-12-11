//
//  FaceScrollVeiw.m
//  FaceViewDemo
//
//  Created by 心 猿 on 14-10-4.
//  Copyright (c) 2014年 心 猿. All rights reserved.
//
#define kMainScreenWidth 320
#import "FaceScrollVeiw.h"

@implementation FaceScrollVeiw

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadViews];
    }
    return self;
}
-(void)loadViews
{
    _faceVeiw = [[FaceView alloc]initWithFrame:CGRectZero];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, _faceVeiw.height)];
    _scrollView.contentSize = CGSizeMake(_faceVeiw.width, _faceVeiw.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled =YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_faceVeiw];
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _scrollView.frame.origin.y + _scrollView.frame.size.height, 320, 25)];
    _pageControl.backgroundColor = [UIColor whiteColor];
    _pageControl.numberOfPages = _faceVeiw.pageNumber;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
//    _pageControl.backgroundColor = [UIColor purpleColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:_pageControl];
    
    CGRect frame = self.frame;
    frame.size.height = _scrollView.frame.size.height + _pageControl.frame.size.height;
    frame.size.width = _scrollView.frame.size.width;
    self.frame = frame;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   int pageNum = scrollView.contentOffset.x / kMainScreenWidth;
    _pageControl.currentPage = pageNum;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
