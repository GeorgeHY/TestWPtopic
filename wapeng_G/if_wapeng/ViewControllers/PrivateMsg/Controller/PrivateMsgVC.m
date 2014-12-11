//
//  PrivateMsgVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-11-19.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "PrivateMsgVC.h"

@interface PrivateMsgVC ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSMutableArray * _messageFrames;// 所有消息的fame数据
}
@end

@implementation PrivateMsgVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"messages.plist" withExtension:nil];
    
    NSArray * array = [NSArray arrayWithContentsOfURL:url];
    
}



@end
