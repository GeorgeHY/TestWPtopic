//
//  LoadingDialog.h
//  if_wapeng
//
//  Created by 早上好 on 14-9-14.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingDialog : UIView{
    UIActivityIndicatorView * loading;
    UIControl * control;
}
-(void)creatComponent;

-(void)showDialog;
-(void)dismissDialog;

@end
