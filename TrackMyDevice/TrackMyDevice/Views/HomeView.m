//
//  HomeView.m
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/23/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "HomeView.h"

@interface HomeView ()<MKMapViewDelegate>

@property (nonatomic,strong) MKMapView *mapView;
@property (nonatomic,strong) UILabel *speedValueLabel,*distanceLabel,*timestamp;

@property (nonatomic,strong) UIButton *startBtn,*stopBtn;
@property (nonatomic,strong) UIView *indiactorView;

@end

@implementation HomeView
@synthesize delegate;

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
    
    self.startBtn = [self createButton:[UIColor greenColor] andText:@"Start"];
    [self.startBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.startBtn];
    
    self.stopBtn = [self createButton:[UIColor redColor] andText:@"Stop"];
    [self.stopBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.stopBtn];
    
    self.mapView = [[MKMapView alloc] init];
    self.mapView.delegate= self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    [self addSubview:self.mapView];
    
    self.indiactorView = [[UIView alloc] init];
    self.indiactorView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.indiactorView];
    
    self.speedValueLabel = [self createLabel:[UIColor lightGrayColor] Alignment:NSTextAlignmentCenter text:@"" font:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.indiactorView addSubview:self.speedValueLabel];
    
    self.distanceLabel = [self createLabel:[UIColor lightGrayColor] Alignment:NSTextAlignmentCenter text:@"" font:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.indiactorView addSubview:self.distanceLabel];
    
    self.timestamp = [self createLabel:[UIColor lightGrayColor] Alignment:NSTextAlignmentCenter text:@"" font:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.indiactorView addSubview:self.timestamp];
}

- (void)btnClicked:(UIButton *)sender
{
    if (sender == self.startBtn)
    {
        [self showStartBtn:NO];
        [self.delegate startClecked];
    }
    else
    {
        [self showStartBtn:YES];
        [self.delegate stopClicked];
    }
}

- (void)showStartBtn:(BOOL)showStartBtn
{
    if (showStartBtn)
    {
        [self.stopBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.startBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.startBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.stopBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    self.startBtn.enabled = showStartBtn;
    self.stopBtn.enabled = !showStartBtn;
}


- (void)updateViewWithData:(NSDictionary *)dataDict
{
    if(dataDict)
    {
        [self setColorToSpeed:[[dataDict objectForKey:@"speed"] floatValue]];
        
        self.speedValueLabel.text = [NSString stringWithFormat:@"Speed : %@ meter/Sec",[dataDict objectForKey:@"speed"]];
        self.distanceLabel.text = [NSString stringWithFormat:@"distance : %@",[dataDict objectForKey:@"distance"]];
        self.timestamp.text = [NSString stringWithFormat:@"Time : %@",[dataDict objectForKey:@"time"]];
    }
   else
   {
       [self showStartBtn:YES];
   }
}

- (void)setColorToSpeed:(float)speed
{
    if (speed < 20 )
    {
        self.speedValueLabel.textColor = [UIColor greenColor];
    }
    else if (speed > 20 && speed < 40)
    {
        self.speedValueLabel.textColor = [UIColor yellowColor];
    }
    else if (speed > 40)
        
    {
        self.speedValueLabel.textColor = [UIColor redColor];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
        float startXPos = 10;
        float startYPos = 10;
        float fullWidth = self.frame.size.width - (startXPos*2);
        float fullHeight = self.frame.size.height - (startYPos*2);
    
       self.startBtn.frame = CGRectMake(startXPos, startYPos, fullWidth/2, 50);
        self.stopBtn.frame = CGRectMake(self.startBtn.frame.size.width + self.startBtn.frame.origin.x + 5, startYPos, fullWidth/2 - 10, 50);
    
        self.mapView.frame = CGRectMake(startXPos, self.startBtn.frame.size.height + self.startBtn.frame.origin.y + 5, fullWidth, fullHeight - (60+fullHeight/4));
    
        self.indiactorView.frame = CGRectMake(startXPos, self.mapView.frame.size.height + self.mapView.frame.origin.y + 5, fullWidth, fullHeight - (self.mapView.frame.size.height + self.mapView.frame.origin.y + 5));
    
    float labelStartXPos = 5;
    float labelStartYPos = 5;
    float labelFullWidth = self.indiactorView.frame.size.width - (labelStartXPos*2);
    float labelFullHeight = self.indiactorView.frame.size.height - (labelStartYPos*2);
    float singleLabelHeight = labelFullHeight/4;
    
    self.speedValueLabel.frame = CGRectMake(labelStartXPos, labelStartYPos, labelFullWidth,singleLabelHeight);
    self.distanceLabel.frame = CGRectMake(labelStartXPos, singleLabelHeight, labelFullWidth,singleLabelHeight);
    self.timestamp.frame = CGRectMake(labelStartXPos, singleLabelHeight*2, labelFullWidth,singleLabelHeight);
}


@end
