//
//  ViewController.m
//  TKPlaceholderTextView
//
//  Created by hanxiuhui on 2019/8/5.
//  Copyright © 2019 TK. All rights reserved.
//

#import "ViewController.h"
#import "TKPlaceholderTextView.h"

@interface ViewController ()
@property (nonatomic, strong) TKPlaceholderTextView *feedback1;
@property (nonatomic, strong) TKPlaceholderTextView *feedback2;
@end

@implementation ViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈";
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.feedback1];
    [self.view addSubview:self.feedback2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    NSLog(@"%@ > 销毁了..", NSStringFromClass(self.class));
}

#pragma mark - getter

- (TKPlaceholderTextView *)feedback1 {
    if (!_feedback1) {
        _feedback1 =
        [[TKPlaceholderTextView alloc] initWithFrame:CGRectMake(15.f, 80, CGRectGetWidth(self.view.frame) - 30, 100)];
        _feedback1.layer.borderWidth = 1;
        _feedback1.layer.borderColor = UIColor.blackColor.CGColor;
        _feedback1.font = [UIFont systemFontOfSize:14.f];
        _feedback1.textColor = UIColor.redColor;
        _feedback1.textContainerInset = UIEdgeInsetsMake(7, 15, 7, 15);
        _feedback1.scrollEnabled = NO;
        _feedback1.enablesReturnKeyAutomatically = YES;
        _feedback1.returnKeyType = UIReturnKeyDone;
        
        _feedback1.placeholderColor = UIColor.darkGrayColor;
        _feedback1.placeholderText = @"用户反馈...用户反馈...用户反馈...用户反馈...用户反馈...用户反馈...用户反馈...";
        _feedback1.textChangeBlock = ^(NSString *text) {
            NSLog(@"_feedback1 = %@", text);
        };
    }
    return _feedback1;
}

- (TKPlaceholderTextView *)feedback2 {
    if (!_feedback2) {
        _feedback2 =
        [[TKPlaceholderTextView alloc] initWithFrame:CGRectMake(15.f, CGRectGetMaxY(self.feedback1.frame) + 15.f, CGRectGetWidth(self.view.frame) - 30, 100)];
        _feedback2.layer.borderWidth = 1;
        _feedback2.layer.borderColor = UIColor.blackColor.CGColor;
        _feedback2.font = [UIFont systemFontOfSize:14.f];
        _feedback2.textColor = UIColor.redColor;
        _feedback2.textContainerInset = UIEdgeInsetsMake(7, 15, 7, 15);
        _feedback2.scrollEnabled = NO;
        _feedback2.enablesReturnKeyAutomatically = YES;
        _feedback2.returnKeyType = UIReturnKeyDone;
        
        _feedback2.placeholderColor = UIColor.darkGrayColor;
        _feedback2.placeholderText = @"用户反馈...用户反馈...用户反馈...用户反馈...用户反馈...用户反馈...用户反馈...";
        _feedback2.placeholderImage = [UIImage imageNamed:@"icon_feedback"];
        _feedback2.textChangeBlock = ^(NSString *text) {
            NSLog(@"_feedback2 = %@", text);
        };
    }
    return _feedback2;
}
@end
