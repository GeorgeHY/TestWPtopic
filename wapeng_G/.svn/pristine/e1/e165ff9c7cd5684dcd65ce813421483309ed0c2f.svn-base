//
//  DialogView.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-11.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "DialogView.h"

static DialogView * _dialogView;



@implementation DialogView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _frame = frame;
        [self createCustomView];
    }
    return self;
}
+(id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _dialogView = [super allocWithZone:zone];
    });
    return _dialogView;
}
+(instancetype)shareInstance
{
    _dialogView = [[DialogView alloc]initWithFrame:CGRectMake(kMainScreenWidth/ 2 - 100, kMainScreenHeight / 2 - 32 - 110, 120, 40 * 5)];
    CGPoint center = _dialogView.center;
    center.x = kMainScreenWidth * 0.5;
    _dialogView.center = center;
    return _dialogView;
}

-(void)createCustomView
{
    self.arr_title = @[@"回复", @"收藏", @"复制", @"举报", @"删除"];
    self.arr_image = @[@"replay.png",@"collect.png",@"copy.png",@"report.png",@"delete.png"];
    
    
    self.control = [[UIControl alloc]  initWithFrame:[[UIScreen mainScreen]  bounds]];
    self.control.alpha  = 0.5;
    self.control.backgroundColor = [UIColor grayColor];
    self.keywindow = [[UIApplication sharedApplication] keyWindow];
    [self.control  addTarget:self action:@selector(onTouchWindon) forControlEvents:UIControlEventTouchUpInside];
    [self.keywindow  addSubview:self.control];
    [self.keywindow addSubview:self];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 6;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    CGRect frame = _frame;

    frame.origin = CGPointMake(0, 0);
    
    _tableView = [[UITableView alloc]initWithFrame:frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self addSubview:_tableView];
    
   
}

-(void)onTouchWindon{
    [self.control  removeFromSuperview];
    [self removeFromSuperview];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [_arr_title count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.backgroundColor = kRGB(19, 19, 19);
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [_arr_title objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[_arr_image objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.alpha = 1;
    self.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
       self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        self.block(indexPath.row);
        [self.control  removeFromSuperview];
        [self removeFromSuperview];
    }];
   
}
@end
