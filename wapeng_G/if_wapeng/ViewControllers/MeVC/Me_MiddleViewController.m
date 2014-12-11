//
//  Me_MiddleViewController.m
//  if_wapeng
//
//  Created by 永不死的圣斗士 on 14-6-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "Me_MiddleViewController.h"
#include "Me_LeftViewController.h"
#import "Me_RightViewController.h"
@interface Me_MiddleViewController ()
{

    UIViewController * _currentMainController;//当前视图控制器
    UITapGestureRecognizer * _tapGestureReconginzer;//tap
    UIPanGestureRecognizer * _panGestureReconginzer;//pan
    BOOL sideBarShowing;//侧滑菜单是否显现
    CGFloat currentTranslate; //当前偏移量
}
@property (nonatomic, strong) Me_LeftViewController * leftVC;
@property (nonatomic, strong) Me_RightViewController * rightVC;
@property (nonatomic, strong) UIView * tbcView;
@end
@implementation Me_MiddleViewController
@synthesize leftVC;
@synthesize rightVC;
@synthesize contentView;
@synthesize navBackView;

static Me_MiddleViewController *rootVC;
const int ContentOffset=320 - 64;
const int ContentMinOffset=60;
const float MoveAnimationDuration = 0.15;//动画周期
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
+(id)share
{
    return rootVC;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.
    
    self.navBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    
    [self.view addSubview:self.navBackView];
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.contentView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.contentView];
    
    if (rootVC != nil) {
        
        rootVC = nil;
    }
    
    rootVC = self;
    
    sideBarShowing = NO;
    
    currentTranslate = 0;
    
    self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    self.contentView.layer.shadowOpacity = 1;//透明度
    
    //设置左视图控制器
    Me_LeftViewController * me_LeftVC = [[Me_LeftViewController alloc]init];
    me_LeftVC.delegate = self;
    self.leftVC = me_LeftVC;
    
    Me_RightViewController * me_RightVC = [[Me_RightViewController alloc]init];
    self.rightVC = me_RightVC;
    
    [self addChildViewController:self.leftVC];
    [self addChildViewController:self.rightVC];
    
    self.leftVC.view.frame = self.navBackView.bounds;
    self.rightVC.view.frame = self.navBackView.bounds;
    
    [self.navBackView addSubview:self.leftVC.view];
    [self.navBackView addSubview:self.rightVC.view];
    
    _panGestureReconginzer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panInContentView:)];
    [self.contentView addGestureRecognizer:_panGestureReconginzer];
}
- (void)contentViewAddTapGestures
{
    if (_tapGestureReconginzer) {
        [self.contentView removeGestureRecognizer:_tapGestureReconginzer];
        _tapGestureReconginzer = nil;
    }
    
    _tapGestureReconginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnContentView:)];
    
    [self.contentView addGestureRecognizer:_tapGestureReconginzer];
    
}
-(void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
}
-(void)panInContentView:(UIPanGestureRecognizer *)panGestureReconginzer
{
    //判断是否是pan的手势在持续中
    if (panGestureReconginzer.state == UIGestureRecognizerStateChanged) {
        
        //获取滑动的偏移量
        CGFloat translation = [panGestureReconginzer translationInView:self.contentView].x;
        
        self.contentView.transform = CGAffineTransformMakeTranslation(translation + currentTranslate, 0);
        
        UIView * view;
        
        if (translation + currentTranslate > 0) {
            
            //获得左视图
            view = self.leftVC.view;
        }else{
            
            view = self.rightVC.view;
        }
        
        //把view拿到上边
        [self.navBackView bringSubviewToFront:view];
        
        
    }
    //判断拖动结束
    else if (panGestureReconginzer.state == UIGestureRecognizerStateEnded)
    {
        currentTranslate = self.contentView.transform.tx;
        
        if (sideBarShowing == NO) {
            
            
            if (fabs(currentTranslate) < ContentMinOffset) {
                
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
            }else if(currentTranslate > ContentMinOffset)
            {
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
        
            }else{
                
                [self moveAnimationWithDirection:SideBarShowDirectionRight duration:MoveAnimationDuration];
            }
        }
        else
        {
            if (fabs(currentTranslate)<ContentOffset-ContentMinOffset) {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
                
            }else if(currentTranslate>ContentOffset-ContentMinOffset)
            {
                
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
                
            }else
            {
                [self moveAnimationWithDirection:SideBarShowDirectionRight duration:MoveAnimationDuration];
            }
        }

    }
}
#pragma mark - nav con delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController.viewControllers count]>1) {
        [self removepanGestureReconginzerWhileNavConPushed:YES];
    }else
    {
        [self removepanGestureReconginzerWhileNavConPushed:NO];
    }
    
}

- (void)removepanGestureReconginzerWhileNavConPushed:(BOOL)push
{
    if (push) {
        if (_panGestureReconginzer) {
            [self.contentView removeGestureRecognizer:_panGestureReconginzer];
            _panGestureReconginzer = nil;
        }
    }else
    {
        if (!_panGestureReconginzer) {
            _panGestureReconginzer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panInContentView:)];
            [self.contentView addGestureRecognizer:_panGestureReconginzer];
        }
    }
}
#pragma mark - side bar select delegate
- (void)leftSideBarSelectWithController:(UIViewController *)controller
{
    if ([controller isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)controller setDelegate:self];
    }
    if (_currentMainController == nil) {
		controller.view.frame = self.contentView.bounds;
		_currentMainController = controller;
		[self addChildViewController:_currentMainController];
		[self.contentView addSubview:_currentMainController.view];
		[_currentMainController didMoveToParentViewController:self];
	} else if (_currentMainController != controller && controller !=nil) {
		controller.view.frame = self.contentView.bounds;
		[_currentMainController willMoveToParentViewController:nil];
		[self addChildViewController:controller];
		self.view.userInteractionEnabled = NO;
		[self transitionFromViewController:_currentMainController
						  toViewController:controller
								  duration:0
								   options:UIViewAnimationOptionTransitionNone
								animations:^{}
								completion:^(BOOL finished){
									self.view.userInteractionEnabled = YES;
									[_currentMainController removeFromParentViewController];
									[controller didMoveToParentViewController:self];
									_currentMainController = controller;
								}
         ];
	}
    
    [self showSideBarControllerWithDirection:SideBarShowDirectionNone];
}


- (void)rightSideBarSelectWithController:(UIViewController *)controller
{
    
}

- (void)showSideBarControllerWithDirection:(SideBarShowDirection)direction
{
    
    if (direction!=SideBarShowDirectionNone) {
        UIView *view ;
        if (direction == SideBarShowDirectionLeft)
        {
            view = self.leftVC.view;
        }else
        {
            view = self.rightVC.view;
        }
        [self.navBackView bringSubviewToFront:view];
    }
    [self moveAnimationWithDirection:direction duration:MoveAnimationDuration];
}
#pragma animation

- (void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration
{
    //定义一个回调动画
    void (^animationss)(void) = ^{
        
        switch (direction) {
            case SideBarShowDirectionNone:
            {
                self.contentView.transform = CGAffineTransformMakeTranslation(0, 0);
            }
                break;
            case SideBarShowDirectionLeft:
            {
                self.contentView.transform = CGAffineTransformMakeTranslation(ContentOffset, 0);
            }
                break;
            case SideBarShowDirectionRight:
            {
                self.contentView.transform = CGAffineTransformMakeTranslation(-ContentOffset, 0);
            }
            default:
                break;
        }
    };
    void (^complete)(BOOL) = ^(BOOL finished){
        
        self.contentView.userInteractionEnabled = YES;
        self.navBackView.userInteractionEnabled = YES;
        
        if (direction == SideBarShowDirectionNone) {
            
            if (_tapGestureReconginzer) {
                
                [self.contentView removeGestureRecognizer:_tapGestureReconginzer];
                _tapGestureReconginzer = nil;
            }
            sideBarShowing = NO;
        }else{
            
            [self contentViewAddTapGestures];
            sideBarShowing = YES;
        }
        
        currentTranslate = self.contentView.transform.tx;
    };
    
    self.contentView.userInteractionEnabled = NO;
    self.navBackView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:duration animations:animationss completion:complete];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
