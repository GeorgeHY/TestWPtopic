//
//  FileManger.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-25.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "FileManger.h"

@implementation FileManger

//获得Document路径
+(NSString *)documentPath
{
 return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  objectAtIndex:0];
}
//判断文件是否存在
+(BOOL) opinionFileIsEmpty:(NSString*)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:path])
        return YES;
    return NO;
}
//存储图片在Document下的tableImage文件夹下
+(void)storeTableImageForDocument:(NSString * )imageName image:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imageDirectory = [[self documentPath] stringByAppendingPathComponent:@"tableImage"];
    [fileManager createDirectoryAtPath:imageDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    NSString * namePath = [NSString stringWithFormat:@"%@%@%@%@" , [self documentPath] , @"/tableImage",@"/" , imageName];
    [fileManager createFileAtPath:namePath  contents:data attributes:nil];
}



@end
