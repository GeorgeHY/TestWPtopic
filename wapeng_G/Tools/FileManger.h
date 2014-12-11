//
//  FileManger.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-25.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManger : NSObject
+(NSString *)documentPath;
+(BOOL) opinionFileIsEmpty:(NSString*)path;
+(void)storeTableImageForDocument:(NSString * )imageName image:(UIImage *)image;
@end
