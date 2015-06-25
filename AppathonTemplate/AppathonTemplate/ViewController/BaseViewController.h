//
//  BaseViewController.h
//  Photomania
//
//  Created by Muthuraj M on 12/19/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface BaseViewController : UIViewController

@property (nonatomic,strong) GMSMapView *googleMapView;

- (void)navigateToViewController:(UIViewController *)viewController;
- (void)createViews;

@end
