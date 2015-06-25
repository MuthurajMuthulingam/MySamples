//
//  BaseView.m
//  Photomania
//
//  Created by Muthuraj M on 12/19/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "BaseView.h"
#import "MBProgressHUD.h"

@interface BaseView()

@property (nonatomic,strong) MBProgressHUD *loadingView;

@end

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

#pragma SetupLoading View

- (void)setupLoadingView:(UIView *)view
{
    if (self.loadingView)
    {
        self.loadingView = nil;
    }
    
    self.loadingView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.loadingView.mode = MBProgressHUDModeIndeterminate;
}

- (void)showLoadingMessage:(NSString *)message addedToView:(UIView *)view
{
    [self setupLoadingView:view];
    
    self.loadingView.labelText = message;
    [self.loadingView show:YES];
}

- (void)hideLoadingMessageForView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}


- (instancetype)initWithViewController:(BaseViewController *)viewController
{
    self = [super init];
    
    if (self)
    {
        self.viewController = viewController;
    }
    
    return self;
}

@end
