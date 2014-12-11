//
//  UIButton+FlexSpace.m
//  Button_UIEdge
//
//  Created by 心 猿 on 14-10-20.
//  Copyright (c) 2014年 心 猿. All rights reserved.
//

#import "UIButton+FlexSpace.h"

@implementation UIButton (FlexSpace)

- (void)setLayout:(OTSUIButtonLayoutStyle )aLayoutStyle
		  spacing:(CGFloat)aSpacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + aSpacing);
	UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
	UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
	if (aLayoutStyle == OTSImageLeftTitleRightStyle) {
		imageEdgeInsets = UIEdgeInsetsMake(0, -(aSpacing / 2.0f), 0, 0 );
		titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - (aSpacing / 2.0f));
	}
	else if (aLayoutStyle == OTSTitleLeftImageRightStyle) {
		imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -(titleSize.width * 2 + aSpacing / 2.0f));
		titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width * 2 + aSpacing / 2.0f), 0, 0);
	}else if (aLayoutStyle == OTSImageTopTitleBootomStyle){
		imageEdgeInsets = UIEdgeInsetsMake( -(totalHeight - imageSize.height),
										   0.0,
										   0.0,
										   - titleSize.width);
		titleEdgeInsets  = UIEdgeInsetsMake(0.0,
											-imageSize.width,
											- (totalHeight - titleSize.height),
											0.0);
	}else if (aLayoutStyle == OTSTitleTopImageBootomStyle){
		imageEdgeInsets = UIEdgeInsetsMake(0.0,
										   0.0,
										   -(totalHeight - imageSize.height),
										   - titleSize.width);
        
		titleEdgeInsets = UIEdgeInsetsMake(-(totalHeight - titleSize.height),
										   0.0,
										   -imageSize.width,
										   0.0);
	}
	self.imageEdgeInsets = imageEdgeInsets;
	self.titleEdgeInsets = titleEdgeInsets;
}
@end
