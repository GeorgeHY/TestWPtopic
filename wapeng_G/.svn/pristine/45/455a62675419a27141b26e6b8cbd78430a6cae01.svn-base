//
//  StringTool.m
//  if_wapeng
//
//  Created by 早上好 on 14-10-16.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "StringTool.h"
#import "NSString+URLEncoding.h"
#import "Item_zanList.h"
#import "NSString+muToolKit.h"
@implementation StringTool

+(CGFloat)returnTextWidthWithContent:(NSString *)content
{
    UIFont *font = [UIFont systemFontOfSize:14];
    NSDictionary *dict = @{NSFontAttributeName: font, NSForegroundColorAttributeName:[UIColor redColor]};
    CGRect rect = [content boundingRectWithSize:CGSizeMake(kMainScreenWidth,  30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    return rect.size.width;
}
//hotarr 打折 滑雪 风筝 学科
+(int)returnWordCountWithHotWordArray:(NSMutableArray *)hotWordArr
{
    //按钮的个数
    int wordCount = 0;
    
    CGFloat width = 0;
    
    while (1) {
        
        width += [self returnTextWidthWithContent:hotWordArr[wordCount]];
        
        wordCount++;
        //13图片宽度 2为左右间距 和中间间距 3个 为6
        float allWidth = width + (13 * wordCount) + (6+wordCount);
        if (allWidth >= kMainScreenWidth || wordCount >= [hotWordArr count]) {
            
            break;
        }
    }
    
    return wordCount;
}


+(NSString *)htmlString:(NSString *)aString andBString:(NSString *)bString
{
    NSLog(@"aString:%@", aString);
    NSLog(@"bString:%@", bString);
    NSString * str1 = [NSString stringWithFormat:@"<font size = 15 color = '#0000ff'>%@:</font>", aString];
    NSString * str2 = [NSString stringWithFormat:@"<font size = 15 color = '#000000'>%@</font>", bString];
    
    NSString * str3 = [str1 stringByAppendingString:str2];
    return str3;
}
+(NSString *)replaceCommcomma:(NSString *)string
{
    NSArray * arr = [string componentsSeparatedByString:@","];
    
    NSString * newStr = nil;
    for (NSString * s in arr) {
     
        [newStr stringByAppendingString:s];
    }
    if (newStr == nil) {
        
        newStr = @"";
    }
    return newStr;
}
/**aString 是要传过去的字符串，一般是id或者什么的， bString是要展示在RTLabel上的字符串**/
+(NSString *)assmbleHtmlStringWithAStrting:(NSString *)aString bString:(NSString *)bString
{
    aString = [aString URLEncodedString];
    
    NSString * newStr = [NSString stringWithFormat:@"<a href='user:%@'>%@</a>",aString, bString];
    
    return newStr;
}

+(NSString *)assmbleHtmlStringWithArray:(NSArray *)array
{
    NSMutableString * result = [[NSMutableString alloc]init];
    int i = 0;
    for (Item_zanList * item in array) {
       NSString * temp =  [[self class] assmbleHtmlStringWithAStrting:item.mid bString:item.petName];
        
        [result appendFormat:@"%@、", temp];
        i++;
    }
    
    NSLog(@"result:%@", result);
    
    NSInteger len = result.length;

    result = [result substringToIndex:len - 1];
    
    if (i >= 10) {
        [result appendString:@"更多"];
    }
    
    return result;
}
#pragma mark - 组装tttlabel,蓝色在左边
+( NSMutableAttributedString *)assmbleTTTAttringStringWithString:(NSString *)aString bString:(NSString *)bString
{
     aString = [aString stringByAppendingString:@":"];
    NSRange range = NSMakeRange(0, aString.length - 1);
    
    NSLog(@"range:%@",NSStringFromRange(range));
    
    aString = [aString stringByAppendingString:bString];
    
    NSMutableAttributedString * ret = [[NSMutableAttributedString alloc]initWithString:aString];
    
    [ret addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
    
    
    range = NSMakeRange(0, ret.length);
    
   [ret addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
    
    return ret;

}

#pragma mark - 组装tttlabel,蓝色在右边

+( NSMutableAttributedString *)assmbleRegisterTTTAttringStringWithString:(NSString *)aString bString:(NSString *)bString
{
    aString = [aString stringByAppendingString:@":"];
    NSRange range = NSMakeRange(aString.length, bString.length);
    
    NSLog(@"range:%@",NSStringFromRange(range));
    
    aString = [aString stringByAppendingString:bString];
    
    NSMutableAttributedString * ret = [[NSMutableAttributedString alloc]initWithString:aString];
    
    [ret addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
    
    
    range = NSMakeRange(0, ret.length);
    
    [ret addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
    
    return ret;
    
}
@end
