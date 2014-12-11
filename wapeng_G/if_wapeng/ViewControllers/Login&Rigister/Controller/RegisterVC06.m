//
//  RegisterVC06.m
//  if_wapeng
//
//  Created by 心 猿 on 14-7-29.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
#import "AppDelegate.h"
#import "RegisterVC06.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "UIView+WhenTappedBlocks.h"
#import "ImageManger.h"
#import "UIColor+AddColor.h"
#import "AFN_HttpBase.h"
#import "SVProgressHUD.h"
#import "RegisterDataManager.h"
#import "RegsiterVC009.h"
#import "RegisterVC0009.h"
#import "RegVC09.h"
@interface RegisterVC06 ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    AFN_HttpBase * http;
    RegisterDataManager * _dm;
    NSUserDefaults * userdefaults;
    NSString * uuid;
    NSString *flag;
}

@property (weak, nonatomic) IBOutlet UIImageView *userHead;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *dialog;
@property (strong, nonatomic) NSUserDefaults * ud;


@end

@implementation RegisterVC06

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
        http = [[AFN_HttpBase alloc]  init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.title = @"设置头像";
    
    userdefaults=[NSUserDefaults standardUserDefaults];
    
    _dm = [RegisterDataManager shareInstance];
    
    //获得uuid
    _dm.uuid = [userdefaults objectForKey:UD_uuid];
    
    NSLog(@"宝宝的当前班级是=%@",self.class_Name);
    
    self.register_Id=@"";
    uuid= [userdefaults objectForKey:UD_uuid];
    NSLog(@"uuid=%@",uuid);
    _dm.picID=@"";
    NSLog(@"len==%u",_dm.picID.length);
    self.view.backgroundColor = [UIColor colorWithHexString:@"#d5d6db"];
    UIImage *backImage = [UIImage imageNamed:@"public_back"];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"public_back_hightLight"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(navItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = left;
    
    // [_dm printfSelf];
    [self createUIView];
}
-(void)navItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createUIView
{
    [self.dialog stopAnimating]; // 结束旋转
    [self.dialog setHidesWhenStopped:YES];
    [self.userHead whenTapped:^{
        [self.dialog startAnimating];
        UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"相机", nil];
        [sheet showInView:self.view];
    }];
}

#pragma mark - 开启瓦棚之旅
-(void)httpRequest
{
    //cityid暂时写死
    self.city_Id = @"7";
    
NSMutableArray * keys = [[NSMutableArray alloc]initWithObjects:
@"account.mobileNo",
@"account.lastLoginDeviceCode",
@"account.regInfo.id",
@"account.regInfo.code",
@"account.userInfo.petName",
@"account.userInfo.longitude",
@"account.userInfo.latitude",
@"account.userInfo.photo.id",
@"account.userInfo.childInfoList[0].name",
@"account.userInfo.childInfoList[0].birthday",
@"account.userInfo.childInfoList[0].gender",
@"account.userInfo.childInfoList[0].only",
@"account.userInfo.childInfoList[0].hospital.id",
@"account.userInfo.childInfoList[0].kindergarten.id",
@"account.userInfo.childInfoList[0].zoneArea.id",
@"account.userInfo.childInfoList[0].organizationBranch.id",
@"account.userInfo.childInfoList[0].customerKindergarten.name",
@"account.userInfo.userInfoExtension.located",
@"account.password",
@"account.userInfo.userInfoExtension.gender",
nil];
    
    NSMutableArray * values = [[NSMutableArray alloc]initWithObjects:
                               _dm.phoneNum,
                               _dm.uuid,
                               _dm.regInfoID,
                               _dm.regInfo,
                               _dm.parentNickName,
                               _dm.longtitude,
                               _dm.latitude,
                               _dm.picID,
                               _dm.childNickName,
                               _dm.childBrith,
                               _dm.childGender,
                               _dm.isUnique,
                               _dm.hospitalID,
                               _dm.kindgardenID,
                                self.city_Id,
                                _dm.classID,
                               _dm.customKindergaten,
                               _dm.localPlace,
                               _dm.password,
                               _dm.parentGender,nil];
    
    NSLog(@"keys:%@", keys);
    NSLog(@"values:%@",values);
    
    NSMutableDictionary * postDict = [[NSMutableDictionary alloc]initWithObjects:keys forKeys:values];
    
    NSLog(@"%@", postDict);
    
    
    __weak RegisterVC06 * weakSelf = self;
    [http fiveReuqestUrl:dUrl_ACC_1_1_1 postDict:postDict succeed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        
        RegVC09 * regVC09 = [[RegVC09 alloc]init];
        
        [weakSelf.navigationController pushViewController:regVC09 animated:YES];
        
    } failed:^(NSObject *obj, BOOL isFinished) {
        
        [SVProgressHUD showErrorWithStatus:@"注册失败"];

    }];
}

-(IBAction)startToRock:(id)sender{
  
    [_dm printfSelf];
    [self httpRequest];
}
#pragma mark UIActionSheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    
    switch (buttonIndex) {
        case 0:
        {
            
            NSLog(@"0");
            [SVProgressHUD showSimpleText:@"0"];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:nil];
            break;
        }
        case 1:
        {
            NSLog(@"1");
            [SVProgressHUD showSimpleText:@"1"];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:nil];
            break;
        }
        case 2:
        {
            NSLog(@"取消");
            [SVProgressHUD showSimpleText:@"2"];
            [self.dialog stopAnimating];
            break;
        }
            break;
            
        default:
            break;
    }
    
    
}

-(void) upLoadeImage :(UIImage * ) image{
    //122.115.62.211:8080    115.100.250.35
    NSString *uploadAttachmentURL = @"http://122.115.62.211:8080/wpa/wb/mpub/attachmentAction_addImg.action";
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSLog(@" -计算大小--  %d" , imageData.length);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager * _afHTTPSessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableSet *contentTypes = [NSMutableSet setWithSet:_afHTTPSessionManager.responseSerializer.acceptableContentTypes];
    
    
    [contentTypes addObject:@"text/html"];
    _afHTTPSessionManager.responseSerializer.acceptableContentTypes = contentTypes;
    
    
    [_afHTTPSessionManager POST:uploadAttachmentURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"attachment.uploadFile" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD showSimpleText:@"上传成功"];
        
        [self  saveImage:imageData];
        [self showImage:image];
        [self.dialog  stopAnimating];
        [self.dialog setHidesWhenStopped:YES];
        
        NSLog(@"ress===%@", responseObject);
        NSString * str=[[responseObject objectForKey:@"value"]objectForKey:@"id"];
        //[userdefaults setObject:str forKey:@"picID"];
        _dm.picID=str;
        //        [userD  setObject:imageId forKey:IMAGEID];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showSimpleText:@"上传出错"];
    }];
    
}

#pragma mark--imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGSize size = CGSizeMake(100.0f, 100.0f);
    UIImage * im1 = [ImageManger scaleFromImage:image scaledToSize:size];
    [self upLoadeImage:im1];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) showImage:(UIImage * ) im{
    
    self.userHead.contentMode = UIViewContentModeScaleAspectFit;
    self.userHead.image = im;
    
}
-(NSString * ) saveImage :(NSData *) data{
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *testDirectory = [DocumentsPath stringByAppendingPathComponent:@"userHead"];
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString * namePath = [NSString stringWithFormat:@"%@%@%@%@" , DocumentsPath , @"/userHead",@"/" , @"userIamge.jpg"];
    [fileManager createFileAtPath:namePath  contents:data attributes:nil];
    return namePath;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消选中");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
