//
//  RDRStickyKeyboardView.h
//
//  Created by Damiaan Twelker on 17/01/14.
//  Copyright (c) 2014 Damiaan Twelker. All rights reserved.
//
//  LICENSE
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Damiaan Twelker
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "RDRTextView.h"

#pragma mark - RDRKeyboardInputView

@interface RDRKeyboardInputView : UIView

@property (nonatomic, strong, readonly) UIButton *leftButton;
@property (nonatomic, strong, readonly) UIButton *rightButton;
@property (nonatomic, strong, readonly) RDRTextView *textView;

@end

#pragma mark - UIScrollView+RDRStickyKeyboardView

@interface UIScrollView (RDRStickyKeyboardView)

- (BOOL)rdr_isAtBottom;
- (void)rdr_scrollToBottomAnimated:(BOOL)animated
               withCompletionBlock:(void(^)(void))completionBlock;

- (void)rdr_scrollToBottomWithOptions:(UIViewAnimationOptions)options
                             duration:(CGFloat)duration
                      completionBlock:(void(^)(void))completionBlock;

@end

#pragma mark - RDRStickyKeyboardView

@interface RDRStickyKeyboardView : UIView

@property (nonatomic, strong, readonly) UIScrollView *scrollView;

// The inputView that is always visible, right below the content.
// Everything you visually customize on this property will
// also appear on the `inputView` property, as long as
// you do not access `inputView` before customizing this
// property (`inputView` is a lazily loaded copy of
// `inputViewScrollView`).
@property (nonatomic, strong, readonly) RDRKeyboardInputView *inputViewScrollView;

// The inputView that is stuck to the keyboard and is only visible when
// the keyboard is visible. This inputView is internally called
// inputViewKeyboard. For backwards compatibility purposes it
// is exposed as `inputView`.
@property (nonatomic, strong, readonly) RDRKeyboardInputView *inputView;

// Sets an optional placeholder message
@property (nonatomic, assign) NSString *placeholder;
// Sets the placeholder's message color
@property (nonatomic, assign) UIColor *placeholderColor;

// Designated initializer
- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

- (void)showKeyboard;
- (void)hideKeyboard;

@end
