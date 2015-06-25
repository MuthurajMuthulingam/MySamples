//
//  BaseView.h
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/23/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

-(void)createViews;

- (UILabel *)createLabel:(UIColor *)textColor Alignment:(NSTextAlignment)textAlignment text:(NSString *)text font:(UIFont *)font;
- (UIButton *)createButton:(UIColor *)textColor andText:(NSString *)title;

@end
