//
//  DownloadImageManger.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-25.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "DownloadImageManger.h"

@implementation DownloadImageManger

+(void)downloadImageUrl:(NSString *)url setImageView:(UIImageView *) imageView{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:[NSURL URLWithString:url] options:0 progress:^(NSUInteger receivedSize, long long expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
        imageView.image = image;
        [FileManger storeTableImageForDocument:@"tupian.jpg" image:image];
    }];
}

@end
