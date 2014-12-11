//
//  FaceView.h
//  FaceViewDemo
//
//  Created by 心 猿 on 14-10-3.
//  Copyright (c) 2014年 心 猿. All rights reserved.
//
typedef void (^SelectedFaceBlock) (NSString * faceName);
#import <UIKit/UIKit.h>

@interface FaceView : UIView
{
    NSMutableArray * _items;
    UIImageView * _magnifierView;//放大镜
}
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, copy) NSString * selectedFaceName;
@property (nonatomic, assign) NSInteger pageNumber;//
@property (nonatomic, copy) SelectedFaceBlock block;
@end
