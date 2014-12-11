//
//  ViewController.h
//  mapDemo
//
//  Created by iwind on 14-10-21.
//  Copyright (c) 2014年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "ReGeocodeAnnotation.h"
#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapCommonObj.h>
#import <AMapSearchKit/AMapSearchObj.h>
@protocol PassValueDelegate
//传递经纬度
- (void)sendLon:(NSString *)lon WithLat:(NSString *)lat WithPlaceName:(NSString *)name;
@end
@interface RegisterMapViewController : UIViewController<MAMapViewDelegate,AMapSearchDelegate>

//longitude  latitude
@property(assign)float latitude;
@property(assign)float longitude;
@property(assign)int type;
@property(nonatomic,weak)id<PassValueDelegate> passDelegate;
@end
