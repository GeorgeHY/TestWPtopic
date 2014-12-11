//
//  HttpRquest.h
//  if_wapeng
//
//  Created by 心 猿 on 14-10-24.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRquest : NSObject

-(void)startHttpWithRequesturl:(NSString *)url postDict:(NSDictionary *)dict;

@end
