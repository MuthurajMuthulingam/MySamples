//
//  BaseViewController.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <Social/Social.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Accounts/Accounts.h>

#define AlertTitle @"Attire Of The Day"

@interface BaseViewController : UIViewController

- (void)createViews;
- (void)navigateToViewController:(UIViewController *)viewControllerToNavigate;
- (void)showMessageInAlert:(NSString *)alertTitle andMessage:(NSString *)message;
@end
