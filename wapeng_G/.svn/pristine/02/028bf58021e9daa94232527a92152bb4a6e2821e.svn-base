//
//  LoadingDialog.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-14.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "LoadingDialog.h"

@implementation LoadingDialog



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)creatComponent{
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    self.layer.borderWidth = 10;
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;//超出界面的view将不再显示
    self.backgroundColor = [UIColor whiteColor];
    loading= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    loading.color = [UIColor greenColor]; // 改变圈圈的颜色
    loading.frame = CGRectMake(self.frame.size.width/2, self.frame.size.height/2 - 25, 0, 0);
    [self  addSubview:loading];
    UILabel * titleL = [[UILabel alloc]  initWithFrame:CGRectMake(self.frame.size.width/2 -50, self.frame.size.height/2, 100, 20)];
    titleL.text = @"正在加载请稍后……";
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:titleL];
    control = [[UIControl alloc]  initWithFrame:[[UIScreen mainScreen] bounds]];
    control.backgroundColor =  [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    [control  addTarget:self action:@selector(onTochListeren)  forControlEvents:UIControlEventTouchUpInside];
}
-(void)onTochListeren{
    [self  dismissDialog];
}
-(void)showDialog
{
    [loading  startAnimating];
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];

    [keyWindow addSubview:control];
    [keyWindow addSubview:self];
    [self  fadeIn];
}
-(void)dismissDialog
{
    [loading stopAnimating];
    [control removeFromSuperview];
    [self removeFromSuperview];
}

- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}



@end
