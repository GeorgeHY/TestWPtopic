//
//  StringTool.h
//  if_wapeng
//
//  Created by 早上好 on 14-10-16.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringTool : NSObject
+(CGFloat)returnTextWidthWithContent:(NSString *)content;
+(int)returnWordCountWithHotWordArray:(NSMutableArray *)hotWordArr;
/**组装html字符创,用于一个label分段显示颜色**/
+(NSString *)htmlString:(NSString *)aString andBString:(NSString *)bString;

/**去掉字符串中的逗号**/
+(NSString *)replaceCommcomma:(NSString *)string;

/**组装html字符串**/

-(void)assmbleHtmlStringWithAStrting:(NSString *)aString;


/**aString 是要传过去的字符串，一般是id或者什么的， bString是要展示在RTLabel上的字符串**/
+(NSString *)assmbleHtmlStringWithAStrting:(NSString *)aString bString:(NSString *)bString;

+(NSString *)assmbleHtmlStringWithArray:(NSArray *)array;

/**给tttAtributeString组装用的**/

+(NSMutableAttributedString  *)assmbleTTTAttringStringWithString:(NSString *)aString bString:(NSString *)bString;

/**给协议注册哪里tttAtributeString组装用的**/
+( NSMutableAttributedString *)assmbleRegisterTTTAttringStringWithString:(NSString *)aString bString:(NSString *)bString;
@end
