//
//  HomeView.m
//  DesignTest
//
//  Created by Muthuraj M on 6/3/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "HomeView.h"
#import "UILabel+MyLabel.h"
#import "RangeSlider.h"
#import "UIButton+MyButton.h"

#define helVeticaFont [UIFont fontWithName:@"Helvetica" size:12]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface HomeView ()

@property (nonatomic,strong) UISegmentedControl *genderSegment,*locationSegment;
@property (nonatomic,strong) UISlider *ageSlider;
@property (nonatomic,strong) UISlider *inchSlider;
@property (nonatomic,strong) UILabel *faithLabel,*motherTongueLabel,*maritalStatusLabel,*advancedSearchLabel,*age1Label,*age2Label,*inch1Label,*inch2Label;
@property (nonatomic,strong) UISwitch *faithSwitch,*motherTongueSwitch,*maritalStatusSwitch;
@property (nonatomic,strong) UIButton *searchBtn;

@end

@implementation HomeView

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
    self.genderSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Women",@"Men", nil]];
    self.genderSegment.selectedSegmentIndex = 0;
    [self addSubview:self.genderSegment];
    
    self.locationSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Nearby",@"Anywhere", nil]];
    self.locationSegment.selectedSegmentIndex = 0;
    [self addSubview:self.locationSegment];
    
    self.age1Label = [[UILabel alloc] initWithText:@"21" alignMent:NSTextAlignmentLeft font:helVeticaFont textColor:UIColorFromRGB(0x2D2D2D)];
    [self addSubview:self.age1Label];
    
    self.age2Label = [[UILabel alloc] initWithText:@"55 Years" alignMent:NSTextAlignmentLeft font:helVeticaFont textColor:UIColorFromRGB(0x2D2D2D)];
    [self addSubview:self.age2Label];
    
    self.ageSlider = [[UISlider alloc] init];
    self.ageSlider.continuous = YES;
    self.ageSlider.minimumValue = 20;
    self.ageSlider.maximumValue = 60;
    [self addSubview:self.ageSlider];
    
    self.inch1Label = [[UILabel alloc] initWithText:@"4'5\"" alignMent:NSTextAlignmentLeft font:helVeticaFont textColor:UIColorFromRGB(0x2D2D2D)];
    [self addSubview:self.inch1Label];
    
    self.inch2Label = [[UILabel alloc] initWithText:@"7'5\"" alignMent:NSTextAlignmentLeft font:helVeticaFont textColor:UIColorFromRGB(0x2D2D2D)];
    [self addSubview:self.inch2Label];
    
    self.inchSlider = [[UISlider alloc] init];
    self.inchSlider.continuous = YES;
    self.inchSlider.minimumValue = 20;
    self.inchSlider.maximumValue = 60;
    [self addSubview:self.inchSlider];
    
    self.faithLabel = [[UILabel alloc] initWithText:@"Same faith" alignMent:NSTextAlignmentLeft font:helVeticaFont textColor:UIColorFromRGB(0x2D2D2D)];
    [self addSubview:self.faithLabel];
    
    self.faithSwitch = [[UISwitch alloc] init];
    self.faithSwitch.on = YES;
    self.faithSwitch.onTintColor = UIColorFromRGB(0x2975E0);
    [self addSubview:self.faithSwitch];
    
    self.motherTongueLabel = [[UILabel alloc] initWithText:@"Same mother tongue" alignMent:NSTextAlignmentLeft font:helVeticaFont textColor:UIColorFromRGB(0x2D2D2D)];
    [self addSubview:self.motherTongueLabel];
    
    self.motherTongueSwitch = [[UISwitch alloc] init];
    self.motherTongueSwitch.onTintColor = UIColorFromRGB(0x2975E0);
    [self addSubview:self.motherTongueSwitch];
    
    self.maritalStatusLabel = [[UILabel alloc] initWithText:@"Same marital status" alignMent:NSTextAlignmentLeft font:helVeticaFont textColor:UIColorFromRGB(0x2D2D2D)];
    [self addSubview:self.maritalStatusLabel];
    
    self.maritalStatusSwitch = [[UISwitch alloc] init];
    self.maritalStatusSwitch.on = YES;
    self.maritalStatusSwitch.onTintColor = UIColorFromRGB(0x2975E0);
    [self addSubview:self.maritalStatusSwitch];
    
    self.searchBtn = [[UIButton alloc] initWithTitleText:@"Search" titleColor:UIColorFromRGB(0x2975E0) backgroundColor:[UIColor whiteColor]];
    self.searchBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    self.searchBtn.layer.cornerRadius = 3;
    self.searchBtn.layer.borderWidth = 1.2;
    self.searchBtn.layer.borderColor = UIColorFromRGB(0x2975E0).CGColor;
    [self addSubview:self.searchBtn];
    
    self.advancedSearchLabel = [[UILabel alloc] initWithText:@"Advanced search" alignMent:NSTextAlignmentCenter font:helVeticaFont textColor:UIColorFromRGB(0xA8A8AB)];
    [self addSubview:self.advancedSearchLabel];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 20;
    float startYPos = 90;
    float fullWidth = self.frame.size.width - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos);
    
    float individualItemHeight = fullHeight / 7 - 40;
    
    self.genderSegment.frame = CGRectMake(startXPos, startYPos, fullWidth, individualItemHeight - 10);
    self.locationSegment.frame = CGRectMake(startXPos, individualItemHeight + 110, fullWidth, individualItemHeight - 10);
    
    self.age1Label.frame = CGRectMake(startXPos,  (individualItemHeight*2) + 120, fullWidth * 0.1, individualItemHeight);
    self.ageSlider.frame = CGRectMake(self.age1Label.frame.origin.x + self.age1Label.frame.size.width,  (individualItemHeight*2) + 120, fullWidth * 0.6, individualItemHeight);
    self.age2Label.frame = CGRectMake(self.ageSlider.frame.origin.x + self.ageSlider.frame.size.width + 5,  (individualItemHeight*2) + 120, fullWidth * 0.3 - 5, individualItemHeight);
    
    self.inch1Label.frame = CGRectMake(startXPos,self.ageSlider.frame.size.height + self.ageSlider.frame.origin.y + 10, fullWidth * 0.1, individualItemHeight);
    self.inchSlider.frame = CGRectMake(self.inch1Label.frame.origin.x + self.inch1Label.frame.size.width, self.inch1Label.frame.origin.y, fullWidth * 0.6, individualItemHeight);
    self.inch2Label.frame = CGRectMake(self.inchSlider.frame.origin.x + self.inchSlider.frame.size.width + 5,  self.inch1Label.frame.origin.y, fullWidth * 0.3 - 5, individualItemHeight);
    
    self.faithLabel.frame = CGRectMake(startXPos, self.inchSlider.frame.size.height + self.inchSlider.frame.origin.y + 20, fullWidth*0.8, individualItemHeight);
    self.faithSwitch.frame = CGRectMake(self.faithLabel.frame.origin.x + self.faithLabel.frame.size.width, self.inchSlider.frame.size.height + self.inchSlider.frame.origin.y + 20, fullWidth - (self.faithLabel.frame.origin.x + self.faithLabel.frame.size.width), individualItemHeight);
    
    self.motherTongueLabel.frame = CGRectMake(startXPos, self.faithLabel.frame.size.height + self.faithLabel.frame.origin.y + 20, fullWidth*0.8, individualItemHeight);
    self.motherTongueSwitch.frame = CGRectMake(self.motherTongueLabel.frame.origin.x + self.motherTongueLabel.frame.size.width, self.faithLabel.frame.size.height + self.faithLabel.frame.origin.y + 20, fullWidth - (self.motherTongueLabel.frame.origin.x + self.motherTongueLabel.frame.size.width), individualItemHeight);
    
    self.maritalStatusLabel.frame = CGRectMake(startXPos, self.motherTongueLabel.frame.size.height + self.motherTongueLabel.frame.origin.y + 20, fullWidth*0.8, individualItemHeight);
    self.maritalStatusSwitch.frame = CGRectMake(self.maritalStatusLabel.frame.origin.x + self.maritalStatusLabel.frame.size.width, self.motherTongueLabel.frame.size.height + self.motherTongueLabel.frame.origin.y + 20, fullWidth - (self.motherTongueLabel.frame.origin.x + self.motherTongueLabel.frame.size.width), individualItemHeight);
    
    self.searchBtn.frame = CGRectMake(startXPos, self.maritalStatusLabel.frame.size.height + self.maritalStatusLabel.frame.origin.y + 20, fullWidth, 50);
    self.advancedSearchLabel.frame = CGRectMake(startXPos, self.searchBtn.frame.size.height + self.searchBtn.frame.origin.y , fullWidth, 50);
    
}

@end
