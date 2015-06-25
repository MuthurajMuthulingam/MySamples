//
//  UILabel+MyLabel.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "UILabel+MyLabel.h"

@implementation UILabel (MyLabel)

- (instancetype) initWithText:(NSString *)text andAlignment:(NSTextAlignment)alignment andTextColor:(UIColor *)textColor
{
    self = [super init];
    
    if (self)
    {
        self.text = text;
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = alignment;
        self.textColor = textColor;
        
    }
    return self;
}

@end
