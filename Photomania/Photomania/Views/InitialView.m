//
//  InitialView.m
//  Photomania
//
//  Created by Muthuraj M on 12/19/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "InitialView.h"
#import "ImageListTableViewController.h"

@interface InitialView()

@property (nonatomic,strong) UIButton *gotoImageView;

@end

@implementation InitialView

- (id)initWithViewController:(BaseViewController *)viewController
{
    self = [super initWithViewController:viewController];
    if (self)
    {
        [self createViews];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)createViews
{
    [super createViews];
    
    self.gotoImageView = [[UIButton alloc] init];
    [self.gotoImageView setTitle:@"GotoImageView" forState:UIControlStateNormal];
    [self.gotoImageView setTitle:@"GotoImageView" forState:UIControlStateSelected];
    [self.gotoImageView setTitle:@"GotoImageView" forState:UIControlStateHighlighted];
    [self.gotoImageView setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.gotoImageView addTarget:self action:@selector(gotoImageViewController) forControlEvents:UIControlEventTouchUpInside];
    self.gotoImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.gotoImageView];
}

- (void)gotoImageViewController
{
    ImageListTableViewController *vc = [[ImageListTableViewController alloc] init];
    
    [self.viewController navigateToViewController:vc];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float fullWidth = self.frame.size.width;
    float fullHeight = self.frame.size.height;
    
    self.gotoImageView.frame = CGRectMake(fullWidth/4, fullHeight/2 - 20, fullWidth/2, 50);
    
}

@end
