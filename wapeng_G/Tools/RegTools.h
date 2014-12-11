//
//  RegTools.h
//  if_wapeng
//
//  Created by 心 猿 on 14-12-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegTools : NSObject
/**判断手机号码是否合法**/
+(BOOL)regResultWithString:(NSString *)string;
@end
