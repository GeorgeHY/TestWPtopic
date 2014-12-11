//
//  UIImage+Stretch.m
//  if_wapeng
//
//  Created by 符杰 on 14-9-22.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "UIImage+Stretch.h"

@implementation UIImage (Stretch)

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}

@end
