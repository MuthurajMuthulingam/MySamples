//
//  DetailsView.m
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/23/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "DetailsView.h"
#import "MulticolorPolylineSegment.h"

@interface DetailsView ()<MKMapViewDelegate>

@property (nonatomic,strong) MKMapView *mapView;
@property (nonatomic,strong) UILabel *speedLabel,*speedValueLabel,*distanceLabel,*timestamp,*dateLabel;
@property (nonatomic,strong) UIView *indiactorView;

@end

@implementation DetailsView

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
    [super createViews];
    
    self.mapView = [[MKMapView alloc] init];
    self.mapView.delegate= self;
    //self.mapView.showsUserLocation = YES;
    [self addSubview:self.mapView];
    
    self.indiactorView = [[UIView alloc] init];
    self.indiactorView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.indiactorView];
    
    self.speedLabel = [self createLabel:[UIColor lightGrayColor] Alignment:NSTextAlignmentLeft text:@"" font:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.indiactorView addSubview:self.speedLabel];
    
    self.speedValueLabel = [self createLabel:[UIColor lightGrayColor] Alignment:NSTextAlignmentLeft text:@"" font:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.indiactorView addSubview:self.speedValueLabel];
    
    self.distanceLabel = [self createLabel:[UIColor lightGrayColor] Alignment:NSTextAlignmentLeft text:@"" font:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.indiactorView addSubview:self.distanceLabel];
    
    self.timestamp = [self createLabel:[UIColor lightGrayColor] Alignment:NSTextAlignmentLeft text:@"" font:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.indiactorView addSubview:self.timestamp];
    
    self.dateLabel = [self createLabel:[UIColor lightGrayColor] Alignment:NSTextAlignmentLeft text:@"" font:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.indiactorView addSubview:self.dateLabel];

}

- (void)updateViewWithData:(NSDictionary *)dataDict
{
    self.speedValueLabel.text = [NSString stringWithFormat:@"Avg Speed : %@ meter/Sec",[dataDict objectForKey:@"speed"]];
    self.distanceLabel.text = [NSString stringWithFormat:@"distance : %@",[dataDict objectForKey:@"distance"]];
    self.timestamp.text = [NSString stringWithFormat:@"Time : %@",[dataDict objectForKey:@"time"]];
    self.dateLabel.text = [NSString stringWithFormat:@"Date : %@",[dataDict objectForKey:@"date"]];

}

- (void)updateMapWithRegion:(MKCoordinateRegion)region andOverlay:(NSArray *)colorOverlay
{
    [self.mapView setRegion:region];
    [self.mapView addOverlays:colorOverlay];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MulticolorPolylineSegment *polyLine = (MulticolorPolylineSegment *)overlay;
        MKPolylineRenderer *aRenderer = [[MKPolylineRenderer alloc] initWithPolyline:polyLine];
        aRenderer.strokeColor = polyLine.color;
        aRenderer.lineWidth = 3;
        return aRenderer;
    }
    
    return nil;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 10;
    float fullWidth = self.frame.size.width - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos*2);
    
    self.mapView.frame = CGRectMake(startXPos, startYPos, fullWidth, fullHeight*3/4);
    
    self.indiactorView.frame = CGRectMake(startXPos, self.mapView.frame.size.height + self.mapView.frame.origin.y + 5, fullWidth, fullHeight - (self.mapView.frame.size.height + self.mapView.frame.origin.y + 5));
    
    float labelStartXPos = 5;
    float labelStartYPos = 5;
    float labelFullWidth = self.indiactorView.frame.size.width - (labelStartXPos*2);
    float labelFullHeight = self.indiactorView.frame.size.height - (labelStartYPos*2);
    float singleLabelHeight = labelFullHeight/4;
    
    self.speedValueLabel.frame = CGRectMake(labelStartXPos, labelStartYPos, labelFullWidth,singleLabelHeight);
    self.distanceLabel.frame = CGRectMake(labelStartXPos, singleLabelHeight, labelFullWidth,singleLabelHeight);
    self.timestamp.frame = CGRectMake(labelStartXPos, singleLabelHeight*2, labelFullWidth,singleLabelHeight);
    self.dateLabel.frame = CGRectMake(labelStartXPos, singleLabelHeight*3, labelFullWidth,singleLabelHeight);
}

@end
