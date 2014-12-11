 //
//  NSString+Bourod.m
//  FJFastTextView
//
//  Created by 符杰 on 14-10-23.
//  Copyright (c) 2014年 Colgar. All rights reserved.
//

#import "NSString+Bourod.h"

#define kBengin_Flag @"["
#define kEnd_Flag    @"]"

#warning 更改图片名称的首位标记

@implementation NSString (Bourod)

+(CGSize)boundSizeWithString:(NSString *)string Font:(UIFont *)font size:(CGSize)size{
    size = [self assembleMessageAtIndex:string font:font width:size.width];
    return size;
}

#pragma mark  -图文混排
+(void)getImageRange:(NSString*)message : (NSMutableArray*)array{
    NSRange range=[message rangeOfString: kBengin_Flag];
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

+(CGSize)assembleMessageAtIndex : (NSString *) message font:(UIFont *)font width:(CGFloat)width
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getImageRange:message :array];
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *data = array;
    UIFont *fon = font;
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat lWidth = (width == MAXFLOAT) ? MAXFLOAT : width;
    CGFloat faceViewW = [@"" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: fon} context:nil].size.height + 2.1;
    CGFloat faceViewH = faceViewW;
    upY = faceViewH;
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
            if ([str hasPrefix: kBengin_Flag] && [str hasSuffix: kEnd_Flag])
            {
                X = faceViewW + X;
                if (X >= lWidth)
                {
                    upY = upY + faceViewH;
                    upX = lWidth;
                }
                if (X < lWidth && upY <= faceViewH) {
                    upX = X;
                }
                if (X >= lWidth) {
                    X = faceViewW;
                }
                
            } else {
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    CGSize size= [temp boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: fon} context:nil].size;
                    X = X + size.width;
                    if (X >= lWidth)
                    {
                        upY = upY + faceViewH;
                        upX = lWidth;
                    }
                    if (X < lWidth && upY <= faceViewH) {
                        upX = X;
                    }
                    if (X >= lWidth) {
                        X = size.width;
                    }
                }
            }
        }
    }
    returnView.frame = CGRectMake(15.0f,1.0f, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
    return CGSizeMake(upX, upY);
}

@end
