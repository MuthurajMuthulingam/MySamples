//
//  BaseView.h
//  Photomania
//
//  Created by Muthuraj M on 12/19/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseView : UIView

@property (nonatomic,strong) BaseViewController *viewController;

- (instancetype)initWithViewController:(BaseViewController *)viewController;
- (void)createViews;

- (void)showLoadingMessage:(NSString *)message addedToView:(UIView *)view;
- (void)hideLoadingMessageForView:(UIView *)view;

@end
