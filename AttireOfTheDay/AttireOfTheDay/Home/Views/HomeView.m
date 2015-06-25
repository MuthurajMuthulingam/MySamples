//
//  HomeView.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "HomeView.h"

@interface HomeView ()

@property (nonatomic,strong) UIButton *suggestionBtn,*myPreferenceBtn;

@end

@implementation HomeView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

- (void)selectedButton:(UIButton *)butonTitle
{
    [self.homeViewDeleagte homeView:self selectedHomeViewButonTitle:butonTitle.titleLabel.text];
}

- (void)createViews
{
    [super createViews];
    
    self.suggestionBtn = [[UIButton alloc] initWithBackgroundColor:[UIColor greenColor] andTitleText:@"Suggestion" andTextColor:[UIColor blackColor]];
    [self.suggestionBtn addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseContentView addSubview:self.suggestionBtn];
    
    self.myPreferenceBtn = [[UIButton alloc] initWithBackgroundColor:[UIColor redColor] andTitleText:@"My Preferences" andTextColor:[UIColor blackColor]];
    [self.myPreferenceBtn addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseContentView addSubview:self.myPreferenceBtn];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 10;
    float fullWidth = self.baseContentView.frame.size.width  - (startXPos*2);
    
    self.suggestionBtn.frame = CGRectMake(startXPos, startYPos, fullWidth / 2 - 10, 100);
    self.myPreferenceBtn.frame = CGRectMake(self.suggestionBtn.frame.size.width + self.suggestionBtn.frame.origin.x + 10, startYPos, fullWidth / 2 - 20, 100);
}


@end
