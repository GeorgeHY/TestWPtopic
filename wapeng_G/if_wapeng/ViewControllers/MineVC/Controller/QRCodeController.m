//
//  QRCodeController.m
//  if_wapeng
//
//  Created by 符杰 on 14-10-14.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "QRCodeController.h"
#import "AppDelegate.h"
#import "QRCodeGenerator.h"

@interface QRCodeController ()
{
    NSDictionary    *_userInfo;
    UIImageView     *_QRCode;
}
@end

@implementation QRCodeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"二维码名片";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *backImage = [UIImage imageNamed:@"public_back"];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    [back setImage:backImage forState:UIControlStateNormal];
    [back setImage:[UIImage imageNamed:@"public_back_hightLight"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = left;
    
    [self buileUI];
}

-(void)buileUI{
    if (_userInfo == nil) {
        _userInfo = [NSDictionary dictionary];
        _userInfo = [AppDelegate shareInstace].loginDict;
    }
    UIImage *icon = [UIImage imageNamed:@"zjgw_logo"];
    UIImageView *iconView = [[UIImageView alloc]initWithImage:icon];
    iconView.frame = CGRectMake(40, 40, 70, 70);
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = 4;
    [self.view addSubview:iconView];
    iconView.image = self.icon;
    iconView.userInteractionEnabled = YES;
    
    NSString *nickName = _userInfo[@"petName"];
    CGSize size = [nickName boundingRectWithSize:CGSizeMake(MAXFLOAT, 17) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil].size;
    UILabel *nick = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame) + 10, iconView.frame.origin.y + 16, size.width, size.height)];
    nick.font = [UIFont systemFontOfSize:17];
    nick.text = nickName;
    [self.view addSubview:nick];
    
    BOOL sex = [_userInfo[@"generalTypeID"] boolValue];
    UIImage *sexImage = sex ? [UIImage imageNamed:@"man"]: [UIImage imageNamed:@"women"];
    UIImageView *sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nick.frame) + 10, nick.frame.origin.y, sexImage.size.width, sexImage.size.height)];
    sexImg.image = sexImage;
    [self.view addSubview:sexImg];
    
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(nick.frame.origin.x, CGRectGetMaxY(sexImg.frame) + 10, 210, 15)];
    address.font = [UIFont systemFontOfSize:14];
    address.text = @"天津 南开";
    address.textColor = [UIColor grayColor];
    [self.view addSubview:address];
    
    UIImageView *QRCode = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 180, 180)];
    QRCode.center = CGPointMake(kMainScreenWidth * 0.5, CGRectGetMaxY(iconView.frame) + QRCode.frame.size.height * 0.5 + 20);
    QRCode.image = [UIImage imageNamed:@"QR_code"];
    QRCode.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:QRCode];
    _QRCode = QRCode;
    
    UILabel *alert = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(QRCode.frame) + 10, kMainScreenWidth, 17)];
    alert.text = @"扫一扫，添加好友";
    alert.textAlignment = NSTextAlignmentCenter;
    alert.font = [UIFont systemFontOfSize:12];
    alert.textColor = [UIColor grayColor];
    [self.view addSubview:alert];
    
    QRCode.image = [QRCodeGenerator qrImageForString:_userInfo[@"wpCode"] imageSize:QRCode.frame.size.width];
}

-(void)backClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
