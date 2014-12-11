//
//  SelectLabelViewController.m
//  if_wapeng
//
//  Created by 符杰 on 14-9-24.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import "SelectLabelViewController.h"
#import "RegisterText.h"
#import "UIImage+Stretch.h"

#define kLabelH  30

@interface SelectLabelViewController ()<UITextFieldDelegate>
{
    UIScrollView *_bgView;
    NSArray         *_labelArr1;
    NSArray         *_labelArr2;
    NSArray         *_hotLabelArr;
    NSMutableArray  *_allLabelArr;
    UIButton        *_lastBtn;
    RegisterText    *_customLabelText;
    UIImageView     *_img;
}
@end

@implementation SelectLabelViewController

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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kRGB(235, 235, 235);
    
    _bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight- 43 - 50)];
//    [self.view addSubview:_bgView];
    _bgView.showsVerticalScrollIndicator = NO;
    
    _labelArr1 = [NSArray array];
    _labelArr2 = [NSArray array];
    _hotLabelArr = [NSArray array];
    _allLabelArr = [NSMutableArray array];
    
    _labelArr1 = @[@"宝宝",@"妈妈",@"家庭",@"周边"];
    _labelArr2 = @[@"护理",@"健康",@"教育",@"吃喝玩",@"购物",@"乱七糟八"];
    _hotLabelArr = @[@"护理",@"乱七糟八",@"健康",@"教育",@"吃喝玩",@"购物"];
    
    [self buildUI];
    
}

-(void)buildUI{
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 14, 25)];
    [leftBtn setImage:[UIImage imageNamed:@"public_back.png"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"public_back_hightLight.png"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:65/255.0 green:138/255.0 blue:247/255.0 alpha:1] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(sendAciticity) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    [self buildTitleLabel:15 title:@"常用标签"];
    NSInteger num = (_labelArr1.count > _labelArr2.count ? _labelArr1.count : _labelArr2.count);
    CGFloat height = num < 6 ? num * kLabelH : 6 * kLabelH;
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kMainScreenWidth * 0.5, 34, 1, height)];
    img.backgroundColor = kRGB(207, 207, 207);
    [self.view addSubview:img];
    
    for (int i = 0; i < _labelArr1.count; i ++) {
        [self addCommonLabel:_labelArr1[i] y:34 row:0 rol:i];
    }
    
    for (int i = 0; i < _labelArr2.count;  i++) {
        [self addCommonLabel:_labelArr2[i] y:34 row:1 rol:i];
    }
    
    CGFloat y = CGRectGetMaxY(img.frame) + 15;
    [self buildTitleLabel:y title:@"最近热门标签"];
    for (int i = 0; i < _hotLabelArr.count; i ++) {
        [self addHotLabel:_hotLabelArr[i] laseBtn:_lastBtn y:y + 23 index:i];
    }
    
    [self buildTitleLabel:CGRectGetMaxY(_lastBtn.frame) + 15 title:@"自定义标签"];
    _customLabelText = [[RegisterText alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_lastBtn.frame) + 33, kMainScreenWidth - 30, 25)];
    _customLabelText.delegate = self;
    [self.view addSubview:_customLabelText];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 33, 25)];
    _customLabelText.leftView = view;
    _customLabelText.leftViewMode = UITextFieldViewModeAlways;
    UIImage *image = [UIImage imageNamed:@"register1_check0.png"];
    _img = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, 20, 20)];
    _img.image = image;
    [view addSubview:_img];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_img.frame) + 2, _img.frame.origin.y +3, 1, 14)];
    line.backgroundColor = kRGB(207, 207, 207);
    [view addSubview:line];
    _customLabelText.placeholder = @"请输入";
    _customLabelText.returnKeyType = UIReturnKeySend;
    [_customLabelText addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_customLabelText.frame) + 15, kMainScreenWidth - 30, 30)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImage resizedImage:@"button-normal.png"] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImage resizedImage:@"button-putdown.png"] forState:UIControlStateHighlighted];
    [sendBtn addTarget:self action:@selector(sendAciticity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
    UIImageView *imgLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sendBtn.frame) + 15, kMainScreenWidth, 1)];
    imgLine.backgroundColor = kRGB(207, 207, 207);
    [self.view addSubview:imgLine];
    
    CGFloat hintY;
    if (kMainScreenHeight < 480) {
        hintY = CGRectGetMaxY(_customLabelText.frame) + 5;
        sendBtn.hidden = YES;
        imgLine.hidden = YES;
    }else{
        hintY = CGRectGetMaxY(imgLine.frame) + 15;
    }
    NSString *string = @"合理的设置标签可以让你的帖子更快的被发现和回应";
    CGSize hintSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 17) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    UILabel *hint = [[UILabel alloc]initWithFrame:CGRectMake(0, hintY, hintSize.width, 17)];
    hint.text = string;
    hint.font = [UIFont systemFontOfSize:13];
    CGPoint hintCenter = hint.center;
    hintCenter.x = kMainScreenWidth * 0.5;
    hint.center = hintCenter;
    hint.textColor = kRGB(174, 143, 112);
    [self.view addSubview:hint];
}

#pragma mark  -返回上一界面
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  -添加一个常用标签
-(void)addCommonLabel:(NSString *)title y:(CGFloat)y row:(int)row rol:(int)rol{
    CGFloat x;
    int tag  = 0;
    if (row) {
        tag = 10;
        x = kMainScreenWidth * 0.5 + 50;
    }else{
        x = kMainScreenWidth * 0.5 - 110;
    }
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y + kLabelH * rol, 100, kLabelH)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"register1_check0.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"register1_check1.png"] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.tag = tag + rol;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(selectLabelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)addHotLabel:(NSString *)title laseBtn:(UIButton *)lastBtn y:(CGFloat)y index:(CGFloat)index{
    CGFloat x =0;
    if (lastBtn) {
        x = CGRectGetMaxX(lastBtn.frame) + 5;
    }else{
        x = 0;
    }
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x + 5, y, 100, kLabelH)];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.tag = index + 30;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:@"register1_check0.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"register1_check1.png"] forState:UIControlStateSelected];
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, kLabelH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size;
    CGFloat errand = size.width - (100 - 28);
    CGRect frame = btn.frame;
    frame.size.width += errand;
    btn.frame = frame;
    [btn addTarget:self action:@selector(selectLabelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    if (CGRectGetMaxX(btn.frame) > kMainScreenWidth) {
        btn.hidden = YES;
    }
    _lastBtn = btn;
}

#pragma mark  - 标签选择
-(void)selectLabelClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    NSString *str = [sender titleForState:UIControlStateNormal];
    if (sender.selected) {
        [_allLabelArr addObject:str];
    }else{
        [_allLabelArr removeObject:str];
    }
    NSLog(@"allLabelArr%@",_allLabelArr);
}

#pragma mark  -发送活动
-(void)sendAciticity{
    
    NSLog(@"发送活动");
    
//    [self httpRequest];
}


- (void)buildTitleLabel:(CGFloat)y title:(NSString *)title{
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15, y, 2, 14)];
    img.backgroundColor = kRGB(142, 10, 32);
    [self.view addSubview:img];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(img.frame) + 5, y -2, 200, 18)];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.text = title;
    [self.view addSubview:titleLab];
}

-(void)endEdit{
    [self sendAciticity];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSString *comment = textField.text;
    if (comment.length) {
        _img.image = [UIImage imageNamed:@"register1_check0.png"];
    }else{
        _img.image = [UIImage imageNamed:@"register1_check1.png"];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *comment = textField.text;
    if (comment.length) {
        _img.image = [UIImage imageNamed:@"register1_check1.png"];
    }else{
        _img.image = [UIImage imageNamed:@"register1_check0.png"];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *comment = textField.text;
    if (comment.length) {
        _img.image = [UIImage imageNamed:@"register1_check1.png"];
    }else{
        _img.image = [UIImage imageNamed:@"register1_check0.png"];
    }
    NSLog(@"%@",textField.text);
    return YES;
}

#pragma mark  点击文本框外部退出键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_customLabelText resignFirstResponder];
}
@end
