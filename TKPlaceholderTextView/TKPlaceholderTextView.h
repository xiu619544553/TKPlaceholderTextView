//
//  TKPlaceholderTextView.h
//  TKPlaceholderTextView
//
//  Created by hanxiuhui on 2019/8/5.
//  Copyright © 2019 TK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TextDidChangeBlock)(NSString *text);

/// 带占位符的输入框
@interface TKPlaceholderTextView : UITextView

@property (nullable, copy, nonatomic) NSString *placeholderText;
@property (nullable, strong, nonatomic) UIColor *placeholderColor;

@property (nonatomic, assign) CGFloat imageTextMargin;
@property (nullable, nonatomic, strong) UIImage *placeholderImage;

@property (nullable, nonatomic, copy) TextDidChangeBlock textChangeBlock;

@end

NS_ASSUME_NONNULL_END
