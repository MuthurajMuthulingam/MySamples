//
//  BaseViewController.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@property (nonatomic,strong) BaseView *baseView;

@end

@implementation BaseViewController

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
    self.baseView = [[BaseView alloc] init];
    self.view = self.baseView;
}

- (void)loadView
{
    [super loadView];
    
}

- (void)navigateToViewController:(UIViewController *)viewControllerToNavigate
{
    [self.navigationController pushViewController:viewControllerToNavigate animated:YES];
}

- (void)showMessageInAlert:(NSString *)alertTitle andMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
