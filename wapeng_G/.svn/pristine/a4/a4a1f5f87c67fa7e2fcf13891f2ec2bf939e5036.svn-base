//
//  FaceBg.m
//  svnTest
//
//  Created by 符杰 on 14-9-28.
//  Copyright (c) 2014年 FJ. All rights reserved.
//

#import "FaceBg.h"

#define kRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1];

@interface FaceBg()<UIScrollViewDelegate>
{
    UIScrollView  *_scroll;
    NSArray       *_allFace;
    UIPageControl *_page;
    int           _num;
}
@end

@implementation FaceBg

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGB(246, 246, 246);
        _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_scroll];
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.pagingEnabled = YES;
        _scroll.delegate = self;
        _scroll.contentSize = CGSizeMake(2 * frame.size.width, 0);
        _scroll.bounces = NO;
        
        _page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
        _page.center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.9);
        _page.numberOfPages = 2;
        _page.currentPageIndicatorTintColor = [UIColor blackColor];
        _page.pageIndicatorTintColor = [UIColor grayColor];
        [_page addTarget:self action:@selector(changePageNumber:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_page];
        
        _allFace = [NSArray array];
        _allFace = @[@"[呵呵].png",@"[高兴].png",@"[哈哈].png",@"[挤眼].png",@"[生气].png",@"[大怒].png",@"[口水].png",@"[害羞].png",@"[飞吻].png",@"[幸福].png",@"[泪].png",@"[呆].png",@"[汗].png",@"[鬼脸].png",@"[愁].png",@"[哀怨].png",@"[么么哒].png",@"[尖叫].png",@"[吐舌].png",@"[晕].png",@"回退",@"[傻眼].png",@"[不爽].png",@"[酣睡].png",@"[生病].png",@"[委屈].png",@"[鼓掌].png",@"[干杯].png",@"[赞].png",@"[反对].png",@"[耶].png",@"[加油].png",@"[OK].png",@"[心].png",@"[心碎].png",@"[阳光].png",@"[生快].png",@"[看].png",@"回退"];
        for (int i = 0; i < _allFace.count; i ++) {
            if (i / 7 <3) {
                //第一页
                [self addFaceBtn:_allFace[i] page:0 index:i];
            }else{
                //第二页
                [self addFaceBtn:_allFace[i] page:1 index:i];
            }
        }
    }
    return self;
}


-(void)changePageNumber:(UIPageControl *)sender{
    NSInteger index = sender.currentPage;
    [_scroll setContentOffset:CGPointMake(index * self.frame.size.width, 0) animated:YES]; //if animated is 'NO' animat don't implement
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _page.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

-(void)addFaceBtn:(NSString *)title page:(int)page index:(int)index{
    CGFloat width = self.frame.size.width / 7;
    CGFloat x = index % 7 * width + page * self.frame.size.width;
    CGFloat y = index / 7 > 2 ? ((index / 7 - 3) * width):(index / 7 * width);
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, width)];
    [btn setImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
    btn.highlighted = NO;
    btn.tag = index + 10;
    [btn addTarget:self action:@selector(faceBtnClick:) forControlEvents:UIControlEventTouchDown];
    [_scroll addSubview:btn];
}

-(void)faceBtnClick:(UIButton *)sender{
    NSString *str = _allFace[sender.tag - 10];
    //    [[NSNotificationCenter defaultCenter]postNotificationName:kFaceImgBtnClick object:str];
    [self.delegate faceViewSelect:str];
}


-(void)faceView{
    (_num % 2)?[self hideFaceView]:[self showFaceView];
    _num ++;
}

-(void)hideFaceView{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.frame;
        frame.origin.y += self.frame.size.height;
        self.frame = frame;
    }];
}

-(void)showFaceView{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.frame;
        frame.origin.y -= self.frame.size.height;
        self.frame = frame;
    }];
}


@end
