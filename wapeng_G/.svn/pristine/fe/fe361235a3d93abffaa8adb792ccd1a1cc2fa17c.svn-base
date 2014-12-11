//
//  AppDelegate.h
//  if_wapeng
//
//  Created by 永不死的圣斗士 on 14-6-17.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

//@class MMDrawerVisualState;
//@class MMExampleDrawerVisualStateManager;
//@class MMDrawerController;
//@class RegisterDataManager;

#import <UIKit/UIKit.h>
#import "IF_TBCViewController.h"
//#import "BMapKit.h"

#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MMDrawerController.h"


@interface AppDelegate : UIResponder
<
UITabBarControllerDelegate
,UIApplicationDelegate
// ,BMKGeneralDelegate
>
{
//    BMKMapManager * _mapManager;
 
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MMDrawerController * mmVC;//抽屉
@property (nonatomic, strong) IF_TBCViewController * mTbc;
@property (nonatomic, strong) UINavigationController * nav1;
@property (nonatomic, strong) UINavigationController * nav2;
@property (nonatomic, strong) UINavigationController * nav3;
@property (nonatomic, strong) UINavigationController * nav4;
@property (nonatomic, strong) NSDictionary * loginDict;
@property (nonatomic, strong) NSString * uuid;
@property (nonatomic, strong) NSString * globalUuid;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (nonatomic, strong) NSMutableString * cookies;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)showViewController:(int)type;
+(instancetype)shareInstace;
@end
