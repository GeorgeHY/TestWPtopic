//
//  ChildBrowserVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-7.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define dtag_iamgeview(i) 100 + i
#import "ChildBrowserVC.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "UIView+WhenTappedBlocks.h"
@interface ChildBrowserVC ()
{
    UIView * _headerView;
    UIView * _footerView;
}
@end

@implementation ChildBrowserVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dataArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.mainView = [[UIView alloc]init];
    self.mainView.frame = CGRectMake(0, 0, kMainScreenWidth, _headerView.frame.size.height + 240);
    [self.mainView addSubview:_headerView];
    [self.mainView addSubview:_footerView];
    self.mainView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.mainView];
    [self createUIView];
    [self createPhotoItem];
   
    self.mainView.backgroundColor = [UIColor redColor];
    NSLog(@"%@", NSStringFromCGRect(self.mainView.frame));
}

-(void)createUIView
{
//    _mainView = [[UIView alloc]init];
//    _mainView.frame = self.view.bounds;
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight / 2);
    
    _headerView = headerView;
    
    UIImageView * headerIV = [[UIImageView alloc]init];
    headerIV.frame = CGRectMake(10, 10, 60, 60);
    headerIV.backgroundColor = [UIColor purpleColor];
    headerIV.layer.masksToBounds = YES;
    headerIV.layer.cornerRadius = 5;
    headerIV.layer.borderWidth = 1;
    headerIV.layer.borderColor = [UIColor grayColor].CGColor;
    headerIV.image = [UIImage imageNamed:@"saga2.jpg"];
    [headerView addSubview:headerIV];
    
    UILabel * parentLbl = [[UILabel alloc]init];
    parentLbl.frame = CGRectMake(10, headerIV.frame.origin.y + headerIV.frame.size.height + 10, 80, 20);
//    parentLbl.backgroundColor = [UIColor greenColor];
    parentLbl.text = @"杨杨爸爸";
    parentLbl.font = [UIFont systemFontOfSize:13.5];
    [headerView addSubview:parentLbl];
    
    UILabel * childLbl = [[UILabel alloc]init];
    childLbl.frame = CGRectMake(10, parentLbl.frame.origin.y + parentLbl.frame.size.height + 2, 80, 20);
    childLbl.text = @"公主/5岁";
    childLbl.font = [UIFont systemFontOfSize:12];
    childLbl.textColor = [UIColor redColor];
//    childLbl.backgroundColor = [UIColor greenColor];
    [headerView addSubview:childLbl];
    
    UILabel * mainLabel = [[UILabel alloc]init];
    mainLabel.frame = CGRectMake(headerIV.frame.origin.x + headerIV.frame.size.width + 10, 10, kMainScreenWidth - headerIV.frame.origin.x - headerIV.frame.size.width -10, 30);
    mainLabel.font = [UIFont systemFontOfSize:13.8];
    mainLabel.text = @"[习近平演讲中巴有缘人有缘人]";
    [headerView addSubview:mainLabel];
    
    UILabel * toolLabel = [[UILabel alloc]init];
    toolLabel.frame = CGRectMake(headerIV.frame.origin.x + headerIV.frame.size.width + 5, mainLabel.frame.origin.y+ mainLabel.frame.size.height, kMainScreenWidth - headerIV.frame.origin.x - headerIV.frame.size.width, 30);
//    toolLabel.backgroundColor = [UIColor greenColor];
    //在toolLabel上粘贴
    UILabel * stateLbl = [[UILabel alloc]init];
    stateLbl.frame = CGRectMake(0, 0, 80, 30);
    stateLbl.text = @"活动进行中";
    stateLbl.textColor = [UIColor blueColor];
    stateLbl.font = [UIFont systemFontOfSize:12];
    [toolLabel addSubview:stateLbl];
    
    UILabel * daysLbl = [[UILabel alloc]init];
    daysLbl.frame = CGRectMake(90, 0, 50, 30);
    daysLbl.text = @"7天前";
    daysLbl.font = [UIFont systemFontOfSize:12];
    daysLbl.textColor = [UIColor grayColor];
    [toolLabel addSubview:daysLbl];
    
    UILabel * replayLbal = [[UILabel  alloc]init];
    replayLbal.frame = CGRectMake(150, 0, 100, 30);
    replayLbal.text = @"回复：1001";
    replayLbal.textColor = [UIColor grayColor];
    replayLbal.font = [UIFont systemFontOfSize:12];
    
    [toolLabel addSubview:replayLbal];
    
    
    UILabel * detailLbl = [[UILabel alloc]init];
    detailLbl.frame = CGRectMake(80, toolLabel.frame.origin.y + toolLabel.frame.size.height + 5, kMainScreenWidth - 100, 100);
    detailLbl.text = @"大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙大觉金仙";
    detailLbl.font = [UIFont systemFontOfSize:13.3];
    detailLbl.numberOfLines = 0;
    detailLbl.lineBreakMode = NSLineBreakByCharWrapping;
    detailLbl.textColor = [UIColor grayColor];
//    detailLbl.backgroundColor = [UIColor purpleColor];
    [headerView addSubview:detailLbl];
    
    
    UIView * posotionView = [[UIView alloc]init];
    posotionView.frame = CGRectMake(80, detailLbl.frame.origin.y + detailLbl.frame.size.height + 5,200, 40);
//    posotionView.backgroundColor = [UIColor redColor];
    
    UILabel * positonLbl = [[UILabel alloc]init];
    positonLbl.frame = CGRectMake(0, 0, 50, 40);
    positonLbl.text = @"我在";
    positonLbl.font = [UIFont systemFontOfSize:13.5];
    positonLbl.textColor = [UIColor blueColor];
    
    UIImageView * positionIV = [[UIImageView alloc]init];
    positionIV.frame = CGRectMake(50, 15, 10, 10);
    positionIV.image = dPic_Public_position;
    [posotionView addSubview:positionIV];
    
    UILabel * position = [[UILabel alloc]init];
    position.frame = CGRectMake(60, 5, 100, 30);
    position.font = [UIFont systemFontOfSize:13];
//    position.textColor = [UIColor grayColor];
    position.text = @"天津南开";
    [posotionView addSubview:position];
    
    [posotionView addSubview:positonLbl];
    
    [headerView addSubview:posotionView];
    
    
    [headerView addSubview:toolLabel];

    [self.mainView addSubview:headerView];
}
-(void)createPhotoItem
{
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(0, _headerView.frame.origin.y + _headerView.frame.size.height, kMainScreenWidth, 240);
    view.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:view];
    
    _footerView = view;
    
    for (int i = 0; i < 3; i++) {
        
        for (int j = 0; j < 3; j++) {
            
            UIImageView * imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(80 + 80 * i, 80 * j, 70, 70);
            imageView.image = [UIImage imageNamed:@"saga2.jpg"];
            
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 6;
            imageView.layer.borderWidth = 1;
            imageView.layer.borderColor = [UIColor grayColor].CGColor;
    
            imageView.tag = dtag_iamgeview((i + j + 2 * i));//tag从100到108
            
            [view addSubview:imageView];
            NSLog(@"imageView.tag:%d", imageView.tag);
            [imageView whenTapped:^{
    
                [self createPhotoBrowser:1 image:[UIImage imageNamed:@"saga2.jpg"]];
            }];
            
            
        }
    }
}
-(void)createPhotoBrowser:(int)tag image:(UIImage *)image
{
    tag = 1;
    int count = 9;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        //        NSString *url = [_urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:nil]; // 图片路径
        photo.srcImageView = (UIImageView *)[self.view viewWithTag:1001]; // 来源于哪个UIImageView
        //        photo.placeholder = image;
        [photos addObject:photo];
    }
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
