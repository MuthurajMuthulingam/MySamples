//
//  LoginViewController.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "LoginView.h"


@interface LoginViewController ()<LoginViewDelegate>
{
    int isFacebookAvailable;
}

@property (nonatomic,strong) LoginView *loginView;
@property (nonatomic,strong) ACAccountStore *accountStore;
@property (nonatomic,strong) ACAccount *facebookAccount;

@end

@implementation LoginViewController

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
    self.loginView = [[LoginView alloc] init];
    self.loginView.backgroundColor = [UIColor whiteColor];
    self.loginView.loginViewDelegate = self;
    self.view = self.loginView;
}

- (void)loginView:(LoginView *)loginView loginButonCliked:(UIButton *)loginButton
{
    //[self facebook];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    [self navigateToViewController:homeViewController];
}

- (void)loadView
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

#pragma FB Related Tasks

- (void)facebook
{
    self.accountStore = [[ACAccountStore alloc]init];
    ACAccountType *FBaccountType= [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSString *key = @"451805654875339";
    NSDictionary *dictFB = [NSDictionary dictionaryWithObjectsAndKeys:key,ACFacebookAppIdKey,@[@"email"],ACFacebookPermissionsKey, nil];
    
    [self.accountStore requestAccessToAccountsWithType:FBaccountType options:dictFB completion:
     ^(BOOL granted, NSError *e) {
         if (granted)
         {
             NSArray *accounts = [self.accountStore accountsWithAccountType:FBaccountType];
             //it will always be the last object with single sign on
             self.facebookAccount = [accounts lastObject];
             
             
             ACAccountCredential *facebookCredential = [self.facebookAccount credential];
             NSString *accessToken = [facebookCredential oauthToken];
             //NSLog(@"Facebook Access Token: %@", accessToken);
             
             
            // NSLog(@"facebook account =%@",self.facebookAccount);
             
             [self get];
             
             //[self getFBFriends];
             
             isFacebookAvailable = 1;
         }
         else
         {
             //Fail gracefully...
             //NSLog(@"error getting permission yupeeeeeee %@",e);
             //sleep(10);
             isFacebookAvailable = 0;
             
         }
     }];
    
    
    
}

- (void)checkfacebookstatus
{
    if (isFacebookAvailable == 0)
    {
        //[self checkFacebook];
        isFacebookAvailable = 1;
    }
    else
    {
        printf("Get out from our game");
    }
}


- (void)get
{
    
    NSURL *requestURL = [NSURL URLWithString:@"https://graph.facebook.com/me"];
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:requestURL parameters:nil];
    request.account = self.facebookAccount;
    
    [request performRequestWithHandler:^(NSData *data, NSHTTPURLResponse *response, NSError *error) {
        
        if(!error)
        {
            
            NSDictionary *list =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            //NSLog(@"Dictionary contains: %@", list );
            
            
            
            
            //self.globalmailID   = [NSString stringWithFormat:@"%@",[list objectForKey:@"email"]];
            // NSLog(@"global mail ID : %@",globalmailID);
            
            
            NSString *fbname = [NSString stringWithFormat:@"%@",[list objectForKey:@"name"]];
            //NSLog(@"faceboooookkkk name %@",fbname);
            
            
            
            
            if([list objectForKey:@"error"]!=nil)
            {
                [self attemptRenewCredentials];
            }
            dispatch_async(dispatch_get_main_queue(),^{
                
            });
        }
        else
        {
            //handle error gracefully
           // NSLog(@"error from get%@",error);
            //attempt to revalidate credentials
        }
        
    }];
    
    self.accountStore = [[ACAccountStore alloc]init];
    ACAccountType *FBaccountType= [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSString *key = @"666533160157217";
    NSDictionary *dictFB = [NSDictionary dictionaryWithObjectsAndKeys:key,ACFacebookAppIdKey,@[@"friends_videos"],ACFacebookPermissionsKey, nil];
    
    
    [self.accountStore requestAccessToAccountsWithType:FBaccountType options:dictFB completion:
     ^(BOOL granted, NSError *e) {}];
    
}

-(void)accountChanged:(NSNotification *)notification
{
    [self attemptRenewCredentials];
}

-(void)attemptRenewCredentials
{
    [self.accountStore renewCredentialsForAccount:(ACAccount *)self.facebookAccount completion:^(ACAccountCredentialRenewResult renewResult, NSError *error){
        if(!error)
        {
            switch (renewResult) {
                case ACAccountCredentialRenewResultRenewed:
                   // NSLog(@"Good to go");
                    [self get];
                    break;
                case ACAccountCredentialRenewResultRejected:
                    //NSLog(@"User declined permission");
                    break;
                case ACAccountCredentialRenewResultFailed:
                   // NSLog(@"non-user-initiated cancel, you may attempt to retry");
                    break;
                default:
                    break;
            }
            
        }
        else{
            //handle error gracefully
           // NSLog(@"error from renew credentials%@",error);
        }
    }];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
