//
//  ChangeCityVC02.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-30.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "ChangeCityVC02.h"
#import "ChageCityItem.h"
@class RegisterWithBaiduVC03;
@interface ChangeCityVC02 ()
{
    AFN_HttpBase * http;
}
@end

@implementation ChangeCityVC02
@synthesize cityTableView;
@synthesize cityArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.cityArray = [[NSMutableArray alloc]init];
        http = [[AFN_HttpBase alloc]init];
        self.title = @"换个城市";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    cityTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44)];
    
    cityTableView.delegate = self;
    cityTableView.dataSource = self;
//    cityTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:cityTableView];
    
    cityArray = [[NSMutableArray alloc]init];
    
    __weak ChangeCityVC02 * weakSelf = self;
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
            [weakSelf.cityArray addObject:item];
        }
        [weakSelf.cityTableView reloadData];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"zoneAreaQuery.level", @"2",@"zoneAreaQuery.parentID", self.cityId, nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cityArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (nil ==  cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    ChageCityItem * item = [self.cityArray objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChageCityItem * item = [cityArray objectAtIndex:indexPath.row];
    item.sid = self.cityId;
//    NSString * cityStr = item.name;
    
    NSArray * array = [self.navigationController viewControllers];
    //拿到倒数第二个视图控制器
    UIViewController* vc = [array objectAtIndex:array.count -3];
    
    NSLog(@"%@", item);
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"changeCity" object:item];
    
    [self.navigationController popToViewController:vc animated:YES];
}

@end
