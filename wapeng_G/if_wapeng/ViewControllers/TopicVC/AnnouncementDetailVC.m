//
//  AnnouncementDetailVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-9-3.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "AnnouncementDetailVC.h"
#import "UIViewController+General.h"
#import "UIColor+AddColor.h"
#import "AnnouncementDetailCell.h"
#import "Item_AnnouncementDetail.h"
#import "WindowNumVC.h"
//榜单详细
@interface AnnouncementDetailVC ()

@property(nonatomic , strong) UITableView * tableView;
@property(nonatomic , strong) NSMutableArray * dataArray;

@end

@implementation AnnouncementDetailVC

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
    self.title = self.titleName;
    [self initLeftItem];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#c0c0c0"];
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    self.dataArray = [[NSMutableArray alloc]  init];
    for (int i = 0; i < 9; i++) {
        Item_AnnouncementDetail * annDetail = [[Item_AnnouncementDetail alloc]  init];
        annDetail.name = [[NSString alloc]  initWithFormat:@"%@%d",@"冠军 ", i];
        annDetail.bigImagePath = @"logo.png";
        annDetail.location = @"323.7千米";
        annDetail.count = @"1200";
        NSMutableArray* arrayIv = [[NSMutableArray alloc]  init];
        if (i%2 == 0) {
            annDetail.mark = Hot;
        }else{
            annDetail.mark = Cool;
        }
        for (int i = 0 ; i < 6; i++) {
            switch (i) {
                case 0:
                    [arrayIv addObject:@"1.png"];
                    break;
                case 1:
                    [arrayIv addObject:@"2.png"];
                    break;
                case 2:
                    [arrayIv addObject:@"3.png"];
                    break;
                case 3:
                    [arrayIv addObject:@"4.png"];
                    break;
                case 4:
                    [arrayIv addObject:@"5.png"];
                    break;
                case 5:
                    [arrayIv addObject:@"6.png"];
                    break;
                default:
                    break;
            }

        }
        annDetail.littleIvPathArray = arrayIv;
        [self.dataArray  addObject:annDetail];
    }
    [self careateComponent];
}
-(void)careateComponent{
    self.tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = YES;
    [self.view  addSubview:self.tableView];
}
//系统的Item方法
-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


#pragma mark tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"detailcell";
    AnnouncementDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell=[[AnnouncementDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    Item_AnnouncementDetail * annDetail = [self.dataArray objectAtIndex:indexPath.row];
    [cell.headerIv setImage:[UIImage imageNamed:annDetail.bigImagePath]];
    cell.name.text = annDetail.name;
    cell.locationL.text = annDetail.location;
    cell.countL.text = annDetail.count;
    [cell.markHot  setHidden:NO];
    if (annDetail.mark == Hot) {
        [cell.markHot  setHidden:NO];
        [cell.markHot  setImage:[UIImage imageNamed:@"hot.png"]];
    }else{
        [cell.markHot  setHidden:YES];
    }
    NSMutableArray * array = annDetail.littleIvPathArray;
    for (int i = 0; i<array.count; i++) {
        switch (i) {
            case 0:
                cell.littleIv0.image = [UIImage imageNamed:[array  objectAtIndex:i]];
                break;
            case 1:
                cell.littleIv1.image = [UIImage imageNamed:[array  objectAtIndex:i]];
                break;
            case 2:
                cell.littleIv2.image = [UIImage imageNamed:[array  objectAtIndex:i]];
                break;
            case 3:
                cell.littleIv3.image = [UIImage imageNamed:[array  objectAtIndex:i]];
                
                break;
            case 4:
                cell.littleIv4.image = [UIImage imageNamed:[array  objectAtIndex:i]];
                
                break;
            case 5:
                cell.littleIv5.image = [UIImage imageNamed:[array  objectAtIndex:i]];
                
                break;
                
            default:
                break;
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.selected = NO;
    WindowNumVC * window = [[WindowNumVC alloc]  init];
    [self.navigationController pushViewController:window animated:YES];
    
    
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
