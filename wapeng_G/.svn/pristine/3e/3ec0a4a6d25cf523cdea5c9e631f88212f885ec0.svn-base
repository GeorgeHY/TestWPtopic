//
//  FaceView.m
//  FaceViewDemo
//
//  Created by 心 猿 on 14-10-3.
//  Copyright (c) 2014年 心 猿. All rights reserved.
//
#define dTagFaceItem 100
#define kMainScreenWidth 320
#define kMainScreenHeight 480
#define item_width 42
#define item_height 45
#import "FaceView.h"

@implementation FaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadData];
        
        self.pageNumber = [_items count];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
/*
 行：row = 4;
 列：colum  = 7
 */
/*
 items = [
             ["表情1"，"表情2"，"表情3"，"表情4"，"表情5"，"表情6"，"表情7"...[表情28]]，
 
            ["表情1"，"表情2"，"表情3"，"表情4"，"表情5"，"表情6"，"表情7"...[表情28]]
        ];
 */
-(void)loadData
{
    _items = [[NSMutableArray alloc]init];
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"plist"];
    //整理表情，整理为一个二维数组
    NSArray * fileArray = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray * items2D = nil;
    for (int i = 0; i < fileArray.count; i++) {
        
        NSDictionary * item = [fileArray objectAtIndex:i];
        if (i % 28 == 0) {
            
            items2D = [[NSMutableArray alloc]initWithCapacity:28];
            [_items addObject:items2D];
        }
        [items2D addObject:item];
    }
    NSLog(@"%@", _items);
    
    self.width = [_items count] * kMainScreenWidth;
    self.height = 4 * item_height + 10;
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.width, self.height);
    self.frame = frame;
    
    //初始化放大镜
//    _magnifierView  =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 92)];
//    _magnifierView.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier"];
//    _magnifierView.hidden = YES;
//    _magnifierView.backgroundColor = [UIColor clearColor];
//    [self addSubview:_magnifierView];
//    
//    UIImageView * faceItem = [[UIImageView alloc]initWithFrame:CGRectMake((64 - 30) / 2,  15, 30, 30)];
//    faceItem.tag = dTagFaceItem;
//    [_magnifierView addSubview:faceItem];
}
- (void)drawRect:(CGRect)rect
{
    //定义行列
    int row = 0;
    int colum = 0;
    for (int i = 0; i < [_items count]; i++) {
        
        NSArray * items2D = [_items objectAtIndex:i];
        
        for (int j = 0; j < [items2D count]; j++) {
            
            NSDictionary * item = [items2D objectAtIndex:j];
            NSString * imageName = [item objectForKey:@"meaning"];
            UIImage * image = [UIImage imageNamed:imageName];
            
            
            CGRect frame = CGRectMake(colum * item_width + i * kMainScreenWidth + 15, row * item_height + 15, 30, 30);
            
            [image drawInRect:frame];

            //更新行和列
            colum++;
            if (colum % 7 == 0) {
                row++;
                colum = 0;
            }
            
            if (row == 4) {
                row = 0;
            }
        }
        
    }
}
//touch事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _magnifierView.hidden = NO;
    UITouch * touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    [self touchFace:point];
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView * s = (UIScrollView *)self.superview;
        s.scrollEnabled = NO;
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    [self touchFace:point];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _magnifierView.hidden = YES;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _magnifierView.hidden = YES;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView * s = (UIScrollView *)self.superview;
        s.scrollEnabled = YES;
    }
    [self sendMessageToFace];
}

-(void)sendMessageToFace
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"faceName" object:self.selectedFaceName userInfo:nil];
}
//根据坐标找到行列
-(void)touchFace:(CGPoint)point
{
    /*
     解方程
     colum * item_width + i * kMainScreenWidth + 15, row * item_height + 15
     */
    int page = point.x / kMainScreenWidth;
    int colum = (point.x - page * kMainScreenWidth - 15 )/ item_width;
    int row = (point.y - 15) / item_height;
    
    /*找到行列*/
    NSLog(@"row:%d colom = %d", row, colum);
    
    
    if (colum > 6) {
        colum = 6;
    }
    if (colum < 0) {
        colum = 0;
    }
    if ( row >3) {
        row = 3;
    }
    if (row < 0) {
        row = 0;
    }
    
    //如果是最后一页，表情可能残缺不全，所以只有有效部分能被点击
    if (page == [_items count] - 1) {
        
        //拿到该数组
        NSMutableArray * items2D = _items[page];
        
        if (row > items2D.count / 7 - 1) {
            int count = items2D.count % 7;
            
            if (colum <= (count - 1) && row <= items2D.count / 7 ) {
                NSLog(@"有效");
            }else{
                NSLog(@"点击区域无效");
                return;
            }
        }
    }
    
    int index = colum + row * 7;
    NSMutableArray * items2D = _items[page];
    NSDictionary * item = [items2D objectAtIndex:index];
    NSString * name = [item objectForKey:@"meaning"];
    
//    NSLog(@"name:%@", name);
    
    
    if (![self.selectedFaceName isEqualToString:name] || self.selectedFaceName == nil) {
        
        UIImage * image = [UIImage imageNamed:name];
        UIImageView * faceItem = (UIImageView *)[self viewWithTag:dTagFaceItem];
        faceItem.image = image;
        
        CGRect frame = CGRectMake(page * kMainScreenWidth + colum * item_width, (row - 2) * item_height + 30, 64, 92);
        _magnifierView.frame = frame;
        self.selectedFaceName = name;
        
    }
   
}
@end
