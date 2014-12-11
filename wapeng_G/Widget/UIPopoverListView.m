//
//  UIPopoverListView.m
//  UIPopoverListViewDemo
//
//  Created by su xinde on 13-3-13.
//  Copyright (c) 2013年 su xinde. All rights reserved.
//

#import "UIPopoverListView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+AddColor.h"
//#define FRAME_X_INSET 20.0f
//#define FRAME_Y_INSET 40.0f

@interface UIPopoverListView ()
- (void)fadeIn;
- (void)fadeOut;

@end

@implementation UIPopoverListView

@synthesize datasource = _datasource;
@synthesize delegate = _delegate;

@synthesize listView = _listView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)defalutInit:(UIView * )v
{
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 1.0f;//设置边框的宽度，当然可以不要
    self.layer.cornerRadius = 10.0f;//设置圆角
    self.clipsToBounds = YES;
    self.v = v;
    [self addSubview:self.v];
    CGRect tableFrame =
    CGRectMake(0,self.v.bounds.size.height,
               self.bounds.size.width,
               self.bounds.size.height-self.v.bounds.size.height);
    
    _listView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    _listView.dataSource = self;
    _listView.delegate = self;
    [self addSubview:_listView];
    
    _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    [_overlayView addTarget:self
                     action:@selector(dismiss)
           forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.datasource &&
       [self.datasource respondsToSelector:@selector(popoverListView:numberOfRowsInSection:)])
    {
        return [self.datasource popoverListView:self numberOfRowsInSection:section];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.datasource &&
       [self.datasource respondsToSelector:@selector(popoverListView:cellForIndexPath:)])
    {
        return [self.datasource popoverListView:self cellForIndexPath:indexPath];
    }
    return nil;
}

-(void) reloadData{
    [_listView  reloadData];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(popoverListView:heightForRowAtIndexPath:)])
    {
        return [self.delegate popoverListView:self heightForRowAtIndexPath:indexPath];
    }
    
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(popoverListView:didSelectIndexPath:)])
    {
        [self.delegate popoverListView:self didSelectIndexPath:indexPath];
    }
    
//    [self dismiss];
}


#pragma mark - animations

- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
- (void)fadeOut
{
    [self.delegate onTouchEvent];
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [_overlayView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    [self fadeIn];
}



- (void)dismiss
{
    [self fadeOut];
}

//#define mark - UITouch
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.delegate  onTouchEvent];
//    // tell the delegate the cancellation
//    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListViewCancel:)]) {
//        [self.delegate popoverListViewCancel:self];
//    }
//    
//    // dismiss self
//    [self dismiss];
//}



//
// draw round rect corner
//
/*
 - (void)drawRect:(CGRect)rect
 {
 CGContextRef c = UIGraphicsGetCurrentContext();
 CGContextSetFillColorWithColor(c, [_fillColor CGColor]);
 CGContextSetStrokeColorWithColor(c, [_borderColor CGColor]);
 
 CGContextBeginPath(c);
 addRoundedRectToPath(c, rect, 10.0f, 10.0f);
 CGContextFillPath(c);
 
 CGContextSetLineWidth(c, 1.0f);
 CGContextBeginPath(c);
 addRoundedRectToPath(c, rect, 10.0f, 10.0f);
 CGContextStrokePath(c);
 }
 
 
 static void addRoundedRectToPath(CGContextRef context, CGRect rect,
 float ovalWidth,float ovalHeight)
 
 {
 float fw, fh;
 
 if (ovalWidth == 0 || ovalHeight == 0) {// 1
 CGContextAddRect(context, rect);
 return;
 }
 
 CGContextSaveGState(context);// 2
 
 CGContextTranslateCTM (context, CGRectGetMinX(rect),// 3
 CGRectGetMinY(rect));
 CGContextScaleCTM (context, ovalWidth, ovalHeight);// 4
 fw = CGRectGetWidth (rect) / ovalWidth;// 5
 fh = CGRectGetHeight (rect) / ovalHeight;// 6
 
 CGContextMoveToPoint(context, fw, fh/2); // 7
 CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);// 8
 CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);// 9
 CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);// 10
 CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // 11
 CGContextClosePath(context);// 12
 
 CGContextRestoreGState(context);// 13
 }
 */

@end
