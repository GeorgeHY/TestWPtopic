//
//  ZBarReaderVC.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-23.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "ZBarReaderVC.h"
//#import "ZBarSDK.h"
@interface ZBarReaderVC ()//<ZBarReaderViewDelegate>
//@property(nonatomic , strong)ZBarReaderView * zBarView;
//@property(nonatomic , strong)ZBarCameraSimulator*camera;
@end

@implementation ZBarReaderVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.zBarView = [[ZBarReaderView new]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
//    self.zBarView.allowsPinchZoom = NO;
//    self.zBarView.readerDelegate = self;
//    self.zBarView.backgroundColor = [UIColor blackColor];
//    self.zBarView.backgroundColor = [UIColor redColor];
//    UIApplication *app = [UIApplication sharedApplication];
//	[self.zBarView willRotateToInterfaceOrientation:app.statusBarOrientation duration: 0];
//    self.camera = [[ZBarCameraSimulator alloc] initWithViewController:self];
//    
//    self.camera.readerView = self.zBarView;

//    [self.view  addSubview:self.zBarView];
}

//- (void)readerView:(ZBarReaderView*)view
//	didReadSymbols:(ZBarSymbolSet*)syms
//		 fromImage:(UIImage*)img
//{
//	NSLog(@"Sample2:readerView:didReadSymbols:fromImage:");
//    
//	ZBarSymbol* symbol = nil;
//	for (symbol in syms) {
//		// EXAMPLE: just grab the first barcode
//		break;
//	}
//    NSLog(@"-----%@",symbol.data);
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	// ZBar: run the reader when the view is visible
	NSLog(@"Sample2:viewDidAppear: start");
//	[self.zBarView start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
	// ZBar: stop the reader
	NSLog(@"Sample2:viewWillDisappear: stop");
//	[self.zBarView stop];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
