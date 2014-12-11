//
//  HotWordVIew.m
//  if_wapeng
//
//  Created by 心 猿 on 14-10-24.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define MANVIEW_TAG  100
#define POINT_SPACE 15 //所占的宽度
#define LABEL_HEITHG 30
#import "HotWordVIew.h"
#import "UIView+WhenTappedBlocks.h"
@implementation HotWordVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andHotWordArray:(NSArray *)array fontSize:(CGFloat)fontSize
{
    if (self = [super initWithFrame:frame]) {
        /*
         先取好值
         */
        
        _fontSize = fontSize;
        
        _mframe = frame;
        
        _frameArray = [[NSMutableArray alloc]init];
        
        self.hotWordArr = [[NSMutableArray alloc]init];
        
        //取消 @""这种字符串
        for (NSString * str in array) {
            
            if (str.length > 1) {
                
                [self.hotWordArr addObject:str];
            }
        }
        
        [self createHotView];
    }
    return self;
}

-(void)createHotView
{
    
   
    _frameArray = [self hotWordsFrameArray:_hotWordArr];
    
    
    for (NSValue * v in _frameArray) {
        
        CGRect frame = v.CGRectValue;
        
        NSLog(@"frame:%@", NSStringFromCGRect(frame));
    }
    
    NSMutableArray * pointArr = [[NSMutableArray alloc]init];

    
    for (int i = 0; i < _frameArray.count; i++) {
        
        int index = i % 4;
        
        [pointArr addObject:[self getPointArray][index]];
    }
    
    int i = 0;
    for (NSValue * value in _frameArray) {
        
        CGRect frame = value.CGRectValue;
        
        UIView * mainView = [[UIView alloc]initWithFrame:frame];
        
        mainView.tag =  MANVIEW_TAG + i;
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, (LABEL_HEITHG - POINT_SPACE + 7) / 2.0, POINT_SPACE - 7, POINT_SPACE - 7)];
//        imageView.backgroundColor = [UIColor greenColor];
        imageView.image = pointArr[i];
        [mainView addSubview:imageView];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(POINT_SPACE, 0, frame.size.width - POINT_SPACE, LABEL_HEITHG)];
        label.textAlignment =NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
//        label.backgroundColor = [UIColor greenColor];
        label.text = self.hotWordArr[i];
        [mainView addSubview:label];
        
//        mainView.backgroundColor = [UIColor purpleColor];
        
        __weak HotWordVIew  * weakSelf = self;
        
        [mainView whenTapped:^{
            
//            NSLog(@"%d", mainView.tag);
//            if ([weakSelf.delegate respondsToSelector:@selector(hotWordName:)]) {
//                
//                NSString * str = [NSString stringWithFormat:@"%@", _hotWordArr[mainView.tag - MANVIEW_TAG]];
//    
//                [weakSelf performSelector:@selector(hotWordName:) withObject:str];
//            }
            weakSelf.hotWordString = _hotWordArr[mainView.tag - MANVIEW_TAG];
            [weakSelf.delegate hotWordName:weakSelf.hotWordString];
          
            NSLog(@"%@", self.hotWordString);
            
        }];
        
        [self addSubview:mainView];
        i++;
    }

}
/**返回热词对应的宽度**/
-(CGFloat)returnTextWidthWithContent:(NSString *)content
{
    UIFont *font = [UIFont systemFontOfSize:_fontSize];
    NSDictionary *dict = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor redColor]};
    CGRect rect = [content boundingRectWithSize:CGSizeMake(kMainScreenWidth,  LABEL_HEITHG) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    return rect.size.width;
}
//hotarr 打折 滑雪 风筝 学科
-(NSMutableArray *)hotWordsFrameArray:(NSArray *)hotWordArr
{
     NSMutableArray * temp = [[NSMutableArray alloc]init];
    NSMutableArray * frameArr = [[NSMutableArray alloc]init];
    //按钮的个数
    int wordCount = 0;
    
    CGFloat width = 0;
    
    while (1) {
        
        if (wordCount >= hotWordArr.count) {
            
            break;
            
        }else{
            
            //总长度
            width += [self returnTextWidthWithContent:hotWordArr[wordCount]] + POINT_SPACE ;
            
            if (width > kMainScreenWidth) {
                break;
            }
            NSLog(@"width:%f", width);
            NSNumber * number = [NSNumber numberWithFloat:width];
            
            [temp addObject:number];
            
            wordCount++;
        }
        
    }
    
//    [temp addObject: temp[0]];
    
    NSNumber * number = [NSNumber numberWithFloat:0];
    
    [temp insertObject:number atIndex:0];
    
    
    for (NSNumber * n in temp) {
        
        CGFloat num = n.floatValue;
        
        NSLog(@"num;%f", num);
    }
    for (int i = 0; i < temp.count - 1; i++) {
        
        NSNumber * n2 = temp[i + 1];
        NSNumber * n1 = temp[i];
        
       
        CGFloat w = n2.floatValue - n1.floatValue;
        if (i == 0) {
            w = n2.floatValue;
        }
        CGFloat x = n1.floatValue;
        CGRect frame = CGRectMake(x, (_mframe.size.height -LABEL_HEITHG) / 2.0, w, LABEL_HEITHG);
        
        NSValue * v = [NSValue valueWithCGRect:frame];
        [frameArr addObject:v];
    }
    
    return frameArr;
}
-(NSArray *)getPointArray
{
    return  @[dPic_redpoint, dPic_greenpoint, dPic_bluepoint, dPic_orangepoint];
}
@end
