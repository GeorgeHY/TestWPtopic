//
//  Location.h
//  if_wapeng
//
//  Created by iwind on 14-12-15.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapCommonObj.h>
@interface Location : NSObject

@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) AMapGeoPoint* coor;

@end
