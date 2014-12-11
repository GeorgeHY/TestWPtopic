//
//  FJFastTextView.m
//  FJFastTextView
//
//  Created by 符杰 on 14-10-23.
//  Copyright (c) 2014年 Colgar. All rights reserved.
//

#import "FJFastTextView.h"
#import "NSString+Bourod.h"
#define kBegin_Flag @"["
#define kEnd_Flag @"]"

#warning 更改图片名称的首位标记

@interface FJFastTextView()
{
    float _faceViewH;
    float _faceViewW;
}
@end

@implementation FJFastTextView


-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        mWidth = frame.size.width;
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = NO;
        
    }
    return self;
}

//-(void)assembleMessage
//{
//
//    if (_textColor == nil) {
//        _textColor = [UIColor blackColor];
//    }
//    if (self.textFont == nil) {
//        self.textFont = [UIFont systemFontOfSize:13];
//    }
//
//    for (UIView * view in self.subviews) {
//
//        [view removeFromSuperview];
//    }
//
//    [self assembleMessageAtIndex:self.text width:mWidth textColor:self.textColor textFont:self.textFont];
//}
//
//-(id)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font{
//    self = [super initWithFrame:frame];
//    if (self) {
//        if (textColor == nil) {
//            textColor = [UIColor blackColor];
//        }
//        if (font == nil) {
//            font = [UIFont systemFontOfSize:13];
//        }
//        [self assembleMessageAtIndex:text width:frame.size.width textColor:textColor textFont:font];
//    }
//    return self;
//}
////图文混排
//
-(void)getImageRange:(NSString*)message : (NSMutableArray*)array {
    NSRange range=[message rangeOfString: kBegin_Flag];
    NSRange range1=[message rangeOfString: kEnd_Flag];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            [array addObject:[message substringToIndex:range.location]];
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[message substringFromIndex:range1.location+1];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }else {
                return;
            }
        }
        
    } else if (message != nil) {
        [array addObject:message];
    }
}



-(void)drawRect:(CGRect)rect
{
    
    self.layer.sublayers = nil;
    
    if (self.textColor == nil) {
        
        self.textColor = [UIColor blackColor];
    }
    if (self.textFont == nil) {
        
        self.textFont = [UIFont systemFontOfSize:14];
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getImageRange:self.text :array];
    //    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *data = array;
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat faceImageW = [@"a" boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:nil].size.height + 2.1;
    CGFloat faceImageH = faceImageW;
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
            if ([str hasPrefix: kBegin_Flag] && [str hasSuffix: kEnd_Flag])
            {
                if ((upX +faceImageW) >= mWidth)
                {
                    upY = upY + faceImageH;
                    upX = 0;
                    X = mWidth;
                    Y = upY;
                }
#warning 需要根据本地的表情名称动态更改imageName
                NSString *imageName=[str substringWithRange:NSMakeRange(1, str.length - 2)];
                
                [self drawImageWithFrame: CGRectMake(upX, upY, faceImageW, faceImageH) imageName:imageName];
                
                upX=faceImageW+upX;
                if (X< mWidth) X = upX;
                
            } else {
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    CGSize size = [temp boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.textFont} context:nil].size;
                    if ((upX + size.width) >= mWidth)
                    {
                        upY = upY + faceImageH;
                        upX = 0;
                        X = mWidth;
                        Y =upY;
                    }
                    
                    [self drawTextWithFrame:CGRectMake(upX,upY,size.width,size.height) aString:temp];
                    upX=upX+size.width;
                    if (X<mWidth) {
                        X = upX;
                    }
                }
            }
        }
    }
    //    returnView.frame = CGRectMake(0.0f,0.0f, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
}

-(void)drawTextWithFrame:(CGRect)frame aString:(NSString *)aString
{
    
    UIColor *stringColor = self.textColor;
    
    NSDictionary* attrs =@{NSForegroundColorAttributeName:stringColor,
                           
                           NSFontAttributeName:self.textFont
                           
                           }; //在词
    
    [aString drawInRect:frame withAttributes:attrs];
}

/**绘制图片**/
-(void)drawImageWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImage * image = [UIImage imageNamed:imageName];
    
    [image drawInRect:frame];
}

-(CGFloat)height
{
    //    boundSizeWithString:(NSString *)string Font:(UIFont *)font size:(CGSize)size;
    CGSize size = [NSString boundSizeWithString:self.text Font:self.textFont size:CGSizeMake(mWidth, 1000)];
    return size.height;
}
-(void)reloadFrame
{
    
    
    CGSize size = [NSString boundSizeWithString:self.text Font:self.textFont size:CGSizeMake(mWidth, 1000)];
    CGRect frame = self.frame;
    frame.size = size;
    
    self.frame = frame;
    
    [self setNeedsDisplay];
    return;
}
@end
