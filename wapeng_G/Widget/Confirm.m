//
//  Confirm.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-29.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Confirm.h"

@implementation Confirm
{
    UIControl * control;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createComponent];
    }
    return self;
}

-(void)createComponent{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[UIColor grayColor]  CGColor];
    self.layer.borderWidth = 10;
    self.layer.cornerRadius = 10;
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.frame.size.width - 40, 30)];
    self.title.text = @"您是否删除此条信息";
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.textColor = [UIColor blackColor];
    [self addSubview:self.title];
    
    self.confirm = [[UIButton alloc]  initWithFrame:CGRectMake(20, self.title.frame.origin.y+self.title.frame.size.height + 5, 60, 30)];
    self.confirm.tag = 100;
    [self.confirm  addTarget:self action:@selector(onTouchListener:) forControlEvents:UIControlEventTouchUpInside];
    [self.confirm  setTitle:@"确定" forState:UIControlStateNormal];
    self.confirm.backgroundColor = [UIColor greenColor];
    self.confirm.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.confirm];
    self.end = [[UIButton alloc]  initWithFrame:CGRectMake(self.frame.size.width-20-60,self.title .frame.origin.y + self.title.frame.size.height + 5, 60, 30)];
    self.end.tag = 101;
    [self.end  setTitle:@"返回" forState:UIControlStateNormal];
    self.end.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.end.backgroundColor = [UIColor redColor];
    [self.end  addTarget:self action:@selector(onTouchListener:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.end];
    
    control = [[UIControl alloc]  init];
    control.frame = [[UIScreen mainScreen]  bounds];
    control.backgroundColor = [UIColor grayColor];
    control.alpha = 0.7;

}
-(void)onTouchListener:(UIButton *)b{
    if (b.tag == 100) {
        self.block(TouchConfirm);
    }else{
        self.block(TouchEnd);
    }
    [self animationEnd];
}

-(void)showDialog{
    UIWindow *window = [[UIApplication sharedApplication]  keyWindow];
    [window addSubview:control];
    [window addSubview:self];
    [self animationStart];
}

-(void)animationStart
{
    self.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.alpha = 0.0;
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1;
    }];
}
-(void)animationEnd
{
    self.transform = CGAffineTransformMakeScale(1, 1);
    self.alpha = 1;
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [control  removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

@end
