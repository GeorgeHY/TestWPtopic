//
//  WindowNumVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
//橱窗公号

#import "WindowNumVC.h"
#import "FXImageView.h"
#import "UIColor+AddColor.h"
@interface WindowNumVC ()
@property(nonatomic , strong) NSMutableArray * array;
@property(nonatomic , strong) iCarousel * carousel;
@end

@implementation WindowNumVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的橱窗工号";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#d5d6db"];
    [self careateComponent];
}

-(void) careateComponent{
//    if (IOS7) {
//        self.navigationController.navigationBar.translucent = NO;
//        self.automaticallyAdjustsScrollViewInsets = YES;
//    }
    UIScrollView * scrll = [[UIScrollView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrll.contentSize = CGSizeMake(self.view.frame.size.width, 589);
    
    UIImageView * header = [[UIImageView alloc]  initWithFrame:CGRectMake(10, 10, 60, 60)];
    [header  setImage:[UIImage imageNamed:@"headerImage.png"]];
    [scrll addSubview:header];
//    [self.view  addSubview:header];
    
    UILabel * titleL = [[UILabel alloc]  initWithFrame:CGRectMake(75, 10, 100, 30)];
    titleL.text = @"海景幼儿园";
    [scrll addSubview:titleL];
//    [self.view addSubview:titleL];
    
    UILabel * wapeng = [[UILabel alloc]  initWithFrame:CGRectMake(75, 40, 50, 30)];
    wapeng.text = @"挖朋";
    wapeng.font = [UIFont boldSystemFontOfSize:14];
    [scrll addSubview:wapeng];
//    [self.view addSubview:wapeng];
    UILabel * numL = [[UILabel alloc]  initWithFrame:CGRectMake(130, 40, 60, 30)];
    numL.text = @"12344";
    numL.font = [UIFont boldSystemFontOfSize:14];
    [scrll addSubview:numL];
//    [self.view addSubview:numL];
    
    UIButton * toTalkBtn = [[UIButton alloc]  initWithFrame:CGRectMake(self.view.frame.size.width - 80, 10, 80, 20)];

     UIImage* image = [UIImage imageNamed:@"public_dialog_btn.png"];

    [toTalkBtn  setBackgroundImage:image forState:UIControlStateNormal];
    [toTalkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [toTalkBtn setTitle:@"to 话题专版" forState:UIControlStateNormal];
    toTalkBtn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    [toTalkBtn addTarget:self action:@selector(onclicklisten) forControlEvents:UIControlEventTouchUpOutside];
        [scrll addSubview:toTalkBtn];
//    [self.view  addSubview:toTalkBtn];
    
    int with = 14;
    int left = 5;
    UIImageView * iv1 = [[UIImageView alloc]  initWithFrame:CGRectMake(left, 80, with, with)];
    [iv1  setImage:[UIImage imageNamed:@"zan.png"]];
    
    UIImageView * iv2 = [[UIImageView alloc]  initWithFrame:CGRectMake(left+with, 80, with, with)];
    [iv2 setImage:[UIImage imageNamed:@"zan.png"]];
    UIImageView * iv3 = [[UIImageView alloc]  initWithFrame:CGRectMake(left+(with*2), 80, with, with)];
    [iv3 setImage:[UIImage imageNamed:@"zan.png"]];
    UIImageView * iv4 = [[UIImageView alloc]  initWithFrame:CGRectMake(left+(with*3), 80, with, with)];
    [iv4 setImage:[UIImage imageNamed:@"zan.png"]];
    UIImageView * iv5 = [[UIImageView alloc]  initWithFrame:CGRectMake(left+(with*4), 80, with, with)];
    [iv5 setImage:[UIImage imageNamed:@"zan.png"]];
        [scrll addSubview:iv1];
        [scrll addSubview:iv2];
        [scrll addSubview:iv3];
        [scrll addSubview:iv4];
        [scrll addSubview:iv5];
//    [self.view addSubview:iv1];
//    [self.view addSubview:iv2];
//    [self.view addSubview:iv3];
//    [self.view addSubview:iv4];
//    [self.view addSubview:iv5];
    UIImageView * location = [[UIImageView alloc]  initWithFrame:CGRectMake(80,80,12,15)];
    [location  setImage:[UIImage imageNamed:@"public_position.png"]];
        [scrll addSubview:location];
//    [self.view addSubview:location];
    
    UILabel*locationL = [[UILabel alloc]  initWithFrame:CGRectMake(95, 80, 200, 15)];
    locationL.text = @"中国吉林省沈阳市长春路44号";
    locationL.font = [UIFont boldSystemFontOfSize:12];
        [scrll addSubview:locationL];
//    [self.view addSubview:locationL];


    UILabel * name = [[UILabel alloc]  initWithFrame:CGRectMake(10, 100, 200, 30)];
    name.text = @"机构全称";

    name.textAlignment = NSTextAlignmentLeft;
    name.font = [UIFont boldSystemFontOfSize:20];
        [scrll addSubview:name];
//    [self.view  addSubview:name];
    
    UITextView * about = [[UITextView alloc]  initWithFrame:CGRectMake(10,130, self.view.frame.size.width - 20, 50)];
    about.text = @"简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介";
    about.editable = NO;
    about.exclusiveTouch = NO;
    about.backgroundColor = [UIColor colorWithHexString:@"#d5d6db"];
    about.font = [UIFont boldSystemFontOfSize:14];
        [scrll addSubview:about];
//    [self.view  addSubview:about];
    
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(10, 180, self.view.frame.size.width - 20, 55)];
//    v.backgroundColor = [UIColor redColor];
    UIImageView * line = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 2)];
    line.image = [UIImage imageNamed:@"1.png"];
    [v  addSubview:line];
    
    UILabel * l1 = [[UILabel alloc]  initWithFrame:CGRectMake(10, 8, 40 , 20)];
    l1.textAlignment = NSTextAlignmentCenter;
    l1.text = @"25";
    [v addSubview:l1];
    UILabel * l2 = [[UILabel alloc]  initWithFrame:CGRectMake(10 + 80, 8, 40 , 20)];
    l2.text = @"25";
    l2.textAlignment = NSTextAlignmentCenter;
    [v addSubview:l2];
    UILabel * l3 = [[UILabel alloc]  initWithFrame:CGRectMake(10 + (80*2), 8, 40 , 20)];
    l3.text = @"25";
    l3.textAlignment = NSTextAlignmentCenter;
    [v addSubview:l3];
    UILabel * l4 = [[UILabel alloc]  initWithFrame:CGRectMake(10 + (80*3), 8, 40 , 20)];
    l4.text = @"25";
    l4.textAlignment = NSTextAlignmentCenter;
    [v addSubview:l4];
    
    UILabel * la = [[UILabel alloc]  initWithFrame:CGRectMake(10, 30, 40, 20)];
    la.text = @"瞬间";
    la.textAlignment = NSTextAlignmentCenter;
    [v addSubview:la];

    UILabel * lb = [[UILabel alloc]  initWithFrame:CGRectMake(10 + 80, 30, 40, 20)];
    lb.text = @"关注";
    lb.textAlignment = NSTextAlignmentCenter;
    [v addSubview:lb];

    UILabel * lc = [[UILabel alloc]  initWithFrame:CGRectMake(10 +(80*2), 30, 40, 20)];
    lc.text = @"瞬间";
    lc.textAlignment = NSTextAlignmentCenter;
    [v addSubview:lc];

    
    UILabel * ld = [[UILabel alloc]  initWithFrame:CGRectMake(10 +(80*3), 30, 40, 20)];
    ld.text = @"点评";
    [v addSubview:ld];
    UIImageView * line2 = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 2)];
    line2.image = [UIImage imageNamed:@"1.png"];
    [v  addSubview:line2];
        [scrll addSubview:v];
//    [self.view  addSubview:v];
    
    self.array = [[NSMutableArray alloc]  init];
    for (int i = 1; i<7; i++) {
        NSString * st = [NSString stringWithFormat:@"%d%@",i,@".png"];
        [self.array  addObject:st];
    }
    
    

    self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(20, 240, self.view.frame.size.width -40, 150)];
//    self.carousel.backgroundColor = [UIColor greenColor];
    self.carousel.type = iCarouselTypeCoverFlow2;
    self.carousel.currentItemIndex = 1;
        [scrll addSubview:self.carousel];
//    [self.view addSubview:self.carousel];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    [self.view addSubview:scrll];
    
    
    
}



-(void) onclicklisten{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark iCarousel
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.array.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view{
    if (view == nil){
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 180.0f, 180.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.5f;
        imageView.reflectionAlpha = 0.25f;
        imageView.reflectionGap = 10.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
        imageView.shadowBlur = 5.0f;
        imageView.cornerRadius = 10.0f;
        view = imageView;
    }
    //    ((FXImageView *)view).image = [_images objectAtIndex:index];
    
    ((FXImageView *)view).image = [UIImage imageNamed:[self.array  objectAtIndex:index]];
    return view;
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option){
        case iCarouselOptionWrap:{
            return YES;
        }
        case iCarouselOptionTilt:{
            return 0.78f;
        }
        case iCarouselOptionSpacing:{
            return 0.5f;
        }
        default:{
            return value;
        }
    }
}




@end
