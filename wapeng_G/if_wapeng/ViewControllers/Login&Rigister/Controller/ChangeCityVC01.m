//
//  ChangeCityVC01.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-30.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "ChangeCityVC01.h"
#import "ChangeCityVC02.h"
#import "ChageCityItem.h"
@interface ChangeCityVC01 ()
{
    AFN_HttpBase * http;
}
@end

@implementation ChangeCityVC01
@synthesize provinceTableView;
@synthesize provinceArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"换个城市";
         http = [[AFN_HttpBase alloc]init];
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
    
    provinceArray = [[NSMutableArray alloc]init];
    
    __weak ChangeCityVC01 * weakSelf = self;
    [http thirdRequestWithUrl:dUrl_PUB_1_1_1 succeed:^(NSObject *obj, BOOL isFinished) {
        
        NSDictionary * dict = (NSDictionary *)obj;
        NSMutableArray * array = [dict objectForKey:@"value"];
        
        for (NSDictionary * dict in array) {
            ChageCityItem * item = [[ChageCityItem alloc]init];
            item.childList = [dict objectForKey:@"childList"];
            item.code = [dict objectForKey:@"code"];
            item.mid = [dict objectForKey:@"id"];
            item.latitude = [dict objectForKey:@"latitude"];
            item.displaySeq = [dict objectForKey:@"displaySeq"];
            item.name = [dict objectForKey:@"name"];
            item.level = [dict objectForKey:@"level"];
            item.longitude = [dict objectForKey:@"longitude"];
            item.name = [dict objectForKey:@"name"];
            item.parent = [dict objectForKey:@"parent"];
            [self.view addSubview:nil];
            [weakSelf.provinceArray addObject:item];
        }
        [weakSelf.provinceTableView reloadData];

    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"zoneAreaQuery.level", @"1",@"zoneAreaQuery.parentID", @"", nil];
  
    NSLog(@"%@", provinceArray);
    
    provinceTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44)];
    provinceTableView.delegate = self;
    provinceTableView.dataSource = self;
    [self.view addSubview:provinceTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [provinceArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    ChageCityItem * item = [provinceArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", item.name];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeCityVC02 * vc02 = [[ChangeCityVC02 alloc]init];
    
    ChageCityItem * item = [self.provinceArray objectAtIndex:indexPath.row];
    vc02.cityId = item.mid;
    [self.navigationController pushViewController:vc02 animated:YES];
}

@end
