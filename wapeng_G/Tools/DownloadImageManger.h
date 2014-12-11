//
//  DownloadImageManger.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-25.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDWebImageManager.h"
#import "FileManger.h"
@interface DownloadImageManger : NSObject
+(void)downloadImageUrl:(NSString *)url setImageView:(UIImageView *) imageView;
@end
