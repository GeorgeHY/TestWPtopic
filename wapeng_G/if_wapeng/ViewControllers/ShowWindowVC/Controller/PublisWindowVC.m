//
//  PublisWindowVC.m
//  if_wapeng
//
//  Created by 心 猿 on 14-10-22.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#define kBtnW 70
#define ARRSIZE(a)      (sizeof(a) / sizeof(a[0]))
#import "PublisWindowVC.h"
#import "RegisterText.h"
#import "SelectLabelViewController.h"
#import "DoImagePickerController.h"
#import "IF_TBCViewController.h"
#import "FaceBg.h"
#import <CoreText/CoreText.h>
#import "FastTextView.h"
#import "EmotionAttachmentCell.h"
#import "UIImage-Extensions.h"
#import "TextConfig.h"
#import "UIViewController+MMDrawerController.h"
#import "AppDelegate.h"
#import "RegisterMapViewController.h"
#import "BaseMapViewController.h"
#import "UserLocationViewController.h"
@interface PublisWindowVC ()<DoImagePickerControllerDelegate,UITextViewDelegate,faceViewDelegate, PassValueDelegate>
{
    UITextField             *_titleText;   //标题
    UIButton                *_validity;    //选择有效期
    DoImagePickerController *_imagePicker;
    UIScrollView            *_imageVessel;
    UIView                  *_bgViewIsImage;
    UIView                  *_viewBg;
    CGRect                  _startRect;
    UIView                  *_validityView;
    FaceBg                  *_faceView;
    NSMutableString         *_contentTextStr;//最终需要发送的文本内容
    CGRect                  _oldFrame;
    AFN_HttpBase * http;

}
@property (nonatomic, strong) NSMutableArray * imageIDArr;
@property (nonatomic, strong) NSString * place;//地点

//高德地图
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation PublisWindowVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        http = [[AFN_HttpBase alloc]init];
        _imageIDArr = [[NSMutableArray alloc]init];
        
        [self initSearch];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    AppDelegate * app = [AppDelegate shareInstace];
    app.mTbc.mainView.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"新增瞬间";
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = kRGB(235, 235, 235);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(faceImageBtnClick:) name:kFaceImgBtnClick object:nil];
    _faceView = [[FaceBg alloc]initWithFrame:CGRectMake(0, kMainScreenHeight - 44, kMainScreenWidth, 170)];
    [self.view addSubview:_faceView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self BuildUI];
    
    [self initMapView];
    
    
    __weak PublisWindowVC * weakSelf = self;
    [self.mm_drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        
        [weakSelf.fastTextView resignFirstResponder];
        
        return 0;
        
    }];
}

-(void)BuildUI{
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorWithRed:65/255.0 green:138/255.0 blue:247/255.0 alpha:1] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:65/255.0 green:138/255.0 blue:247/255.0 alpha:1] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(selectLabel) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    
//    UITextField *titleText = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, kMainScreenWidth - 20, 35)];
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, titleText.frame.size.height)];
//    titleText.leftView = view;
//    titleText.leftViewMode = UITextFieldViewModeAlways;
//    titleText.backgroundColor = [UIColor whiteColor];
//    titleText.placeholder = @"本区域内的文字默认为标题";
//    titleText.layer.masksToBounds = YES;
//    titleText.layer.cornerRadius = 5;
//    [self.view addSubview:titleText];
//    _titleText = titleText;
    
    _imageVessel = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 20 , kMainScreenWidth - 20, 120)];
    _imageVessel.backgroundColor = [UIColor whiteColor];
    _imageVessel.showsVerticalScrollIndicator = NO;
    _imageVessel.layer.masksToBounds = YES;
    _imageVessel.layer.cornerRadius = 5;
    _imageVessel.bounces = NO;
    [self.view addSubview:_imageVessel];
    
    if (self.fastTextView==nil) {
        
        FastTextView *view = [[FastTextView alloc] initWithFrame:CGRectMake(0, 0, _imageVessel.frame.size.width, 120)];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.delegate = (id<FastTextViewDelegate>)self;
        view.attributeConfig=[TextConfig editorAttributeConfig];
        view.delegate = (id<FastTextViewDelegate>)self;
        [view setFont:[UIFont systemFontOfSize:15]];
        view.pragraghSpaceHeight=13;
        view.backgroundColor=[UIColor clearColor];
        
        [_imageVessel addSubview:view];
        self.fastTextView = view;
    }
    
    _bgViewIsImage = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.fastTextView.frame), _imageVessel.frame.size.width, _imageVessel.frame.size.width - CGRectGetMaxY(self.fastTextView.frame) - 5)];
    [_imageVessel addSubview:_bgViewIsImage];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageVessel.frame) + 3, 35, 15)];
//    label.text = @"有效期";
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor grayColor];
//    [self.view addSubview:label];
    
    UIButton *validity = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 5, label.frame.origin.y, 48, 15)];
//    [validity setTitle:@"3天" forState:UIControlStateNormal];
    validity.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    validity.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    validity.titleLabel.font = [UIFont systemFontOfSize:13];
    [validity setBackgroundImage:[UIImage imageNamed:@"validity.png"] forState:UIControlStateNormal];
    [validity addTarget:self action:@selector(selectValidity) forControlEvents:UIControlEventTouchUpInside];
    [validity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:validity];
    _validity = validity;
    
//    UIButton *location = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(validity.frame) + 35, validity.frame.origin.y - 1, 85, 18)];
    UIButton * location = [[UIButton alloc]init];
    CGRect frame = validity.frame;
    frame.size.width = 85;
    location.frame = frame;
    [location setTitle:@"添加位置" forState:UIControlStateNormal];
    location.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    location.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    location.titleLabel.font = [UIFont systemFontOfSize:13];
    [location setBackgroundImage:[UIImage imageNamed:@"addLocation.png"] forState:UIControlStateNormal];
    [location addTarget:self action:@selector(addLocation) forControlEvents:UIControlEventTouchUpInside];
    [location setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:location];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(location.frame) + 3, kMainScreenWidth, 1)];
    img.backgroundColor = kRGB(190, 190, 190);
    [self.view addSubview:img];
    
    _viewBg = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame), kMainScreenWidth, 40)];
    _startRect = _viewBg.frame;
    _faceView.delegate = self;
    _oldFrame = _viewBg.frame;
    _viewBg.backgroundColor = kRGB(235, 235, 235);
    [self.view addSubview:_viewBg];
    
    NSArray *icon = @[@"keyboardDown.png",@"selectImage.png",@"face.png"];
    for (int i =0 ; i< icon.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i * kBtnW, 5 , kBtnW, 30)];
        [btn setImage:[UIImage imageNamed:icon[i]] forState:UIControlStateNormal];
        btn.tag = 101 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_viewBg addSubview:btn];
    }
    
//    _validityView = [[UIView alloc]initWithFrame:CGRectMake(validity.frame.origin.x, CGRectGetMaxY(validity.frame), validity.frame.size.width, 15 * 3)];
//    _validityView.backgroundColor = kRGB(59, 206, 81);
//    _validityView.alpha = 0.0;
//    [self.view bringSubviewToFront:_validityView];
//    [self.view addSubview:_validityView];
//    NSArray *arr = @[@"3天",@"7天",@"不限"];
//    for (int i = 0; i < arr.count; i ++) {
//        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, i * 15 , _validityView.frame.size.width, 15)];
//        [btn setTitle:arr[i] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:13];
//        [btn addTarget:self action:@selector(validityClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_validityView addSubview:btn];
//    }
}

#pragma mark  -放下键盘、选择图片、添加表情
-(void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 101:{
            [_titleText resignFirstResponder];
            [self.fastTextView resignFirstResponder];
        }
            break;
        case 102:{
            DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
            cont.delegate = self;
            cont.nResultType = DO_PICKER_RESULT_UIIMAGE;
            cont.nMaxCount = 4;     // larger than 1
            cont.nColumnCount = 3;
            cont.title = @"我的照片流";
            //            cont.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            self.navigationController.navigationBar.hidden = YES;
            UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:cont];
            nc.navigationBar.translucent = NO;
            nc.modalTransitionStyle =UIModalTransitionStyleFlipHorizontal;            [self presentViewController:nc animated:YES completion:nil];

        }
            break;
        case 103:{
            sender.selected = !sender.selected;
            if (sender.selected) {
                [self.fastTextView resignFirstResponder];
                self.fastTextView.inputView = _faceView;
                [self.fastTextView becomeFirstResponder];
            }else{
                self.fastTextView.inputView = nil;
                [self.fastTextView reloadInputViews];
                [self.fastTextView becomeFirstResponder];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
    __weak PublisWindowVC * weakSelf = self;
    
    for (int i = 0; i < aSelected.count; i++) {
        
        //        NSDictionary * postDict = []
        [http sevenReuqestWithUrl:dUrl_PUB_1_5_1 postDict:nil image:aSelected[i] successed:^(NSObject *obj, BOOL isFinished) {
            
            [SVProgressHUD showSuccessWithStatus:@"图片上传成功"];
            
            NSDictionary * root = (NSDictionary *)obj;
            
            NSString *myID = [[root objectForKey:@"value"] objectForKey:@"id"];
            
            NSLog(@"iiiidddd:%@", myID);
            
            [weakSelf.imageIDArr addObject:myID];
            
            //             [weakSelf.imageIDArr addObject:root];
            
            
            
        } failed:^(NSObject *obj, BOOL isFinished) {
            
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
            
        }];
        
    }
//    [self hideImagePicker];
}

-(void)didCancelDoImagePickerController{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  日期选择事件
-(void)validityClick:(UIButton *)sender{
    NSString *title = [sender titleForState:UIControlStateNormal];
    [_validity setTitle:title forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        _validityView.alpha = 0.0;
    }];
}

#pragma mark  隐藏照片浏览器
-(void)hideImagePicker{
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = nav.view.frame;
        frame.origin.y = kMainScreenHeight;
        nav.view.frame = frame;
    } completion:^(BOOL finished) {
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
    }];
}

#pragma mark  -textView的代理
-(void)fastTextViewDidChange:(UITextView *)textView{
    CGRect frameText = self.fastTextView.frame;
    frameText.size.height = textView.contentSize.height;
    self.fastTextView.frame = frameText;
    
    CGRect frameImageView = _bgViewIsImage.frame;
    frameImageView.origin.y = CGRectGetMaxY(self.fastTextView.frame);
    _bgViewIsImage.frame = frameImageView;
    
    _imageVessel.contentSize = CGSizeMake(0, _bgViewIsImage.frame.size.height + self.fastTextView.frame.size.height);
}


#pragma mark  -键盘高度变化时执行的方法
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat y = [UIScreen mainScreen].bounds.size.height;
    if (endKeyboardRect.origin.y == y) {
        [UIView animateWithDuration:duration animations:^{
            _viewBg.frame = _oldFrame;
        }];
    }else{
        if (CGRectGetMaxY(_oldFrame) < endKeyboardRect.origin.y) {
            [UIView animateWithDuration:duration animations:^{
                CGFloat detal = endKeyboardRect.origin.y - 74 - CGRectGetMaxY(_oldFrame);
                CGRect frame = _viewBg.frame;
                frame.origin.y += detal;
                _viewBg.frame = frame;
            }];
        }
    }
}

#pragma mark  -选择有效期
-(void)selectValidity{
    [UIView animateWithDuration:0.3 animations:^{
        _validityView.alpha = 1.0;
    }];
}

#pragma mark  选中了表情
-(void)faceViewSelect:(NSString *)str{
    if ([str isEqualToString:@"回退"]) {
        [self.fastTextView deleteBackward];
    }else{
        [self addEmotion:str];
    }
}


#pragma mark  -字符串拼接
-(void)stringChenge{
    NSAttributedString *str = self.fastTextView.attributedString;
    NSDictionary *attributeDict;
    NSRange effectiveRange = { 0, 0 };
    NSString *text = self.fastTextView.text;
    NSRange  subRange = {0, 0};
    _contentTextStr = [NSMutableString string];
    NSString *lastStr = [NSString string];
    do {
        NSRange range;
        range = NSMakeRange (NSMaxRange(effectiveRange),
                             [str length] - NSMaxRange(effectiveRange));
        attributeDict = [str attributesAtIndex: range.location
                         longestEffectiveRange: &effectiveRange
                                       inRange: range];
        NSString *imageName = attributeDict[@"imageName"];
        if (imageName) {
            if ([lastStr isEqualToString:[text substringWithRange:subRange]]) {
                [_contentTextStr appendString:imageName];
            }else{
                lastStr = [text substringWithRange:subRange];
                [_contentTextStr appendString:[text substringWithRange:subRange]];
                [_contentTextStr appendString:imageName];
            }
        }else{
            subRange = effectiveRange;
        }
    } while (NSMaxRange(effectiveRange) < [str length]);
    [_contentTextStr appendString:[text substringWithRange:subRange]];
}

- (void)addEmotion:(NSString *)emotionImgName;
{
    
    UITextRange *selectedTextRange = [self.fastTextView selectedTextRange];
    if (!selectedTextRange) {
        UITextPosition *endOfDocument = [self.fastTextView endOfDocument];
        selectedTextRange = [self.fastTextView textRangeFromPosition:endOfDocument toPosition:endOfDocument];
    }
    UITextPosition *startPosition = [selectedTextRange start] ; // hold onto this since the edit will drop
    
    unichar attachmentCharacter = FastTextAttachmentCharacter;
    [self.fastTextView replaceRange:selectedTextRange withText:[NSString stringWithFormat:@"%@",[NSString stringWithCharacters:&attachmentCharacter length:1]]];
    

    //    startPosition=[self.fastTextView positionFromPosition:startPosition inDirection:UITextLayoutDirectionRight offset:1];
    UITextPosition *endPosition = [self.fastTextView positionFromPosition:startPosition offset:1];
    selectedTextRange = [self.fastTextView textRangeFromPosition:startPosition toPosition:endPosition];
    
    
    NSMutableAttributedString *mutableAttributedString=[self.fastTextView.attributedString mutableCopy];
    
    NSUInteger st = ((FastIndexedPosition *)(selectedTextRange.start)).index;
    NSUInteger en = ((FastIndexedPosition *)(selectedTextRange.end)).index;
    
    if (en < st) {
        return;
    }
    NSUInteger contentLength = [[self.fastTextView.attributedString string] length];
    if (en > contentLength) {
        en = contentLength; // but let's not crash
    }
    if (st > en)
        st = en;
    NSRange cr = [[self.fastTextView.attributedString string] rangeOfComposedCharacterSequencesForRange:(NSRange){ st, en - st }];
    if (cr.location + cr.length > contentLength) {
        cr.length = ( contentLength - cr.location ); // but let's not crash
    }
    
    FileWrapperObject *fileWp = [[FileWrapperObject alloc] init];
    [fileWp setFileName:emotionImgName];
    [fileWp setFilePath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:emotionImgName]];
    EmotionAttachmentCell *cell = [[EmotionAttachmentCell alloc] initWithFileWrapperObject:fileWp] ;
    [mutableAttributedString addAttribute: FastTextAttachmentAttributeName value:cell  range:cr];
    NSRange range = [emotionImgName rangeOfString:@".png"];
    NSString *imageName = [emotionImgName substringWithRange:NSMakeRange(0, emotionImgName.length - range.location)];
#pragma mark - 时间原因暂时这么写吧
    NSLog(@"imageName:%@", imageName);
    if ([imageName hasSuffix:@"."]) {
        
        imageName = [imageName stringByReplacingOccurrencesOfString:@"." withString:@""];
    }
    [mutableAttributedString addAttribute:@"imageName" value:imageName range:cr];
    
    if (mutableAttributedString) {
        self.fastTextView.attributedString = mutableAttributedString;
    }
}


#pragma mark  -添加位置
-(void)addLocation{
    NSLog(@"~~~~~添加位置按钮跳转");
    
//    RegisterMapViewController * mapVC = [[RegisterMapViewController alloc]init];
//    mapVC.passDelegate = self;
//    [self.navigationController pushViewController:mapVC animated:YES];
    NSString *className = @"UserLocationViewController";
    BaseMapViewController *userLocationVC = [[NSClassFromString(className) alloc]init];
    userLocationVC.mapView = self.mapView;
    userLocationVC.search  = self.search;
    [self.navigationController pushViewController:(UIViewController *)userLocationVC animated:YES];
    
}

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestAlwaysAuthorization];
    }
}

/* 初始化search. */
- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
}

#pragma mark - 地图回调代理方法

-(void)sendLon:(NSString *)lon WithLat:(NSString *)lat WithPlaceName:(NSString *)name
{
    NSLog(@"%@", name);
}

#pragma mark  -选择标签
-(void)selectLabel{
    [self.fastTextView resignFirstResponder];
//    SendTopicVC *selectLabel = [[SendTopicVC alloc]init];
//    selectLabel.title = @"选择标签";
    
    if (self.fastTextView.text.length == 0 || self.fastTextView.text == nil) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入有效内容"];
        return;
        
    }
    [self stringChenge];
//    selectLabel.title = _titleText.text;
//    selectLabel.contentText = _contentTextStr;
//    [self.navigationController pushViewController:selectLabel animated:YES];
    NSString * content = _contentTextStr;
    
    NSLog(@"（self.fastTextView.text）%@", _contentTextStr);
    
    if (content == nil || content.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入有效内容"];
        return;
    }
    
    [self requestPublishMomentWithMomentType:2 momentContent:content imageArr:self.imageIDArr];
    [self.imageIDArr removeAllObjects];
}
/**橱窗发布**/
-(void)requestPublishMomentWithMomentType:(int)momentType momentContent:(NSString *)content imageArr:(NSMutableArray *)imageArr
{
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * loginDict = [d objectForKey:UD_loginDict];
    NSString * ddid = [loginDict objectForKey:@"d_ID"];
    NSString * childID = [loginDict objectForKey:@"currentChildID"];
    //1通知公告 2发布瞬间
    NSString * type = [NSString stringWithFormat:@"%d", momentType];
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:ddid, @"D_ID", content,@"moment.content", type,@"moment.type", ddid,@"moment.author.id", childID , @"moment.childInfo.id",nil];
    
    //组装变长请求
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    int i = 0;
    for (NSString * imageID in imageArr) {
        
        NSString * key = [NSString stringWithFormat:@"moment.diaBodyAttachmentList[%d].attachment.id", i];
        [dict setObject:imageID forKey:key];
        i++;
        
    }
    
    [postDict addEntriesFromDictionary:dict];
    
    __weak PublisWindowVC * weakSelf = self;
    
    [http fiveReuqestUrl:dUrl_DIA_1_1_5 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"发布失败"];
        
         [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark  - 返回上一层
-(void)backClick{
    [[NSNotificationCenter defaultCenter]postNotificationName:dNoti_isHideKeyBoard object:@"1"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  点击文本框外部退出键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_titleText resignFirstResponder];
    [self.fastTextView resignFirstResponder];
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:nil name:UIKeyboardWillChangeFrameNotification object:nil];
}


@end