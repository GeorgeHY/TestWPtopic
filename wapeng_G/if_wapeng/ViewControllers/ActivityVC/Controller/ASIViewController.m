//
//  ASIViewController.m
//  if_wapeng
//
//  Created by 心 猿 on 14-10-10.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#define kTextViewHeight 40 //textView返回时候的高度
#define kInputViewHeight 44 //inputView的坐标
#import "ASIViewController.h"
#import "ASIHttpTool.h"
#import "Cell_MyWindow.h"
#import "HotWordVIew.h"
#import "RegisterVC07.h"
#import "SelectHotLabelVC.h"
#import "TQRichTextView.h"
#import "NSString+Bourod.h"
#import "FJFastTextView.h"
#import "RDRStickyKeyboardView.h"
#import "WUDemoKeyboardBuilder.h"
#import "AppDelegate.h"

#import "MyParserTool.h"

#import "RegVC09.h"
@interface ASIViewController ()<TQRichTextViewDelegate>

@property (nonatomic, strong) RDRStickyKeyboardView *contentWrapper;
@end

@implementation ASIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self createUI];
//    [self keyBoardTings];
//    [self afnetWorkingd];
    
    UIButton * b  = [[UIButton alloc]init];
    b.frame = CGRectMake(100, 100, 100, 100);
    b.backgroundColor = [UIColor redColor];
    [self.view addSubview:b];
    [b addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnClick
{
    RegVC09 * regVC09 = [[RegVC09 alloc]init];
    [self.navigationController pushViewController:regVC09 animated:YES];
}
-(void)afnetWorkingd
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"%d", status);
    }];

}

-(void)keyBoardTings
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self createKeyBoard];
}

#pragma mark - 创建微信键盘

-(void)createKeyBoard
{
    self.contentWrapper = [[RDRStickyKeyboardView alloc]initWithScrollView:self.tableView];
    self.contentWrapper.frame = self.view.bounds;
    self.contentWrapper.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.contentWrapper.placeholder = @"Message";
    [self.contentWrapper.inputView.rightButton addTarget:self action:@selector(didTapSend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.contentWrapper];
    
    [self.contentWrapper.inputView.leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%@", NSStringFromCGRect(self.contentWrapper.inputView.textView.frame));
}

#pragma mark - other按钮被点击，也就是换表情键盘的按钮被点击

-(void)leftBtnClick
{
    
    if (self.contentWrapper.inputView.textView.isFirstResponder) {
        
        if (self.contentWrapper.inputView.textView.emoticonsKeyboard != nil) {
            [self.contentWrapper.inputView.textView switchToDefaultKeyboard];
            
        }else{
            [self.contentWrapper.inputView.textView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
        }
    }else{
        
        [self.contentWrapper.inputView.textView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
        [self.contentWrapper.inputView.textView becomeFirstResponder];
        
    }
}

#pragma mark - 发送按钮被点击

- (void)didTapSend:(id)sender
{
    self.contentWrapper.inputView.textView.text = @"";
    [self.contentWrapper setNeedsDisplay];
    [self.contentWrapper.inputView setNeedsDisplay];
    [self.contentWrapper.inputView.textView switchToDefaultKeyboard];
    
    [self.contentWrapper hideKeyboard];
}


-(void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    Cell_MyWindow * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        
        cell = [[Cell_MyWindow alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    cell.textLabel.text = @"11";
    return cell;
}

#pragma - 开始拖动scrollview
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.contentWrapper.inputViewScrollView]) {
        
        NSLog(@"吾问无为谓");
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}
@end
