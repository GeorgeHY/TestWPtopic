//
//  BabyAdView.h
//  if_wapeng
//
//  Created by 心 猿 on 14-9-15.
//  Copyright (c) 2014年 funeral. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface BabyAdView : UIView<UIScrollViewDelegate>
{
    CGRect _rect;
}
@property (nonatomic, strong) UIScrollView * scrollView;//滚动视图

-(void)imageUrlArray:(NSArray *)array;
@end
