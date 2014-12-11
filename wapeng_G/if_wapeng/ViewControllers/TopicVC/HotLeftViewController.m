//
//  HotLeftViewController.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-8.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "HotLeftViewController.h"
#import "HotLeftTVCell.h"
#import "HotLeftModel.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIView+WhenTappedBlocks.h"
#import "AnnouncementVC.h"
#import "UIViewController+MMDrawerController.h"
#import "AnnouncementAllVC.h"
@interface HotLeftViewController ()
{
    float nav_Y;
    float nav_H;
    float screenheight;
    float screenwidth;
    long touch;

}
@end

@implementation HotLeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSMutableArray * array = [[NSMutableArray alloc]  initWithObjects:@"全部",@"身边的",@"熟人参与的",@"我孩子年龄段的",@"热门的",@"上榜机构", nil];
        self.dateSource = [[NSMutableArray alloc]  init];
        for (int i = 0; i < array.count; i++) {
            
//            if (i == 6) {
//                HotLeftModel * hot = [[HotLeftModel alloc]  init];
//                hot.b = NO;
//                NSString * st = [NSString stringWithFormat:@"%@" , [array objectAtIndex:i]];
//                hot.title = st;
//                NSMutableArray * array2 = [[NSMutableArray alloc]  initWithObjects:@"孩子1",@"孩子2", nil];
//                hot.child = array2;
//                [self.dateSource  addObject:hot];
//            }else{
                HotLeftModel * hot = [[HotLeftModel alloc]  init];
                hot.b = NO;
                NSString * st = [NSString stringWithFormat:@"%@" , [array objectAtIndex:i]];
                hot.title = st;
                [self.dateSource addObject:hot];

//            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createLayout];
    [self createComponent];
    touch = 0;

}
-(void) createComponent{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * imgaeBg = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, screenwidth, 140)];
    imgaeBg.backgroundColor = [UIColor grayColor];
//    imgaeBg.image = [UIImage imageNamed:@"3.png"];
    self.headIm = [[UIImageView alloc]  initWithFrame:CGRectMake(35, 35, 60, 60)];
    self.headIm.image = [UIImage imageNamed:@"1.png" ];
//    self.headIm.backgroundColor = [UIColor greenColor];
    [imgaeBg addSubview:self.headIm];
   
    UIImageView * im = [[UIImageView alloc]  initWithFrame:CGRectMake(110, 48, 15, 15)];
    im.backgroundColor = [UIColor greenColor];
    [imgaeBg addSubview:im];
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(150, 48, 40, 15)];
    title.text = @"话题";
    [imgaeBg addSubview:title];
    self.name = [[UILabel alloc]  initWithFrame:CGRectMake(110, 70, 70, 20)];
    self.name.textColor = [UIColor whiteColor];
    self.name.text = @"南群啊啊";
    [imgaeBg addSubview:self.name];
    
    [self.view  addSubview:imgaeBg];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 141, screenwidth, screenheight - 141)];
    
    [self.view  addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HotLeftModel * hlm =[self.dateSource objectAtIndex:section];
    NSMutableArray * array =  hlm.child;
    if(hlm.b){
        return array.count;
    }else{
        return 0;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dateSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}



- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HotLeftModel * hlm = [self.dateSource  objectAtIndex:section];
    UIView * v = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 320, 30)];
    v.backgroundColor = [UIColor redColor];
    UILabel * lable = [[UILabel alloc]  initWithFrame:CGRectMake(10, 2, 300, 20)];
    lable.text = hlm.title;
    [v  addSubview:lable];
    [v whenTapped:^{
        if (hlm.b) {
            hlm.b = NO;
              [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        }else{
            [self careateRightController:section];
            hlm.b = YES;
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
    return v;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    HotLeftTVCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
            cell=[[HotLeftTVCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    HotLeftModel * hot  = [_dateSource objectAtIndex:indexPath.section];
    NSMutableArray * array =  hot.child;
    NSString * child = [array objectAtIndex:indexPath.row];
    cell.title.text = child;
    return cell;
}

-(void)careateRightController:(NSInteger )section{
    switch (section) {
        case 0:
        {
            AnnouncementAllVC * allA = [[AnnouncementAllVC alloc]  init];
            UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:allA];
            [self.mm_drawerController setCenterViewController:navigation withCloseAnimation:YES completion:nil];
            break;
        }
        case 1:
        {
            AnnouncementVC *center=[[AnnouncementVC alloc]init];
            UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:center];
            center.titleS = @"身边的";
            [self.mm_drawerController setCenterViewController:navigation withCloseAnimation:YES completion:nil];
               break;
        }
        case 2:
        {
            AnnouncementVC *center=[[AnnouncementVC alloc]init];
            UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:center];
            center.titleS = @"熟人参与的";
            [self.mm_drawerController setCenterViewController:navigation withCloseAnimation:YES completion:nil];
            break;
        }
        case 3:
        {
            AnnouncementVC *center=[[AnnouncementVC alloc]init];
            UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:center];
            center.titleS = @"我孩子年龄段的";
            [self.mm_drawerController setCenterViewController:navigation withCloseAnimation:YES completion:nil];
               break;
        }
        case 4:
        {
            AnnouncementVC *center=[[AnnouncementVC alloc]init];
            UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:center];
            [self.mm_drawerController setCenterViewController:navigation withCloseAnimation:YES completion:nil];
            break;
        }
        case 5:
        {
            AnnouncementVC *center=[[AnnouncementVC alloc]init];
            UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:center];
            [self.mm_drawerController setCenterViewController:navigation withCloseAnimation:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *identifier=@"cell";
//    HotLeftTVCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
////    if (!cell) {
//        cell=[[HotLeftTVCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
////    }
//    HotLeftModel * hot  = [_dateSource objectAtIndex:indexPath.row];
//    
//    cell.title.text = hot.title;
//    bool  b = hot.b;
//    if (!b) {
//        cell.im.hidden = YES;
//    }else{
//        cell.im.hidden = NO;
//    }
//    if (!hot.t) {
//        cell.mview.hidden = YES;
//    }else{
//        cell.mview.hidden = NO;
//    }
//    
//    
//    if ([hot.child  count] > 0) {
//        CGRect rect = CGRectMake(0, 30, 320, [hot.child count] * 30);
//        cell.mview.frame = rect;
//        
//        for (int i = 0; i < [hot.child count] ; i++) {
//            NSMutableArray * array = [hot  child];
//            NSMutableDictionary * dic = [array  objectAtIndex:i];
//            NSString * st = [dic  objectForKey:@"child"];
//            UILabel * lable = [[UILabel alloc]  initWithFrame:CGRectMake(0, i *30, 320, 30)];
//            lable.text = st;
//            lable.backgroundColor = [UIColor purpleColor];
//            [lable  whenTapped:^{
//                NSLog(@"aaaaa %d" , i);
//            }];
//            [cell.mview addSubview:lable];
//        }
//    }else{
//        
//    }
//    
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"---- %ld" , (long)indexPath.row);

    HotLeftModel * hot1 = [self.dateSource  objectAtIndex:touch];
    hot1.b = NO;

    HotLeftModel * hot2 = [self.dateSource  objectAtIndex:indexPath.row];
    hot2.b = YES;
    if (indexPath.row == touch) {
        if (hot2.t) {
            hot2.t = NO;
        }else{
            hot2.t = YES;
        }
    }else{
        hot2.t = YES;
        hot1.t = NO;
    }
    touch = indexPath.row;
    [tableView reloadData];
}

-(void)createLayout
{
    CGFloat iosversion = [[[UIDevice currentDevice]systemVersion]floatValue];
    
    if (iosversion >= 7) {
        
        nav_Y = 64;
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }else{
        nav_Y = 0;
    }
    screenheight = self.view.frame.size.height;
    screenwidth = self.view.frame.size.width;
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
