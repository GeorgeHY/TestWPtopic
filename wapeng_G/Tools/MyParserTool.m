//
//  MyParserTool.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-6.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "MyParserTool.h"
#import <CoreText/CoreText.h>
#import "TQRichTextEmojiRun.h"
#import "TQRichTextURLRun.h"

static MyParserTool * parser = nil;

@implementation MyParserTool


-(id)init
{
    self = [super init];
    if (self) {
        self.richTextRunsArray = [[NSMutableArray alloc] init];
    }
    return self;
}
+(id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
        parser = [super allocWithZone:zone];
    });
    
    return parser;
}
+(instancetype)shareInstance
{
    if (parser == nil) {
        
        parser = [[MyParserTool alloc]init];
    }
    return parser;
}

- (CGSize)sizeWithRawString:(NSString *)string constrainsToWidth:(CGFloat)width Font:(UIFont *)font
{
    
    NSAttributedString *attString = [self analyzeText:string Font:font];
    

    int lineCount = 0;
    CFRange lineRange = CFRangeMake(0,0);
    CTTypesetterRef typeSetter = CTTypesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    float drawLineX = 0;
    float drawLineY = 0 ;
    BOOL drawFlag = YES;
    
    while(drawFlag)
    {
        // 一行多少个字
        CFIndex testLineLength = CTTypesetterSuggestLineBreak(typeSetter,lineRange.location,width);
    check:  lineRange = CFRangeMake(lineRange.location,testLineLength);
        CTLineRef line = CTTypesetterCreateLine(typeSetter,lineRange);
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        
        //边界检查
        CTRunRef lastRun = CFArrayGetValueAtIndex(runs, CFArrayGetCount(runs) - 1);
        CGFloat lastRunAscent;
        CGFloat laseRunDescent;
        CGFloat lastRunWidth  = CTRunGetTypographicBounds(lastRun, CFRangeMake(0,0), &lastRunAscent, &laseRunDescent, NULL);
        CGFloat lastRunPointX = drawLineX + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(lastRun).location, NULL);
        
        if ((lastRunWidth + lastRunPointX) > width)
        {
            testLineLength--;
            CFRelease(line);
            goto check;
        }
        
        CFRelease(line);
        
        if(lineRange.location + lineRange.length >= attString.length)
        {
            drawFlag = NO;
        }
        
        lineCount++;
        drawLineY += font.ascender - font.descender + 2 ;  // 2是行距
        lineRange.location += lineRange.length;
    }
    
    CFRelease(typeSetter);
    return CGSizeMake(width, drawLineY);
}

- (NSAttributedString *)analyzeText:(NSString *)string Font:(UIFont *)font
{
    [self.richTextRunsArray removeAllObjects];
    
    NSString *result = @"";
    
    NSMutableArray *array = self.richTextRunsArray;
    
    // 所有[表情]构成对应的EmojiRun对象的数组以及新的newString,newString中的表情已变成空格
    result = [TQRichTextEmojiRun analyzeText:string runsArray:&array];
    
    // 生成URLRun对象
    result = [TQRichTextURLRun analyzeText:result runsArray:&array];
    
    
    // Get
    [self.richTextRunsArray makeObjectsPerformSelector:@selector(setOriginalFont:) withObject:font];
    
    
    //要绘制的文本
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:result];
    
    //设置字体
    CTFontRef aFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    [attString addAttribute:(NSString*)kCTFontAttributeName value:(__bridge id)aFont range:NSMakeRange(0,attString.length)];
    CFRelease(aFont);
    
    //文本处理:Emoji使用一个@“ ”的AttributeString,通过delegate设置其宽度等属性。URL只需设置该Range的前景色
    for (TQRichTextBaseRun *textRun in self.richTextRunsArray)
    {
        [textRun replaceTextWithAttributedString:attString];
    }
    
    return attString;
}

@end
