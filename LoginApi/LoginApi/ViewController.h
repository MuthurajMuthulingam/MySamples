//
//  ViewController.h
//  LoginApi
//
//  Created by Muthuraj M on 12/29/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthLoginView.h"
#import "JSONKit.h"
#import "OAConsumer.h"
#import "OAMutableURLRequest.h"
#import "OADataFetcher.h"
#import "OATokenManager.h"


@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *buttonLogin;
@property (nonatomic, strong) IBOutlet UIButton *buttonPost;
@property (nonatomic, strong) IBOutlet UIButton *buttonLogout;

@property (nonatomic, strong) IBOutlet UILabel *userName;
@property (nonatomic, strong) IBOutlet UILabel *headline;
@property (nonatomic, strong) IBOutlet UILabel *status;
@property (nonatomic, strong) IBOutlet UILabel *updateStatusLabel;
@property (nonatomic, strong) IBOutlet UITextField *statusTextView;
@property (strong, nonatomic) IBOutlet UILabel *linkedinProfileLabel;


@property (nonatomic, strong) OAuthLoginView *oAuthLoginView;


- (IBAction)buttonLoginClick:(UIButton *)sender;
- (IBAction)buttonPostStatusClick:(UIButton *)sender;
- (IBAction)buttonLogoutClick:(id)sender;

- (void)profileApiCall;
- (void)networkApiCall;
- See more at: http://www.oodlestechnologies.com/blogs/Linkedin-Integration-in-Native-iOS#sthash.qj4PBm1I.dpuf

@end

