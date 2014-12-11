//
//  HotWordTool.m
//  if_wapeng
//
//  Created by 心 猿 on 14-10-16.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "HotWordTool.h"

@implementation HotWordTool

+(CGFloat)returnTextWidthWithContent:(NSString *)content
{
    UIFont *font = [UIFont systemFontOfSize:14];
    NSDictionary *dict = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor redColor]};
    CGRect rect = [content boundingRectWithSize:CGSizeMake(kMainScreenWidth,  30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    return rect.size.width;
}
//hotarr 打折 滑雪 风筝 学科
+(int)returnWordCountWithHotWordArray:(NSArray *)hotWordArr
{
    //按钮的个数
    int wordCount = 0;
    
    CGFloat width = 0;
    
    while (1) {
        
        width += [[self class] returnTextWidthWithContent:hotWordArr[wordCount]];
        
        wordCount++;
        
        if (width + 15 * wordCount >= kMainScreenWidth || wordCount == [hotWordArr count]) {
            
            if (width + 15 * wordCount >= kMainScreenWidth) {
                
                wordCount--;
                break;
            }
        }
    }
    
    return wordCount;
}

+(CGFloat)space
{
    return 0;
}
@end
