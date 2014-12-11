//
//  AllActivityVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-8-29.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define dTag_leftBtn 100
#define dTag_rightBtn 101
#define dTag_searchText 102

#define dTag_girdBtn1 103
#define dTag_girdBtn2 104
#define dTag_girdBtn3 105
#define dTag_girdBtn4 106

#define dTag_activBtn1 107
#define dTag_activBtn2 108
#define dTag_activBtn3 109
#define dTag_activBtn4 110
#define dTag_activBtn5 111
#define dTag_activBtn6 112
#import "AllActivityVC.h"
#import "HMSegmentedControl.h"
#import "UIColor+AddColor.h"
#import "Cell_SellerActivity.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIViewController+MMDrawerController.h"
@interface AllActivityVC ()
{
    HMSegmentedControl * seg;
    NSArray * _name;
}
@end

@implementation AllActivityVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"活动";
    }
    return self;
}
-(void)btnClick2:(UIButton *)button
{
    switch (button.tag) {
        case dTag_activBtn1:
        {
            NSLog(@"1");
        }
            break;
        case dTag_activBtn2:
        {
            NSLog(@"2");
        }
            break;
        case dTag_activBtn3:
        {
            NSLog(@"3");
        }
            break;
        case dTag_activBtn4:
        {
            NSLog(@"4");
        }
            break;
        case dTag_activBtn5:
        {
            NSLog(@"5");
        }
            break;
        case dTag_activBtn6:
        {
            NSLog(@"6");
        }
            break;

        default:
            break;
    }
}
-(void)btnClick:(UIButton *)button
{
    switch (button.tag) {
        case dTag_girdBtn1:
        {
            NSLog(@"宝宝");
        }
            break;
        case dTag_girdBtn2:
        {
            NSLog(@"妈妈");
        }
            break;
        case dTag_girdBtn3:
        {
            NSLog(@"家庭");
        }
            break;
        case dTag_girdBtn4:
        {
            NSLog(@"活动");
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (IOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    [self createFalseData];
    self.view.backgroundColor = self.view.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
    [self createUIView];
}
-(void)createFalseData
{
    _dataArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 3; i++) {
        
        NSMutableArray * _samllArray = [[NSMutableArray alloc]init];
        
        for (int j = 0; j < 10; j++) {
            
            NSString * falseStr = [NSString stringWithFormat:@"%d:section%d:row", i, j];
            [_samllArray  addObject:falseStr];
        }
        [_dataArray addObject:_samllArray];
    }
}
-(void)createUIView
{
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    leftBtn.tag = dTag_leftBtn;
    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    rightBtn.tag = dTag_rightBtn;
    rightBtn.backgroundColor = [UIColor greenColor];
    [rightBtn addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //自定义搜索栏
    UIImageView * leftIView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 10, 20, 20)];
    leftIView.image = dPic_Public_mangnifty;
    UITextField * searchText = [[UITextField alloc]
                                initWithFrame:CGRectMake(10, 5, kMainScreenWidth - 20, 35)];
    searchText.placeholder = @"搜索";
    searchText.layer.cornerRadius = 15;
    searchText.layer.borderWidth = 1;
    searchText.layer.borderColor = [UIColor whiteColor].CGColor;
    searchText.layer.masksToBounds = YES;
    searchText.tag = dTag_searchText;
    searchText.delegate = self;
    searchText.borderStyle = UITextBorderStyleRoundedRect;
    searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchText.adjustsFontSizeToFitWidth = YES;
    searchText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    searchText.leftView = leftIView;
    searchText.leftViewMode = UITextFieldViewModeAlways;
    searchText.delegate = self;
    [searchText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:searchText];
    
    [self createSeg];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, seg.frame.size.height + seg.frame.origin.y, kMainScreenWidth - 20, kMainScreenHeight - seg.frame.size.height - seg.frame.origin.y - 49 - 64 + 20) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //分割线
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth - 20, 149.5)];
    
    UILabel * categoryLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kMainScreenWidth - 30 - 20, 35)];
    categoryLbl.text = @"分类热门活动";
    
    [view1 addSubview:categoryLbl];
    
    NSArray * name = @[@"宝宝", @"妈妈", @"家庭", @"活动"];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 103 + i;
        button.frame = CGRectMake(10 + (kMainScreenWidth - 60) / 2.0 * i + 15 * i, categoryLbl.frame.size.height + categoryLbl.frame.origin.y + 5, (kMainScreenWidth - 60) / 2.0, 44);
        button.backgroundColor = [UIColor yellowColor];
        [button setTitle:[name objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:button];
    }
    
    for (int i = 0; i < 2; i++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 105 + i;
            button.frame = CGRectMake(10 + (kMainScreenWidth - 60) / 2.0 * i + 15 * i, categoryLbl.frame.size.height + categoryLbl.frame.origin.y + 5 + 50, (kMainScreenWidth - 60) / 2.0, 44);
            button.backgroundColor = [UIColor greenColor];
            [button setTitle:[name objectAtIndex:i + 2] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view1 addSubview:button];
    }
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 149.5, kMainScreenWidth - 20, 1)];
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 150.5, kMainScreenWidth - 20, 209.5)];
    UILabel * activyLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kMainScreenWidth - 30 - 20, 35)];
    activyLbl.text = @"同龄活动";
    activyLbl.backgroundColor = [UIColor blueColor];
    [view2 addSubview:activyLbl];
    
    NSArray * nameArray1 = @[@"新生儿（0 ~ 100天）", @"1岁~2岁", @"3岁~6岁"];
    for (int i = 0; i < 3; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i + 107;
        button.frame = CGRectMake(10, activyLbl.frame.size.height + activyLbl.frame.origin.y + 20 + 50 * i, (kMainScreenWidth - 60) / 2.0, 35);
        [button setTitle:[nameArray1 objectAtIndex:i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor greenColor];
        [button addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:button];
    }
    NSArray * nameArray2 = @[@"3个月~1岁", @"2岁~4岁", @"6岁以上"];
    for (int i = 0; i < 3; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 110 + i;
        button.frame = CGRectMake(10 + (kMainScreenWidth - 20) / 2.0, activyLbl.frame.size.height + activyLbl.frame.origin.y + 20 + 50 * i, (kMainScreenWidth - 60) / 2.0, 35);
        [button setTitle:[nameArray2 objectAtIndex:i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor greenColor];
        [button addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:button];
    }
    
    line.backgroundColor = [UIColor blackColor];
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth - 20, 360)];
    [footerView addSubview:line];
    [footerView addSubview:view1];
    [footerView addSubview:view2];
    footerView.backgroundColor = [UIColor redColor];
    _tableView.tableFooterView = footerView;
    
    
    //取消键盘相应
    __weak UITextField * weakSearch = searchText;
    
    [self.mm_drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        
        [weakSearch resignFirstResponder];
        return 0;
        
    }];

}
-(void)createSeg
{
    NSArray * array = @[@"打折", @"滑雪", @"放风筝", @"轮滑"];
    NSArray * name = @[@"身边热门活动", @"商家活动", @"用户互动"];
    _name = name;
    seg = [[HMSegmentedControl alloc]initWithSectionTitles:array];
    [seg setBackgroundColor:[UIColor redColor]];
    seg.frame = CGRectMake(0, 45, kMainScreenWidth, 40);
    [seg setSelectedTextColor:[UIColor colorWithHexString:@"#344934"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ]];
    seg.selectionStyle = HMSegmentedControlSelectionStyleBox;
    seg.selectionLocation = HMSegmentedControlSelectionLocationDown;
    [seg setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:seg];
    
    [seg setIndexChangeBlock:^(NSInteger index) {
        
        switch (index) {
            case 0:
            {
                NSLog(@"打折");
            }
                break;
            case 1:
            {
                NSLog(@"滑雪");
            }
                break;
            case 2:
            {
                NSLog(@"放风筝");
            }
                break;
            case 3:
            {
                NSLog(@"轮滑");
            }
                break;
            default:
                break;
        }
    }];
}
-(void)navItemClick:(UIButton *)button
{
}

-(void)textFieldDidChange:(id)sender
{
    NSLog(@"change");
}
#pragma mark - uitxtfielddelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == dTag_searchText) {
        [textField resignFirstResponder];
    }
    return YES;
}
#pragma mark - tableViewDataSoure

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dataArray objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID  = @"ID";
    
    Cell_SellerActivity * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (nil == cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"Cell_SellerActivity" owner:self options:nil]lastObject];
    }
  
    NSMutableArray * smallArray = [_dataArray objectAtIndex:indexPath.section];
    cell.mainLabel.text = [smallArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"团购来袭，四折起";
    cell.loactionLabel.text = @"1000米";
    cell.joinLabel.text = @"320位熟人参与";
    
    if (indexPath.section == 0) {
         cell.shoppingCarIView.image = [UIImage imageNamed:@"saga.jpg"];
    }
    if (indexPath.section == 1) {
        
         cell.shoppingCarIView.image = [UIImage imageNamed:@"gouwuche.jpg"];
    }
    if (indexPath.section == 2) {
        cell.shoppingCarIView.image = [UIImage imageNamed:@"saga2.jpg"];
    }
    return cell;
}

#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * sectionLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth - 20, 35)];
    sectionLbl.text = _name[section];
    sectionLbl.textAlignment = NSTextAlignmentCenter;
    sectionLbl.backgroundColor = [UIColor purpleColor];
    return sectionLbl;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UITextField * search = (UITextField *)[self.view viewWithTag:dTag_searchText];
    [search resignFirstResponder];
}
@end
