//
//  FaceScrollVeiw.h
//  FaceViewDemo
//
//  Created by 心 猿 on 14-10-4.
//  Copyright (c) 2014年 心 猿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"
@interface FaceScrollVeiw : UIView<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    FaceView * _faceVeiw;
    UIPageControl * _pageControl;
}
@property (nonatomic, strong) FaceView * faceView;
@end
