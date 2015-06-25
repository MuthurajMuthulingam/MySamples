//
//  UILabel+MyLabel.m
//  ChatAppUI
//
//  Created by Muthuraj M on 6/13/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "UILabel+MyLabel.h"

@implementation UILabel (MyLabel)

- (instancetype)initWithText:(NSString *)text textColor:(UIColor *)textColor textAlginMnet:(NSTextAlignment)textAlignment font:(UIFont *)font {
    self = [super init];
    
    if (self) {
        self.text = text;
        self.textAlignment = textAlignment;
        self.textColor = textColor;
        self.font = font;
    }
    
    return self;
}

@end
