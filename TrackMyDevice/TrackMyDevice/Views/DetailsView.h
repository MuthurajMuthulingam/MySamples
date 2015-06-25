//
//  DetailsView.h
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/23/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseView.h"
#import <MapKit/MapKit.h>

@interface DetailsView : BaseView

- (void)updateViewWithData:(NSDictionary *)dataDict;
- (void)updateMapWithRegion:(MKCoordinateRegion)region andOverlay:(NSArray *)colorOverlay;
@end
