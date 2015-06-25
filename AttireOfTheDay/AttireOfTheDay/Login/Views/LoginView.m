//
//  LoginView.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "LoginView.h"

@interface LoginView()

@property (nonatomic,strong) UIButton *loginBtn;

@end

@implementation LoginView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

- (void)createViews
{
    [super createViews];
    
    self.loginBtn = [[UIButton alloc] initWithBackgroundColor:[UIColor greenColor] andTitleText:@"Login With FB" andTextColor:[UIColor blackColor]];
    [self.loginBtn addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.loginBtn];
    
}

- (void)loginClicked:(UIButton *)sender
{
    [self.loginViewDelegate loginView:self loginButonCliked:sender];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 0;
    float startYPos = 0;
    float fullWidth = self.frame.size.width  - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos*2);
    
    self.loginBtn.frame = CGRectMake(fullWidth / 4, fullHeight / 4, fullWidth / 2, 50);
}

@end
