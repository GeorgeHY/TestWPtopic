//
//  RegisterVC04.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-28.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "RegisterVC04.h"
#import "RegisterVC5.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIColor+AddColor.h"
#import "CheckDataTool.h"
#import "AFN_HttpBase.h"
#import "R04_tableViewItem.h"
#import "RegisterDataManager.h"
#import "UIViewController+General.h"
#import "SVProgressHUD.h"
#import "TimeTool.h"
#import "IQKeyBoardManager.h"
#import "IQSegmentedNextPrevious.h"

@interface RegisterVC04 (){
    NSUserDefaults * userDefaults;
    UIPopoverListView *poplistview;
    TableFlagEnum tableFlag;
    NSString * address;
    RegisterDataManager * _dataManager;
    NSString *_cid;
    NSString *area_Id;
}

@property (weak, nonatomic) IBOutlet UITextField *babyName;
@property (weak, nonatomic) IBOutlet UITextField *babyBirthday;
@property (weak, nonatomic) IBOutlet UITextField *hospital;


@property (weak, nonatomic) IBOutlet UIButton *twins;


@property (weak, nonatomic) IBOutlet UIButton *boy;

@property (weak, nonatomic) IBOutlet UIButton *girl;
@property (weak, nonatomic) IBOutlet UILabel *lable;

@property (nonatomic , strong) UITextField *searchF;


@property (nonatomic , strong) UIDatePicker * datePicker;

@property (nonatomic , strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSString * birthDay;//生日
@property (nonatomic, strong) NSString * isUnique;//是不是双多胞胎
@end

@implementation RegisterVC04
{
    AFN_HttpBase * http;
    UIButton * but;
    UISearchBar * _searchBar;
    int pageIndex;
    NSString * hospitalId;//医院的id
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _dataArray = [[NSMutableArray alloc]init];
      
        http = [[AFN_HttpBase alloc]init];
        
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated;
{
    //键盘自动布局
    [IQKeyBoardManager installKeyboardManager];
    [IQKeyBoardManager enableKeyboardManger];
}

-(void)viewWillDisappear:(BOOL)animated{

    //取消键盘自动布局
    [IQKeyBoardManager disableKeyboardManager];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
      userDefaults = [NSUserDefaults standardUserDefaults];
      self.view.backgroundColor = [UIColor colorWithHexString:@"#d5d6db"];
    self.title = @"添加宝宝信息";
    tableFlag = EHospital;//tableView 的类型为医院
    address = [userDefaults  objectForKey:UD_located];
    
    _dataManager = [RegisterDataManager shareInstance];
    //默认只有一个宝宝
    _dataManager.isUnique=@"1";
    
    [self initLeftItem];
    
    [self crateComponent];
}

-(void) crateComponent{
    
    //对勾
     [self.twins setBackgroundImage:[UIImage imageNamed:@"register1_check0.png"] forState:UIControlStateNormal];
    [self.twins setBackgroundImage:[UIImage imageNamed:@"register1_check1.png"] forState:UIControlStateSelected];
    [self.twins addTarget:self action:@selector(onClickTwinsBtn:) forControlEvents:UIControlEventTouchDown];
    self.twins.selected = NO;
    self.twins.tag = 1;
    self.twins.adjustsImageWhenHighlighted = NO;
    
    //我的宝宝是否是双胞胎
    [self.lable whenTapped:^{
        
        [self onClickTwinsBtn:self.twins];
        
    }];
    
    //男孩头像
    [self.boy setBackgroundImage:[UIImage imageNamed:@"baby_m_r.png"] forState:UIControlStateSelected];
    [self.boy addTarget:self action:@selector(onClickTwinsBtn:) forControlEvents:UIControlEventTouchDown];
    [self.boy setBackgroundImage:[UIImage imageNamed:@"baby_m_n.png"] forState:UIControlStateNormal];
    self.boy.selected = NO;
    _dataManager.childGender=@"2";
    self.boy.tag = 2;
    self.boy.adjustsImageWhenHighlighted = NO;
    [self.girl setBackgroundImage:[UIImage imageNamed:@"baby_w_r.png"] forState:UIControlStateSelected];
    [self.girl addTarget:self action:@selector(onClickTwinsBtn:) forControlEvents:UIControlEventTouchDown];
    [self.girl setBackgroundImage:[UIImage imageNamed:@"baby_w_n.png"] forState:UIControlStateNormal];
    self.girl.selected = YES;
    self.girl.tag = 3;
    self.girl.adjustsImageWhenHighlighted = NO;
    
    self.datePicker = [[UIDatePicker alloc] init];
    NSLocale *datelocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_TW"];
    self.datePicker.locale = datelocale;
    self.datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *date = [NSDate date];
    [self.datePicker setDate:date];
    
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSMutableArray *myToolBarItems = [NSMutableArray array];
    [myToolBarItems addObject:flexibleSpace];
    [myToolBarItems addObject:[[UIBarButtonItem alloc]
                               initWithTitle:@"确定"
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(cancelPicker)]];
    [toolBar setItems:myToolBarItems animated:YES];
    
    self.babyBirthday.inputAccessoryView = toolBar;
    self.babyBirthday.inputView = self.datePicker;
    
    self.babyBirthday.tag = 1;
    self.hospital.tag = 2;
    
    self.babyName.delegate = self;
    self.babyBirthday.delegate = self;
    self.hospital.delegate = self;
    
}

//点击xuanze
-(void) onClickTwinsBtn:(UIButton *) b{
    if (b.tag == 1) {
        self.twins.selected = !self.twins.selected;
        if(self.twins.selected==YES){
            _dataManager.isUnique=@"2";
        }else{
            _dataManager.isUnique=@"1";
        }
    }else if(b.tag == 2){
        self.boy.selected = YES;
        _dataManager.childGender=@"1";
        self.girl.selected = NO;
    }else{
        self.boy.selected = NO;
        self.girl.selected = YES;
        _dataManager.childGender=@"2";
    }
    
}

// 按下完成鈕後的 method
-(void) cancelPicker {
    if (![CheckDataTool checkInfo:self.babyName msgContent:@"请填写宝宝昵称"]) {
        return;
    }
    if ([self.view endEditing:NO]) {
        NSDate * date = self.datePicker.date;
        
        self.birthDay = [TimeTool getTimeWithDate:self.datePicker.date];
//        
//        _dataManager.childBrith=[TimeTool getTimeWithDate:self.datePicker.date];
        NSLog(@"生日%@",_dataManager.childBrith);
        
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        NSString * dateFormat = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"YYYY" , @"年" , @"MM" , @"月" , @"dd",@"日"];
        [dateFormatter  setDateFormat:dateFormat];
        NSString * dateS =  [dateFormatter stringFromDate:date];
        NSString * babyName = self.babyName.text;
        // 將選取後的日期 填入 UITextField
        self.babyBirthday.text = [NSString stringWithFormat:@"%@%@%@",babyName,@"的出生日期是: ",dateS];
    }
}

#pragma mark - 下一步

- (IBAction)nextBtnClick:(id)sender {
    
    if (![CheckDataTool checkInfo:self.babyName msgContent:@"请填写宝宝昵称"]) {
        return;
    }
    if (![CheckDataTool checkInfo:self.babyBirthday msgContent:@"请填写宝宝生日"]) {
        return;
    }
    if (![CheckDataTool checkInfo:self.hospital msgContent:@"请填写出生医院"]) {
        return;
    }
    
    [self saveData];
    
    RegisterVC5 * vc5 = [[RegisterVC5 alloc]initWithNibName:@"RegisterVC5" bundle:nil];
    
    [self.navigationController pushViewController:vc5 animated:YES];
}
#pragma mark - 保存注册数据到dm中
-(void)saveData
{
    //保存 性别， 宝宝昵称， 宝宝医院， 宝宝生日
    if (self.boy.selected) {
        _dataManager.childGender = @"1";
    }else{
        _dataManager.childGender = @"2";
    }
    
    _dataManager.childNickName = self.babyName.text;
    
    //出生医院的id
    _dataManager.hospitalID = hospitalId;
    
    _dataManager.childBrith = self.birthDay;
}


#pragma mark - textFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.babyBirthday resignFirstResponder];
    [self.babyName resignFirstResponder];
    [self.babyBirthday resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 2) {
        tableFlag = EHospital;
        self.search_Name=textField.text;
        [_dataArray  removeAllObjects];
        NSString *cid=[userDefaults objectForKey:@"cityID"];
        NSString *aid=[userDefaults objectForKey:@"areaId"];
        self.search_Name=@"";
//        [self requestHospitalDataWithCity:cid WithArea:aid];
        [self.view endEditing:NO];
        [textField  resignFirstResponder];
        [self popClickAction];
    }
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.search_Name=_searchBar.text;
    NSString *cityId=[userDefaults objectForKey:@"cityID"];
    NSString *areaId=[userDefaults objectForKey:@"areaId"];
    NSLog(@"city=%@   area=%@",cityId,areaId);
    [_dataArray removeAllObjects];
    
    [self requestHospitalDataWithCity:cityId WithArea:areaId];
    [_searchBar resignFirstResponder];
}

#pragma mark - 创建poplist

- (void)popClickAction
{
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = 272.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    UIView * v = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, xWidth, 90)];
    [v setBackgroundColor:[UIColor colorWithHexString:@"#d5d6db"]];
    [poplistview defalutInit:v];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = YES;
    
//    [self setupRefresh:poplistview.listView];
    
    UILabel * la = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 50, 40)];
    la.text = self.babyName.text;
    la.textAlignment = NSTextAlignmentCenter;
    [poplistview.v  addSubview:la];
    
    UILabel * la2 = [[UILabel alloc]initWithFrame:CGRectMake(la.bounds.size.width + 10, 10, 100, 40)];
    la2.text = @"在这里出生";
    [poplistview.v  addSubview:la2];
    
    but = [[UIButton alloc]  initWithFrame:CGRectMake(la.bounds.size.width + la2.bounds.size.width + 10,20, 60, 20)];
    //取到 用户所在城市 地址
    NSString * address=[userDefaults objectForKey:@"address"];
    [but setTitle:address forState:UIControlStateNormal];
    // [but setTitle:address forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [but setBackgroundImage:[UIImage imageNamed:@"public_dialog_btn.png"]forState:UIControlStateNormal];
    [but addTarget:self action:@selector(onClickCityBtn) forControlEvents:UIControlEventTouchUpInside];
    [poplistview.v addSubview:but];
    
    UIButton * butD = [[UIButton alloc]  initWithFrame:CGRectMake(
                                                                  xWidth - 60,
                                                                  0, 60, 45)];
    [butD setTitle:@"具体地址" forState:UIControlStateNormal];
    [butD setBackgroundColor:[UIColor colorWithHexString:@"#e8ba79"]];
    butD.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [butD addTarget:self action:@selector(onClickDetailCityBtn) forControlEvents:UIControlEventTouchUpInside];
    [poplistview.v addSubview:butD];
    
    
    self.searchF = [[UITextField alloc]  initWithFrame:CGRectMake(10, 50, xWidth - 20, 30)];
    
    UIImageView * magnify = [[UIImageView alloc]  initWithFrame:CGRectMake(10, 10, 20, 20)];
    UIImage * image = [UIImage imageNamed:@"public_ magnify.png"];
    magnify.image = image;
    _searchBar=[[UISearchBar alloc]init];
    _searchBar.frame= CGRectMake(10, 50, xWidth - 20, 30);
    _searchBar.delegate=self;
    _searchBar.placeholder=@"请输入医院名称";
    [poplistview.v addSubview:_searchBar];
    
    [poplistview show];
}

//监听textfiled的变化
- (void) textFieldDidChange:(id) sender {
    UITextField *_field = (UITextField *)sender;
    NSLog(@"%@",[_field text]);
    for (int i = 0; i<self.dataArray.count; i++) {
        
    }
}
#pragma mark -----点击城市按钮------
//点击城市按钮
-(void)onClickCityBtn{
    
    NSLog(@"onClickCityBtn");
    
    [http thirdRequestWithUrl:dUrl_PUB_1_1_1 succeed:^(NSObject *obj, BOOL isFinished) {
        NSDictionary* dicResult  = (NSDictionary *)obj;
        
        NSArray * array  = [dicResult  objectForKey:@"value"];
        for (int i = 0; i<array.count; i++) {
            R04_tableViewItem * item = [[R04_tableViewItem alloc] init];

            NSDictionary * d1 = [array  objectAtIndex:i];
            NSString  * name = [d1  objectForKey:@"name"];
            NSString  * cityId = [d1  objectForKey:@"id"];
            item.name = name;
            item._id = cityId;
            [self.dataArray addObject:item];
        }
        [poplistview reloadData];
        tableFlag = ECity;
    } failed:^(NSObject *obj, BOOL isFinished) {
        
    } andKeyValuePairs:@"zoneAreaQuery.level",
     @"1",@"zoneAreaQuery.parentID",@"",nil];
}

#pragma mark 设置医院所需要的参数hospitalQuery.cityID，hospitalQuery.zoneAreaID
/**获得医院信息**/
-(void)requestHospitalDataWithCity:(NSString *)cityId WithArea:(NSString *)areaId
{
    NSLog(@"requestHospitalDataWithCity");
    NSLog(@"name=%@",self.search_Name);
    if (self.search_Name.length==0) {
        self.search_Name=@"";
    }
    [http thirdRequestWithUrl:dUrl_PUB_1_2_1 succeed:^(NSObject *obj, BOOL isFinished) {
        NSDictionary* dicResult  = (NSDictionary *)obj;
        
        NSDictionary * valueDic  = [dicResult  objectForKey:@"value"];
        NSString *sValue=[NSString stringWithFormat:@"%@",valueDic];
        if ([sValue isEqualToString:@"<null>"]) {
            [SVProgressHUD showSimpleText:@"没有数据"];
            [poplistview reloadData];
            
            return;
        }
        
        NSArray *array=[valueDic objectForKey:@"list"];
        if (array.count==0) {
            [SVProgressHUD showSimpleText:@"没有数据"];
            return;
        }
        [self.dataArray  removeAllObjects];
        for (int i = 0; i<array.count; i++) {
            R04_tableViewItem * item = [[R04_tableViewItem alloc] init];
            NSDictionary * d1 = [array  objectAtIndex:i];
            NSString  * name = [d1  objectForKey:@"name"];
            NSString  * hospitalId = [d1  objectForKey:@"id"];
            item.name = name;
            item._id = hospitalId;
            [self.dataArray addObject:item];
        }
        [poplistview reloadData];
        tableFlag = EHospital;
    } failed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSimpleText:@"传参有误"];
    } andKeyValuePairs:@"hospitalQuery.cityID",
     cityId,@"hospitalQuery.zoneAreaID",areaId,@"hospitalQuery.name",self.search_Name,nil];
}


//区
-(void) onClickDetailCityBtn{
    NSLog(@"onClickDetailCityBtn");
    NSString * cityId = [userDefaults  objectForKey:@"cityID"];
    NSLog(@"城市的ID=%@",cityId);
    
    [self requestAreaData:cityId];
    tableFlag = EArea;
    [poplistview.listView reloadData];

}


#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:identifier] ;
    R04_tableViewItem * item = [_dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.name;
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    [self optionTableViewDataType:tableFlag didSelectIndexPath:indexPath];
}
#pragma mark 行政区ID
//请求区域列表
-(void)requestAreaData:(NSString *)_id{
    
    [self.dataArray removeAllObjects];
    [http thirdRequestWithUrl:dUrl_PUB_1_1_1 succeed:^(NSObject *obj, BOOL isFinished) {
        NSDictionary* dicResult  = (NSDictionary *)obj;
        // NSLog(@" dic==%@",dicResult);
        NSArray * array  = [dicResult  objectForKey:@"value"];
        [self.dataArray  removeAllObjects];
        if (array.count==0) {
            [SVProgressHUD showSimpleText:@"没有数据"];
            return;
        }
        for (int i = 0; i<array.count; i++) {
            R04_tableViewItem * item=[[R04_tableViewItem alloc]init];
            NSDictionary * d1 = [array  objectAtIndex:i];
            NSString  * name = [d1  objectForKey:@"name"];
            NSString  * cityId = [d1  objectForKey:@"id"];
            item.name=name;
            item._id=cityId;
            NSLog(@"ID=%@",item._id);
            [_dataArray addObject:item];
            
        }
        [poplistview reloadData];
    } failed:^(NSObject *obj, BOOL isFinished) {
        [SVProgressHUD showSimpleText:@"网络请求失败"];
        
    } andKeyValuePairs:@"zoneAreaQuery.level",
     @"2",@"zoneAreaQuery.parentID",_id,nil];
    
    
    
    
}
-(void) optionTableViewDataType:(TableFlagEnum) flag didSelectIndexPath:(NSIndexPath *)indexPath{
    switch (flag) {
        case EHospital://医院
        {
            R04_tableViewItem * item = [self.dataArray  objectAtIndex:indexPath.row];
         
            self.hospital.text = item.name;
               //这里是医院的id
            
            hospitalId = item._id;
            self.search_Name=@"";
            [poplistview dismiss];
            tableFlag = EHospital;
            break;
        }
        case ECity://城市
        {
            R04_tableViewItem * item  = [self.dataArray  objectAtIndex:indexPath.row];
            NSString * cityId = item._id;
            address = item.name;
            [but setTitle:address forState:UIControlStateNormal];
            [userDefaults setObject:address forKey:@"address"];
            // NSLog(@"xuanzhongID=%@",cityId);
            [userDefaults setObject:cityId forKey:@"cityID"];
            [self.dataArray removeAllObjects];
            self.search_Name=@"";
            [self requestAreaData:cityId];
            _cid=cityId;
            tableFlag = EArea;
            [poplistview reloadData];
            break;
        }
        case EArea://区域
        {
            R04_tableViewItem * item  = [self.dataArray  objectAtIndex:indexPath.row];
            NSString * areaId = item._id;
            [_dataArray removeAllObjects];
            NSLog(@"areid区=%@",areaId);
            [userDefaults setObject:areaId forKey:@"areaId"];
            if (_cid.length==0) {
                _cid=[userDefaults objectForKey:@"cityID"];
            }
            self.search_Name=@"";
            [self requestHospitalDataWithCity:_cid WithArea:areaId];
            tableFlag = EHospital;
            [poplistview reloadData];
            break;
        }
        default:
            break;
    }
    
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.babyBirthday  resignFirstResponder];
    [self.babyName resignFirstResponder];
    [self.hospital resignFirstResponder];
}

-(void) onTouchEvent{
    [self.searchF resignFirstResponder];
}

-(void)navItemClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
