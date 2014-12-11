//
//  AnnouncementVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-1.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

//上榜机构

#import "AnnouncementVC.h"
#import "AnnouncementCell.h"
#import "UIViewController+MMDrawerController.h"
#import "Item_Announcement.h"
#import "AnnouncementDetailVC.h"
@interface AnnouncementVC ()

@property(nonatomic ,strong) UITableView * leftTable;
@property(nonatomic ,strong) UITableView * rightTable;

@property(nonatomic , strong) NSMutableArray * dataLeft;
@property(nonatomic , strong) NSMutableArray * dataRight;



@end

@implementation AnnouncementVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleS = @"上榜机构";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.titleS;
    self.dataRight = [[NSMutableArray alloc]  init];
    self.dataLeft = [[NSMutableArray alloc]  init];
    NSMutableArray * titleArray = [[NSMutableArray alloc]  initWithObjects:@"课外教育",@"中法文系统",nil];
    for (int i = 0; i < titleArray.count ; i++) {
        Item_Announcement * mAc = [[Item_Announcement alloc] init];
        mAc.title = [titleArray  objectAtIndex:i];
        NSMutableArray * array = [[NSMutableArray alloc] init];
        for (int j = 0; j< 1; j++) {
            NSMutableDictionary* dicChild = [[NSMutableDictionary alloc]  init];
            NSString * name = [[NSString alloc] initWithFormat:@"%@%d",@"图片", j];
            [dicChild  setValue:name forKey:@"name"];
            [dicChild  setValue:@"logo.png" forKey:@"image"];
            NSString * name2 = [[NSString alloc] initWithFormat:@"%@%d",@"图片", j];
            [dicChild  setValue:name2 forKey:@"name2"];
            [dicChild setValue:@"userheard.png"forKey:@"image2"];
            [array  addObject:dicChild];
        }
        mAc.array = array;
        [self.dataRight addObject:mAc];
        [self.dataLeft  addObject:mAc];
    }
    
    [self careateComponent];
    [self initLeftItem];
}
-(void)initLeftItem
{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 15, 15);
    leftButton.titleLabel.textColor = [UIColor blackColor];
    [leftButton setBackgroundImage:dPic_Public_topmenu forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)navItemClick:(UIButton * ) b{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

-(void) careateComponent{
    self.view.backgroundColor = [UIColor whiteColor];
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    self.leftTable = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2 , self.view.frame.size.height - 64 - 49)];
    [self.view  addSubview:self.leftTable];
    self.rightTable = [[UITableView alloc]  initWithFrame:CGRectMake(self.view.frame.size.width/2,0, self.view.frame.size.width/2 , self.view.frame.size.height  - 64 - 49)];
    [self.view  addSubview:self.rightTable];
    self.leftTable.delegate = self;
    self.rightTable.delegate = self;
    self.leftTable.dataSource = self;
    self.rightTable.dataSource = self;
    

    [self.rightTable  setSeparatorStyle:UITableViewCellSeparatorStyleNone];//取消分割线
    [self.leftTable  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.leftTable.showsVerticalScrollIndicator = NO;
    self.rightTable.showsVerticalScrollIndicator = NO;

    
}

#pragma mark  Scrollview
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray * array = @[self.leftTable, self.rightTable];
    for (UIScrollView * scroll in array) {
        if (scroll != scrollView) {
            scroll.contentOffset = scrollView.contentOffset;
            
            CGFloat sectionHeaderHeight = 40;
            if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
        }
    }
}



#pragma mark  tableview
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTable) {
        Item_Announcement * ann = [self.dataLeft  objectAtIndex:section];
        return ann.array.count;
    }else{
        Item_Announcement * ann = [self.dataRight  objectAtIndex:section];
        return ann.array.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.leftTable) {
        return self.dataLeft.count;
    }else{
        return self.dataRight.count;
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * v = [[UIView alloc]  initWithFrame:CGRectMake(0, 0,150 , 40)];
    UIButton * b = [[UIButton alloc] initWithFrame:CGRectMake(5, 10,150, 30)];
    [b setBackgroundImage:[UIImage imageNamed:@"ann_titleBg.png"] forState:UIControlStateNormal];
    b.enabled = NO;

    Item_Announcement * ann = [self.dataLeft objectAtIndex:section];
    if (tableView == self.leftTable) {
        [b  setTitle:ann.title forState:UIControlStateNormal];
    }else{
        [b  setTitle:ann.title forState:UIControlStateNormal];
    }
    [b.titleLabel setTextColor:[UIColor blackColor]];
    [v addSubview:b];
    return v;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * v = [[UIView alloc]  initWithFrame:CGRectMake(0, 0,150 , 25)];
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0,150,10)];
    [image  setImage:[UIImage imageNamed:@"ann_footer.png"]];
    [v addSubview:image];
    return v;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"anncell";
    AnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[AnnouncementCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    Item_Announcement * ann;
    if (tableView == self.leftTable) {
        ann = [self.dataLeft objectAtIndex:indexPath.section];
        NSMutableArray * array =  ann.array;
        NSDictionary * dic = [array  objectAtIndex:indexPath.row];
        NSString * name = [dic  objectForKey:@"name"];
        NSString * image = [dic  objectForKey:@"image"];
        NSString * name2 = [dic  objectForKey:@"name2"];
        NSString * image2 = [dic  objectForKey:@"image2"];
        [cell.imageView1 setImage:[UIImage imageNamed:image]];
        cell.lable.text = name;
        [cell.imageView2 setImage:[UIImage imageNamed:image2]];
        cell.lable2.text = name2;
    }else{
        ann = [self.dataRight objectAtIndex:indexPath.section];
        NSMutableArray * array =  ann.array;
        NSMutableDictionary * dic = [array  objectAtIndex:indexPath.row];
        NSString * name = [dic  objectForKey:@"name"];
        NSString * image = [dic  objectForKey:@"image"];
        NSString * name2 = [dic  objectForKey:@"name2"];
        NSString * image2 = [dic  objectForKey:@"image2"];
        [cell.imageView1 setImage:[UIImage imageNamed:image]];
        cell.lable.text = name;
        [cell.imageView2 setImage:[UIImage imageNamed:image2]];
        cell.lable2.text = name2;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //（这种是没有点击后的阴影效果)

    
    AnnouncementDetailVC * annDetail = [[AnnouncementDetailVC alloc]  init];
    annDetail.titleName = @"榜上详细";
    
    [self.navigationController  pushViewController:annDetail animated:YES ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
