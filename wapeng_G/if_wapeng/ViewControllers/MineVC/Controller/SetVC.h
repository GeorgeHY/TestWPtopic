//
//  SetVC.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-22.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeSetItem.h"
#import "CustomSwitch.h"

@interface SetVC : UIViewController<CustomSwitchDelegate>
- (IBAction)passWordSet:(MeSetItem *)sender;
- (IBAction)pushSwitch:(CustomSwitch *)sender;
@property (weak, nonatomic) IBOutlet CustomSwitch *pushSwitch;

@property (weak, nonatomic) IBOutlet UIButton *quit;
@end
