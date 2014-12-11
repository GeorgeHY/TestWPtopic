//
//  RegisterDataManager.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-13.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RegisterDataManager.h"

static RegisterDataManager * _instance;

@implementation RegisterDataManager

+(id)allocWithZone:(struct _NSZone *)zone
{
   static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken, ^{
        
       _instance = [super allocWithZone:zone];
        
    });
    return _instance;
}
+(instancetype)shareInstance
{
    if (!_instance) {
        _instance = [[RegisterDataManager alloc]init];
        
        _instance.phoneNum = @"";
        _instance.password = @"";
        _instance.uuid = @"";
        _instance.regInfo = @"";
        _instance.regInfoID  = @"";
        _instance.parentNickName = @"";
        
        _instance.latitude = @"";
        _instance.longtitude = @"";
        _instance.picID = @"";
        _instance.childNickName = @"";
        _instance.childBrith = @"";
        
        _instance.childGender = @"";
        _instance.isUnique = @"";
        _instance.brithHospital = @"";
        _instance.brithHospital = @"";
        _instance.kindergaten = @"";
         _instance.city = @"";
        
        _instance.kindgardenID = @"";
        _instance.customKindergaten = @"";
       
//        _instance.branchAgent = @"";
        _instance.localPlace = @"";
        
        _instance.parentGender = @"";
    }
    return _instance;
}
-(void)printfSelf;
{
    NSLog(@"phoneNum:%@", self.phoneNum);
    NSLog(@"uuid:%@",self.uuid);
    NSLog(@"regInfo:%@", self.regInfo);
     NSLog(@"regInfoID=%@ ",self.regInfoID);
    NSLog(@"parentNickName:%@", self.parentNickName);
    NSLog(@"latitude:%@", self.latitude);
    NSLog(@"longtitude:%@", self.longtitude);
    NSLog(@"picID:%@", self.picID);
    NSLog(@"childNickName:%@",self.childNickName);
    NSLog(@"childBrith:%@", [self.childBrith substringFromIndex:9]);//
    NSLog(@"childGender:%@", self.childGender);
    NSLog(@"isUnique:%@",self.isUnique);
    NSLog(@"brithHospital:%@", self.brithHospital);
    NSLog(@"kindergaten:%@", self.kindergaten);
    NSLog(@"customKindergaten:%@", self.customKindergaten);
    NSLog(@"city:%@", self.city);
    NSLog(@"branchAgent:%@", self.branchAgent);
    NSLog(@"localPlace:%@", self.localPlace);
   
    NSLog(@"kindergadenID:%@",self.kindgardenID);
}

@end
