//
//  BaseView.m
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/23/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self createViews];
    }
    return self;
}

- (void)createViews
{
}

- (UILabel *)createLabel:(UIColor *)textColor Alignment:(NSTextAlignment)textAlignment text:(NSString *)text font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.text = text;
    label.font = font;
    label.textAlignment = textAlignment;
    return label;
}

- (UIButton *)createButton:(UIColor *)textColor andText:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateHighlighted];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
