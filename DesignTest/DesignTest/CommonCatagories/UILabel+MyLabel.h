//
//  UILabel+MyLabel.h
//  DesignTest
//
//  Created by Muthuraj M on 6/4/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MyLabel)

- (instancetype)initWithText:(NSString *)text alignMent:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor;

@end
