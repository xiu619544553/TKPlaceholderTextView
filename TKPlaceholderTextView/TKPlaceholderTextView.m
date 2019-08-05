//
//  TKPlaceholderTextView.m
//  TKPlaceholderTextView
//
//  Created by hanxiuhui on 2019/8/5.
//  Copyright © 2019 TK. All rights reserved.
//

#import "TKPlaceholderTextView.h"

@interface TKPlaceholderTextView ()
@property (nonatomic, strong) UIImageView *placeholderImageView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, assign) UIEdgeInsets pTextContainerInset;
@end

@implementation TKPlaceholderTextView

#pragma mark - Init Method

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _placeholderColor = [UIColor lightGrayColor];
    self.font = [UIFont systemFontOfSize:15.f];
    
    [self _layout];
    
    // 监听文本变化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChanged:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@ > 销毁了..", NSStringFromClass(self.class));
}

#pragma mark - Notification Method

- (void)textDidChanged:(NSNotification *)notification {
    if (notification.object == self) {
        [self _layout];
        self.textChangeBlock ? self.textChangeBlock(self.text) : nil;
    }
}

#pragma mark - setter

- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self _layout];
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    _placeholderText = placeholderText;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)color {
    _placeholderColor = color;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    _placeholderImage = placeholderImage;
    
    [self setNeedsDisplay];
}

- (void)setImageTextMargin:(CGFloat)imageTextMargin {
    _imageTextMargin = imageTextMargin;
    
    [self setNeedsDisplay];
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    [super setTextContainerInset:textContainerInset];
    
    _pTextContainerInset = textContainerInset;
    [self setNeedsDisplay];
}

#pragma mark - getter

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _placeholderLabel.font = self.font;
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.alpha = 0;
    }
    return _placeholderLabel;
}

- (UIImageView *)placeholderImageView {
    if (!_placeholderImageView) {
        _placeholderImageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(0, _pTextContainerInset.top, 0, 0)];
    }
    return _placeholderImageView;
}

#pragma mark - Private

- (void)_layout {
    _placeholderImageView.alpha = [self.text length] > 0 ? 0 : 1;
    _placeholderLabel.alpha = [self.text length] > 0 || [_placeholderText length] == 0 ? 0 : 1;
}

- (void)drawRect:(CGRect)rect {
    // 添加占位文字
    if (_placeholderText && _placeholderText.length > 0) {
        [self addSubview:self.placeholderLabel];
        _placeholderLabel.text = _placeholderText;
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.textColor = _placeholderColor;
        _placeholderLabel.textColor = self.placeholderColor;
        [self sendSubviewToBack:self.placeholderLabel];
        
        // 添加占位图片
        if (_placeholderImage) {
            [self addSubview:self.placeholderImageView];
            [self sendSubviewToBack:self.placeholderImageView];
            
            _placeholderImageView.frame =
            CGRectMake(_pTextContainerInset.left,
                       _pTextContainerInset.top,
                       _placeholderImage.size.width,
                       _placeholderImage.size.height);
            _placeholderImageView.image = _placeholderImage;
            [_placeholderImageView sizeToFit];
            
            // 修正placeholderLabel位置
            CGFloat placeholderLabelX = CGRectGetMaxX(_placeholderImageView.frame) + 2;
            CGFloat placeholderLabelY = _pTextContainerInset.top + 1;
            CGFloat placeholderLabelWidth = CGRectGetWidth(self.frame) - placeholderLabelX - _pTextContainerInset.right;
            CGFloat placeholderLabelHeight =
            [_placeholderText boundingRectWithSize:CGSizeMake(placeholderLabelWidth, CGFLOAT_MAX)
                                           options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : self.font} context:nil].size.height;
            _placeholderLabel.frame =
            CGRectMake(placeholderLabelX,
                       placeholderLabelY,
                       placeholderLabelWidth,
                       placeholderLabelHeight);
        } else {
            CGFloat placeholderLabelX = _pTextContainerInset.left + 5;
            CGFloat placeholderLabelY = _pTextContainerInset.top + 1;
            CGFloat placeholderLabelWidth = CGRectGetWidth(self.frame) - placeholderLabelX - _pTextContainerInset.right;
            CGFloat placeholderLabelHeight =
            [_placeholderText boundingRectWithSize:CGSizeMake(placeholderLabelWidth, CGFLOAT_MAX)
                                           options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : self.font} context:nil].size.height;
            _placeholderLabel.frame =
            CGRectMake(placeholderLabelX,
                       placeholderLabelY,
                       placeholderLabelWidth,
                       placeholderLabelHeight);
        }
    }
    
    [self _layout];
    [super drawRect:rect];
}
@end
