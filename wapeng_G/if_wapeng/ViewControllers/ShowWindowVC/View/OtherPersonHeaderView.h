//
//  OtherPersonHeaderView.h
//  if_wapeng
//
//  Created by 心 猿 on 14-11-18.
//  Copyright (c) 2014年 funeral. All rights reserved.
//
/*别人的橱窗*/
#import <UIKit/UIKit.h>

@interface OtherPersonHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headerIV;
@property (weak, nonatomic) IBOutlet UILabel *nickLbl;
@property (weak, nonatomic) IBOutlet UIButton *gender;
//@property (weak, nonatomic) IBOutlet UILabel *emotionLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;
@property (weak, nonatomic) IBOutlet UILabel *locationLbl;
@property (weak, nonatomic) IBOutlet UILabel *wpCodeLbl;
@property (weak, nonatomic) IBOutlet UILabel *momentCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *focusCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *fansLbl;
@property (weak, nonatomic) IBOutlet UIButton *GoFocusBtn;
@property (weak, nonatomic) IBOutlet UIButton *GoFansBtn;
@property (weak, nonatomic) IBOutlet UIButton *momentBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendPrivateMSgBtn;//发私信
@property (weak, nonatomic) IBOutlet UIButton *alreadyFoucsBtn;//是否已经关注
@property (weak, nonatomic) IBOutlet UILabel *emotionLbl;

+(instancetype)instanceView;
@end
