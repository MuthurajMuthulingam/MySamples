//
//  UILabel+MyLabel.m
//  DesignTest
//
//  Created by Muthuraj M on 6/4/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "UILabel+MyLabel.h"

@implementation UILabel (MyLabel)

- (instancetype)initWithText:(NSString *)text alignMent:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor
{
    self = [super init];
    
    self.text = text;
    self.textAlignment = textAlignment;
    self.font = font;
    self.textColor = textColor;
    
    return self;
}

@end
