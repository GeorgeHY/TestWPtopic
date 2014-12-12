//
//  MyDatumVC.m
//  if_wapeng
//
//  Created by 早上好 on 14-9-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
//我的资料
#define MAXTAG       10
#define dTag_righBtn 100
#define dTag_nickNameText 101//昵称的textField
#define dTag_addressContent 102//长居地
#define dTag_introContext    103//介绍
#define dTag_backBtn         104
#import "MyDatumVC.h"
#import "UIViewController+General.h"
#import "UIViewController+MMDrawerController.h"
#import "AppDelegate.h"
#import "MessageVC.h"
#import "UIView+WhenTappedBlocks.h"
#import "UIImage+Stretch.h"
#import "Cover.h"
#import "QRCodeController.h"
#import "UIImageView+WebCache.h"
//自动管理键盘
#import "IQKeyBoardManager.h"
#import "IQSegmentedNextPrevious.h"
#import "RegisterMapViewController.h"
@interface MyDatumVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate, UITextFieldDelegate, PassValueDelegate>
{
    UIImageView  *_iconView;//头像
    UIScrollView *_bgView;
    UITextField  *_nickNameText;//昵称
    UIButton     *_btnSelect;
    NSString     *_sex;//性别a
    NSString     *_nickName;//昵称
    NSString     *_intro;//简介
    UIButton     *_rightBtn;
    UILabel      *_addressContent;//长居地址
    NSString     *_address;//地址
    UITextField     *_introContext;
    UITextField  *_introText; //简介更改文本框
    BOOL         _introBool;//是否正在编辑简介
    UIView       *_selectPhotoSource;
    Cover        *_cover;//遮盖
    NSString     *_filePath;
    BOOL         _isSave;//是否已保存
    
    AFN_HttpBase * http;
}

@property (nonatomic, strong) NSMutableDictionary * resultDict;


@property (nonatomic, strong) NSString * sex;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UITextField * introText;
@property (nonatomic, strong) UILabel *numAccount;

@property (nonatomic, assign) BOOL canBack;//是否可以返回
@end

@implementation MyDatumVC
@synthesize numAccount;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        http = [[AFN_HttpBase alloc]init];
        _resultDict = [[NSMutableDictionary alloc]init];
        self.item = [[DataItem alloc]init];
    }
    return self;
}
#pragma mark - 修改地理位置信息

-(void)changePlaceWithLat:(NSString *)lat lon:(NSString *)lon
{

    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d  objectForKey:UD_ddid];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:lat, @"userInfo.latitude", lon, @"userInfo.longitude",self.item.mid, @"userInfo.zoneArea.id",ddid , @"D_ID" ,  nil];
    [http fiveReuqestUrl:dUrl_OSM_1_1_11 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
       
        [SVProgressHUD showSuccessWithStatus:dTips_changeSuccess];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:dTips_changeFailed];
    }];
}

#pragma mark - 修改性别
-(void)changeGenderRequest:(int)gender
{
    
    if (gender == 1) {
        
        _sex = @"男";
    }else{
        
        _sex = @"女";
    }
    
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    NSString * ddid =[d objectForKey:UD_ddid];
    NSString * str = [NSString stringWithFormat:@"%d", gender];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:str, @"userInfo.userInfoExtension.gender",ddid, @"D_ID" , nil];
    
    [http fiveReuqestUrl:dUrl_OSM_1_1_9 postDict:dict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:dTips_changeSuccess];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:dTips_changeFailed];
        
    }];
}

#pragma mark - 上传图片
-(void)changeImage:(UIImage *)image WithImageId:(NSString *)imageId
{
    __weak UIButton * back =  (UIButton *)[self.view viewWithTag:dTag_backBtn];
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", imageId, @"userInfo.photo.id",nil];
    [http sevenReuqestWithUrl:dUrl_OSM_1_1_8 postDict:postDict image:image successed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:dTips_uploadSuccess];
        
        back.enabled = YES;
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:dTips_uploadError];
        
        back.enabled = YES;
    }];
}
#pragma mark - 上传图片得到图片id

-(void)getPhotoIDWithImage:(UIImage *)image
{
    
    __weak UIButton * back =  (UIButton *)[self.view viewWithTag:dTag_backBtn];
    //先让back不能点击
    back.enabled = NO;
    __weak MyDatumVC * weakSelf = self;
    
    [http sevenReuqestWithUrl:dUrl_PUB_1_5_1 postDict:nil image:image successed:^(NSObject *obj, BOOL isFinished) {
        
        //        [SVProgressHUD showSuccessWithStatus:@"图片上传成功"];
        
        NSDictionary * root = (NSDictionary *)obj;
        
        NSString *myID = [[root objectForKey:@"value"] objectForKey:@"id"];
        
        [weakSelf changeImage:image WithImageId:myID];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        back.enabled = YES;
        [SVProgressHUD showErrorWithStatus:@"上传失败"];
        
    }];
    
}
#pragma mark - 根据不同的textfield值更改信息
-(void)changeTextRequestWithTag:(NSInteger)tag withText:(NSString *)text
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString * ddid = [d objectForKey:UD_ddid];
    
    NSString * url = nil;
    
    NSDictionary * dict = nil;
    switch (tag) {
        case dTag_nickNameText:
        {
            url = dUrl_OSM_1_1_6;
            
            NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", text, @"userInfo.petName", nil];
            dict = postDict;
        }
            break;
        case dTag_addressContent:
        {
            url = dUrl_OSM_1_1_11;
            
            
        }
            break;
        case dTag_introContext:
        {
            url = dUrl_OSM_1_1_10;
            
            NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:ddid, @"D_ID", text, @"userInfo.userInfoExtension.personnelSignature", nil];
            dict = postDict;
        }
            break;
        default:
            break;
    }
    [http fiveReuqestUrl:url postDict:dict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:dTips_changeSuccess];

    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:dTips_changeFailed];
        
    }];
}
- (void)viewWillAppear:(BOOL)animated;
{
    
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = YES;
    //键盘自动布局
    [IQKeyBoardManager installKeyboardManager];
    [IQKeyBoardManager enableKeyboardManger];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self hideCover];
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = NO;
    //取消键盘自动布局
    [IQKeyBoardManager disableKeyboardManager];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的资料";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    if (self.item.gender == 1) {
        
        _sex = @"男";
    }else{
        _sex = @"女";
    }
    
    NSLog(@"self.item:%@", self.item);
    _nickName = [NSString string];
    _nickName = self.item.petName;
    _address = [NSString string];
    _address = self.item.located;
    
    NSLog(@"%@", self.item.located);
    _intro = [NSString string];
    _intro = self.item.personnelSignature;

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.tag = dTag_righBtn;
    rightBtn.frame = CGRectMake(0, 0, 70, 30);
    [rightBtn setTitle:@"我的宝宝" forState:UIControlStateNormal];
    UIColor *titleColor = kRGB(68, 138, 249);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(navItemClick:) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn = rightBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    UIImage *backImage = [UIImage imageNamed:@"public_back"];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    back.tag = dTag_backBtn;
    [back setImage:backImage forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"public_back_hightLight"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = left;
    [self buildUI];
//    [self httpRequestWithUrl:dUrl_OSM_1_1_3];
}

-(void)buildUI{
    [self addLineBlack:0];
    UIImage *icon = [UIImage imageNamed:@"zjgw_logo"];
    UIImageView *iconView = [[UIImageView alloc]initWithImage:icon];
    //设置头像
    
    
    [iconView setImageWithURL:[NSURL URLWithString:self.item.relativePath] placeholderImage:kDefaultPic];
    
    iconView.frame = CGRectMake(0, 0, 70, 70);
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = 4;
    iconView.center = CGPointMake(kMainScreenWidth * 0.5, 70 * 0.5 + 10);
    [self.view addSubview:iconView];
    iconView.userInteractionEnabled = YES;
    _iconView = iconView;
    [iconView whenTapped:^{
        
        [self changeIconView];
    }];
    
    numAccount = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame) + 10, kMainScreenWidth, 16)];
//    numAccount.text = @"123456";
    numAccount.text = self.item.wpCode;
    numAccount.textColor = [UIColor grayColor];
    numAccount.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:numAccount];
    
    [self addLineBlack:CGRectGetMaxY(numAccount.frame) + 10];
    
    UILabel *nickName = [self addLabel:@"昵称" y:CGRectGetMaxY(numAccount.frame) + 19 hide:NO];
    UITextField *nickNameText = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(numAccount.frame) + 16, kMainScreenWidth - 20 - kMainScreenWidth * 0.4, 24)];
    nickNameText.delegate = self;
    nickNameText.leftView = nickName;
    nickNameText.leftViewMode = UITextFieldViewModeAlways;
    nickNameText.text = _nickName;
    nickNameText.tag = dTag_nickNameText;
    nickNameText.font = [UIFont systemFontOfSize:14];
    nickNameText.delegate = self;
    [self.view addSubview:nickNameText];
    _nickNameText = nickNameText;
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSInteger type = [[d objectForKey:UD_userType]integerValue];
    
    NSLog(@"%d", type);
    if (type != AGENT_USER) {
        
        for (int i = 0; i < 2; i ++) {
            [self addSexButton:i y:nickName.frame.origin.y];
        }
    }
    [self addLineBlack:CGRectGetMaxY(nickNameText.frame) + 8];
    
    UILabel *reminder = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nickName.frame) + 13, kMainScreenWidth, 14)];
    reminder.text = @"设置好常居地才能正确的获得身边的邻居";
    reminder.textColor = kRGB(229, 129, 59);
    reminder.font = [UIFont systemFontOfSize:12];
    reminder.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:reminder];
    
    UILabel *address = [self addLabel:@"长居" y:CGRectGetMaxY(reminder.frame) + 5 hide:NO];
    [self.view addSubview:address];
    
    UILabel *addressContent = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(address.frame), address.frame.origin.y, kMainScreenWidth - CGRectGetMaxX(address.frame) - kMainScreenWidth * 0.1, 24)];
    addressContent.numberOfLines = 2;
    addressContent.tag = dTag_addressContent;
//    addressContent.borderStyle = UITextBorderStyleLine;
    addressContent.text = _address;
    
    NSLog(@"%@", _address);
    addressContent.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:addressContent];
    [self addArrowRight:address.frame.origin.y];
    _addressContent = addressContent;
    
    
    __weak MyDatumVC * weakSelf = self;
    [_addressContent whenTapped:^{
        
        RegisterMapViewController * resgisetrVC = [[RegisterMapViewController alloc]init];
        
        resgisetrVC.passDelegate = weakSelf;
        [weakSelf.navigationController pushViewController:resgisetrVC animated:YES];
    }];
    
    [self addLineBlack:CGRectGetMaxY(address.frame) + 10];
    
    UILabel *myQRCode = [self addLabel:@"我的二维码" y:CGRectGetMaxY(address.frame) + 20 hide:YES];
    CGRect frame = myQRCode.frame;
    frame.size.width = kMainScreenWidth;
    myQRCode.frame = frame;
    [self.view addSubview:myQRCode];
    [myQRCode whenTapped:^{
        [self showMindeQRCode];
    }];
    UIImage *image = [UIImage imageNamed:@"QR_code"];
    UIImageView *img = [[UIImageView alloc]initWithImage:image];
    img.center = CGPointMake(kMainScreenWidth * 0.7, myQRCode.frame.origin.y + image.size.height * 0.5);
    [self.view addSubview:img];
    [self addArrowRight:myQRCode.frame.origin.y];
    
    [self addLineBlack:CGRectGetMaxY(myQRCode.frame) + 10];
    
    UILabel *intro = [self addLabel:@"一句话介绍" y:CGRectGetMaxY(myQRCode.frame) + 20 hide:YES];
    [self.view addSubview:intro];
    
    CGSize size = [_intro boundingRectWithSize:CGSizeMake(kMainScreenWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    UITextField *introContext = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(intro.frame) + 4, kMainScreenWidth - 40, size.height + 10)];
    introContext.delegate = self;
    introContext.tag = dTag_introContext;
    introContext.text = _intro;
    introContext.font = [UIFont systemFontOfSize:14];
    _introContext = introContext;
    [self.view addSubview:introContext];
    [introContext whenTapped:^{
        [self editIntroContent];
    }];
    
    _introText = [[UITextField alloc]initWithFrame:CGRectMake(0, kMainScreenHeight, kMainScreenWidth, 40)];
    _introText.delegate = self;
    _introText.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    _introText.leftViewMode = UITextFieldViewModeAlways;
    _introText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_introText];
    
    [self addLineBlack:CGRectGetMaxY(introContext.frame) + 10];
}

#pragma mark  -添加>
-(void)addArrowRight:(CGFloat)y{
    UIImage *image = [UIImage imageNamed:@"arrow_right"];
    UIImageView *img = [[UIImageView alloc]initWithImage:image];
    img.center = CGPointMake(kMainScreenWidth * 0.9, y + image.size.height * 0.5 + 5);
    [self.view addSubview:img];
}

#pragma mark  -添加带竖线的label
-(UILabel *)addLabel:(NSString *)title y:(CGFloat)y hide:(BOOL)hide{
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 24) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, y, size.width + 26, 24)];
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(label.frame.size.width - 7, 0, 1, label.frame.size.height)];
    img.backgroundColor = [UIColor grayColor];
    [label addSubview:img];
    
    if (hide) {
        img.hidden = YES;
    }
    return label;
}

#pragma mark  -添加横线
-(void)addLineBlack:(CGFloat)y{
    UIImageView *blackLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, kMainScreenWidth, 1)];
    blackLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackLine];
}

#pragma mark  -左边导航按钮的点击事件
-(void)backClick:(UIButton *)button
{
    
    /*新加入的*/
    
    UITextField * tf1 = (UITextField *)[self.view viewWithTag:dTag_introContext];
    UITextField * tf2 = (UITextField *)[self.view viewWithTag:dTag_nickNameText];

    //请求
    
    if (![_intro  isEqualToString:tf1.text]) {
        
        [self changeTextRequestWithTag:tf1.tag withText:tf1.text];
    }
    
    if (![_nickName isEqualToString:tf2.text]) {
        
        [self changeTextRequestWithTag:tf2.tag withText:tf2.text];
    }
    
    //机构用户不用区分男女
    
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSInteger type = [[d objectForKey:UD_userType] intValue];
    
    if (!type == AGENT_USER) {
        
        NSInteger iSex;
        
        if ([_sex isEqualToString: @"男"]) {
            iSex = 1;
        }else{
            iSex = 2;
        }
        
        if (self.item.gender != iSex) {
            
            [self changeGenderRequest:iSex];
        }

    }
    
    if (self.type == 1 ) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    if (self.type == 2) {
        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
}

#pragma mark  -添加性别选择按钮
-(void)addSexButton:(int)index y:(CGFloat)y{
    CGFloat x;
    NSString *title;
    if (index) {
        x = kMainScreenWidth * 0.6 + 40;
        title = @"女";
    }else{
        x = kMainScreenWidth *0.6;
        title = @"男";
    }
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y - 3, 40, 30)];
    if ([_sex isEqualToString:@"男"] && index == 0) {
        btn.selected = YES;
        _btnSelect = btn;
     
    }
    if ([_sex isEqualToString:@"女"] && index == 1) {
        btn.selected = YES;
        _btnSelect = btn;
        
       
    }
    if (index) {
        [btn setBackgroundImage:[UIImage imageNamed:@"me_women"] forState:UIControlStateSelected];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"me_man"] forState:UIControlStateSelected];
    }
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    btn.tag = index + 10;
    [btn addTarget:self action:@selector(btnClickSelectSex:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark  -性别选择按钮点击时间
-(void)btnClickSelectSex:(UIButton *)sender{
    _btnSelect.selected = NO;
    sender.selected = YES;
    _btnSelect = sender;
    switch (sender.tag) {
        case MAXTAG:
        {
            [self changeGenderRequest:1];
        }
            break;
        case MAXTAG + 1:
        {
            [self changeGenderRequest:2];

        }
            break;
        default:
            break;
    }

}

#pragma mark  右边导航按钮点击时间
-(void)navItemClick:(UIButton *)sender
{
    NSString *title = [sender titleForState:UIControlStateNormal];
    if ([title isEqualToString:@"保存"]) {
        [self saveInfo];
        NSLog(@"上传更改的用户信息");
    }else{
        MessageVC *message = [[MessageVC alloc]initWithNibName:@"MessageVC" bundle:nil];
        [self.navigationController pushViewController:message animated:YES];
    }
}

#pragma mark  - 保存修改内容
-(void)saveInfo{
    _isSave = YES;
    [_rightBtn setTitle:@"我的宝宝" forState:UIControlStateNormal];
}

#pragma mark  -更改头像
-(void)changeIconView{
    if (_cover == nil) {
        _cover = [Cover coverWithTarget:self action:@selector(hideCover)];
    }
    _cover.frame = self.navigationController.view.frame;
    _cover.alpha = 0;
    [self.view addSubview:_cover];
    if (_selectPhotoSource == nil) {
        _selectPhotoSource = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, kMainScreenWidth, 130)];
        _selectPhotoSource.backgroundColor = [UIColor clearColor];
        NSArray  *arr = @[@"打开照相机",@"从相册获取",@"取消"];
        for (int i = 0; i < arr.count; i ++) {
            [self addBtn:i title:arr[i]];
        }
    }
    [self.view addSubview:_selectPhotoSource];
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.1;
        CGRect frame = _selectPhotoSource.frame;
        frame.origin.y -= _selectPhotoSource.frame.size.height;
        _selectPhotoSource.frame = frame;
    }];
    NSLog(@"切换头像");
}

#pragma mark  -照片源选择按钮
-(void)addBtn:(int)index title:(NSString *)title{
    CGFloat x = (index == 2) ? 5 : 1;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, index * (40 + x), kMainScreenWidth - 20, 40)];
    [btn setBackgroundImage:[UIImage resizedImage:@"bh_n.png"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImage:@"bh_d.png"] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(selectPhotoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_selectPhotoSource addSubview:btn];
}

#pragma mark  -隐藏遮盖
-(void)hideCover{
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0;
        CGRect frame = _selectPhotoSource.frame;
        frame.origin.y += _selectPhotoSource.frame.size.height;
        _selectPhotoSource.frame = frame;
    }completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [_selectPhotoSource removeFromSuperview];
    }];
}

#pragma mark  -照片源选择点击事件
-(void)selectPhotoBtnClick:(UIButton *)sender{
    NSString *title = [sender titleForState:UIControlStateNormal];
    if ([title isEqualToString:@"打开照相机"]) {
        //打开照相机拍照
        [self takePhoto];
        NSLog(@"打开照相机");
    }else if ([title isEqualToString:@"从相册获取"]) {
        //打开本地相册
        [self LocalPhoto];
        NSLog(@"从相册获取");
    }else{
        [self hideCover];
        NSLog(@"取消");
    }
}

#pragma mark  -打开照相机
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
        
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

#pragma mark  -从相册获取
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        if (image) {
            //上传图片
            _iconView.image = image;
            
            [self getPhotoIDWithImage:image];
        }
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
   
    }
    
}


#pragma mark  -切换常居地
-(void)changeAddress{
    NSLog(@"切换常居地");
}

#pragma mark  -展示我的二维码
-(void)showMindeQRCode{
    QRCodeController *QRCode = [[QRCodeController alloc]init
                                ];
    QRCode.icon = _iconView.image;
    [self.navigationController pushViewController:QRCode animated:YES];
    NSLog(@"我的二维码");
}

#pragma mark  -更改简介
-(void)editIntroContent{
    NSLog(@"简介更改");
    [_introText becomeFirstResponder];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGFloat offsetY = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    if (_introBool) {
        [UIView animateWithDuration:duration animations:^{
            CGRect frame = _introText.frame;
            CGFloat y = [UIScreen mainScreen].bounds.size.height;
            if (endKeyboardRect.origin.y == y) {
                frame.origin.y = kMainScreenHeight;
            }else{
                frame.origin.y = endKeyboardRect.origin.y - frame.size.height - 64;
            }
            _introText.frame = frame;
        }];
    }else{
        return;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        [self saveInfo];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:dNoti_isHideKeyBoard object:@"1"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_nickNameText resignFirstResponder];
    [_introText resignFirstResponder];
}

#pragma mark - uitextFieldDelegate



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
//    [self changeTextRequestWithTag:textField.tag];

    return YES;
}

#pragma mark- 失去焦点

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView * view in self.view.subviews) {
        
        if ([view isKindOfClass:[UITextField class]]) {
            
            [view resignFirstResponder];
        }
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField.tag == dTag_introContext) {
        
        if ([textField.text isEqualToString:_intro]) {
            return;
        }else{
            
            _intro = textField.text;
        }
    }
    
    if (textField.tag == dTag_nickNameText) {
        
        if ([textField.text isEqualToString:_nickName]) {
            
            return;
        }else{
             _nickName = textField.text;
        }
    }
    if (textField.text.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入合法信息"];
    
        return;
    }
    //修改昵称和个人信息
    [self changeTextRequestWithTag:textField.tag withText:textField.text];
}

#pragma  mark - 地图回调

- (void)sendLon:(NSString *)lon WithLat:(NSString *)lat WithPlaceName:(NSString *)name
{
    _address = name;
    
    UILabel * lbl = (UILabel *)[self.view viewWithTag:dTag_addressContent];
    lbl.text = name;
    
    [self changePlaceWithLat:lat lon:lon];
}
@end
