//
//  ViewController.m
//  LoginApi
//
//  Created by Muthuraj M on 12/29/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonLoginClick:(UIButton *)sender
{
    self.oAuthLoginView = [[OAuthLoginView alloc] initWithNibName:nil bundle:nil];
    
    // register to be told when the login is finished
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginViewDidFinish:)
                                                 name:@"loginViewDidFinish"
                                               object:self.oAuthLoginView];
    
    [self presentViewController:self.oAuthLoginView animated:YES completion:nil];
}

-(void) loginViewDidFinish:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // We're going to do these calls serially just for easy code reading.
    // They can be done asynchronously
    // Get the profile, then the network updates
    [self profileApiCall];
    
}


- (void)profileApiCall
{
    NSURL *url = [NSURL URLWithString:@"http://api.linkedin.com/v1/people/~"];
    OAMutableURLRequest *request =
    [[OAMutableURLRequest alloc] initWithURL:url
                                    consumer:self.oAuthLoginView.consumer
                                       token:self.oAuthLoginView.accessToken
                                    callback:nil
                           signatureProvider:nil];
    
    [request setValue:@"json" forHTTPHeaderField:@"x-li-format"];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(profileApiCallResult:didFinish:)
                  didFailSelector:@selector(profileApiCallResult:didFail:)];
    
}



- (void)profileApiCallResult:(OAServiceTicket *)ticket didFinish:(NSData *)data
{
    NSString *responseBody = [[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding];
    
    NSDictionary *profile = [responseBody objectFromJSONString];
    
    if ( profile )
    {
        
        [self.buttonLogin setHidden:YES];
        
        self.userName.text = [[NSString alloc] initWithFormat:@"%@ %@",
                              [profile objectForKey:@"firstName"], [profile objectForKey:@"lastName"]];
        
        self.headline.text = [profile objectForKey:@"headline"];
    }
    
    // The next thing we want to do is call the network updates
    [self networkApiCall];
    
}

- (void)profileApiCallResult:(OAServiceTicket *)ticket didFail:(NSData *)error
{
    NSLog(@"%@",[error description]);
}

- (void)networkApiCall
{
    NSURL *url = [NSURL URLWithString:@"http://api.linkedin.com/v1/people/~/network/updates?scope=self&count=1&type=STAT"];
    OAMutableURLRequest *request =
    [[OAMutableURLRequest alloc] initWithURL:url
                                    consumer:self.oAuthLoginView.consumer
                                       token:self.oAuthLoginView.accessToken
                                    callback:nil
                           signatureProvider:nil];
    
    [request setValue:@"json" forHTTPHeaderField:@"x-li-format"];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(networkApiCallResult:didFinish:)
                  didFailSelector:@selector(networkApiCallResult:didFail:)];
    
}

- (void)networkApiCallResult:(OAServiceTicket *)ticket didFinish:(NSData *)data
{
    NSString *responseBody = [[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding];
    
    NSDictionary *person = [[[[[responseBody objectFromJSONString]
                               objectForKey:@"values"]
                              objectAtIndex:0]
                             objectForKey:@"updateContent"]
                            objectForKey:@"person"];
    
    
    if ( [person objectForKey:@"currentStatus"] )
    {
        [self.buttonPost setHidden:false];
        [self.buttonLogout setHidden:false];
        [self.statusTextView setHidden:false];
        [self.updateStatusLabel setHidden:false];
        self.status.text = [person objectForKey:@"currentStatus"];
    }
    else
    {
        [self.buttonPost setHidden:false];
        [self.buttonLogout setHidden:false];
        [self.statusTextView setHidden:false];
        [self.updateStatusLabel setHidden:false];
        self.status.text = [[[[person objectForKey:@"personActivities"]
                              objectForKey:@"values"]
                             objectAtIndex:0]
                            objectForKey:@"body"];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)networkApiCallResult:(OAServiceTicket *)ticket didFail:(NSData *)error
{
    NSLog(@"%@",[error description]);
}



- (IBAction)buttonPostStatusClick:(UIButton *)sender
{
    [self.statusTextView resignFirstResponder];
    NSURL *url = [NSURL URLWithString:@"http://api.linkedin.com/v1/people/~/shares"];
    OAMutableURLRequest *request =
    [[OAMutableURLRequest alloc] initWithURL:url
                                    consumer:self.oAuthLoginView.consumer
                                       token:self.oAuthLoginView.accessToken
                                    callback:nil
                           signatureProvider:nil];
    
    NSDictionary *update = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[NSDictionary alloc]
                             initWithObjectsAndKeys:
                             @"anyone",@"code",nil], @"visibility",
                            self.statusTextView.text, @"comment", nil];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *updateString = [update JSONString];
    
    [request setHTTPBodyWithString:updateString];
    [request setHTTPMethod:@"POST"];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(postUpdateApiCallResult:didFinish:)
                  didFailSelector:@selector(postUpdateApiCallResult:didFail:)];
    
}

- (void)postUpdateApiCallResult:(OAServiceTicket *)ticket didFinish:(NSData *)data
{
    // The next thing we want to do is call the network updates
    [self networkApiCall];
    
}

- (void)postUpdateApiCallResult:(OAServiceTicket *)ticket didFail:(NSData *)error
{
    NSLog(@"%@",[error description]);
}

- (IBAction)buttonLogoutClick:(id)sender
{
    
    [self.buttonLogin setHidden:NO];
    
    NSString *tokenKey = @"";
    
    [[NSUserDefaults standardUserDefaults] setObject:tokenKey forKey:@"TokenKey"];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    UIAlertView *logoutMessageAlert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Logout Sucessfully !" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [logoutMessageAlert show];
    
}
- See more at: http://www.oodlestechnologies.com/blogs/Linkedin-Integration-in-Native-iOS#sthash.qj4PBm1I.dpuf

@end
