//
//  FJFastTextView.h
//  FJFastTextView
//
//  Created by 符杰 on 14-10-23.
//  Copyright (c) 2014年 Colgar. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FJFastTextView : UIScrollView
{
    CGFloat mWidth;
    
}
/**赋值完content之后要调用 assmbleMessageAtIndex方法**/
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) UIFont * textFont;
@property (nonatomic, strong) UIColor * textColor;

- (id)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font;

//返回自己的高度
-(CGFloat)height;
/**重新设置坐标**/
-(void)reloadFrame;
@end
