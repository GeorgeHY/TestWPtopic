//
//  AgeTalkView.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-10.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "AgeTalkView.h"


@implementation AgeTalkView
{

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

-(void) createComponent{
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn = [[UIButton alloc]  initWithFrame:CGRectMake(10, 30 , self.frame.size.width/2 - 15, 25)];
    [btn  setBackgroundImage:[UIImage imageNamed:@"btn_age_newbaby.png"] forState:UIControlStateNormal];
    [btn  addTarget:self action:@selector(onClicklistener:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 100;
    [btn setTitle:@"新生儿（0~100天）" forState:UIControlStateNormal];
    [self  addSubview:btn];
    
    UIButton * btn2 = [[UIButton alloc]  initWithFrame:CGRectMake(self.frame.size.width/2 + 5, 30 , self.frame.size.width/2-15, 25)];
    [btn2  setBackgroundImage:[UIImage imageNamed:@"btn_age_small.png"] forState:UIControlStateNormal];
    [btn2  addTarget:self action:@selector(onClicklistener:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 101;
    [btn2 setTitle:@"3个月~1岁" forState:UIControlStateNormal];
    [self  addSubview:btn2];
    
    
    UIButton * btn3 = [[UIButton alloc]  initWithFrame:CGRectMake(10, 30+(40) , self.frame.size.width/2 - 15, 25)];
    [btn3  setBackgroundImage:[UIImage imageNamed:@"btn_age_young.png"] forState:UIControlStateNormal];
    [btn3  addTarget:self action:@selector(onClicklistener:) forControlEvents:UIControlEventTouchUpInside];
    btn3.tag = 102;
    [btn3 setTitle:@"1岁~2岁" forState:UIControlStateNormal];
    [self  addSubview:btn3];
    
    UIButton * btn4 = [[UIButton alloc]  initWithFrame:CGRectMake(self.frame.size.width/2 + 5, 30+(40) , self.frame.size.width/2-15, 25)];
    [btn4  setBackgroundImage:[UIImage imageNamed:@"btn_age_small.png"] forState:UIControlStateNormal];
    [btn4  addTarget:self action:@selector(onClicklistener:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tag = 103;
    [btn4 setTitle:@"2岁~3岁" forState:UIControlStateNormal];
    [self  addSubview:btn4];
    
    
    UIButton * btn5 = [[UIButton alloc]  initWithFrame:CGRectMake(10, 30+(40*2) , self.frame.size.width/2 - 15, 25)];
    [btn5  setBackgroundImage:[UIImage imageNamed:@"btn_age_child.png"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(onClicklistener:) forControlEvents:UIControlEventTouchUpInside];
    btn5.tag = 104;
    [btn5 setTitle:@"3岁~6岁" forState:UIControlStateNormal];
    [self  addSubview:btn5];
    
    UIButton * btn6 = [[UIButton alloc]  initWithFrame:CGRectMake(self.frame.size.width/2 + 5, 30+(40*2) , self.frame.size.width/2-15, 25)];
    [btn6  setBackgroundImage:[UIImage imageNamed:@"btn_age_little.png"] forState:UIControlStateNormal];
    [btn6  addTarget:self action:@selector(onClicklistener:) forControlEvents:UIControlEventTouchUpInside];
    btn6.tag = 105;
    [btn6 setTitle:@"6岁以上" forState:UIControlStateNormal];
    [self  addSubview:btn6];

}

-(void)onClicklistener:(UIButton *)b{
    switch (b.tag) {
        case 100:
            self.block(1);
            break;
        case 101:
            self.block(2);
            break;
        case 102:
                       self.block(3);
            break;
        case 103:
                   self.block(4);
            break;
        case 104:
                      self.block(5);
            break;
        case 105:
                       self.block(6);
            break;
            
        default:
            break;
    }
 
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
